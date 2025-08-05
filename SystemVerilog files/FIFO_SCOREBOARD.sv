package fifo_scoreboard_pack;
import uvm_pkg::*;
`include "uvm_macros.svh"
import fifo_sequence_item_pack::*;
import fifo_pack::*;


class fifo_scoreboard extends  uvm_scoreboard;
`uvm_component_utils(fifo_scoreboard)

fifo_sequence_item sequence_item_scoreboard;
uvm_analysis_export #(fifo_sequence_item) scoreboard_export;
uvm_tlm_analysis_fifo #(fifo_sequence_item) scoreboard_fifo;

logic [FIFO_WIDTH-1:0] fifo_queue[$];
logic [FIFO_WIDTH-1:0] data_out_ref,data_in_ref;
bit wr_en_ref, rd_en_ref,rst_n_ref,full_ref,empty_ref;
static int count_ref=0; 

int error_count=0;
int correct_count=0;

function new(string name ="fifo_scoreboard",uvm_component parent =null);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);	
scoreboard_export=new("scoreboard_export",this);
scoreboard_fifo=new("scoreboard_fifo",this);
endfunction 

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
	
	scoreboard_export.connect(scoreboard_fifo.analysis_export);
endfunction 

task run_phase(uvm_phase phase);
	super.run_phase(phase);

	forever begin
		scoreboard_fifo.get(sequence_item_scoreboard);
		ref_model(sequence_item_scoreboard);
		
		 if (sequence_item_scoreboard.data_out !== data_out_ref) begin
			$display("------------------------");
      `uvm_error("run_phase",$sformatf("Comparison Failed !!, Transac. sent to the dut is:%s",
				sequence_item_scoreboard.convert2string()));
      $display("data_out_ref=%0h",data_out_ref);
      $display("DUT data_out=%0h",sequence_item_scoreboard.data_out);
      $display("------------------------");
			error_count++;
		end
		else begin
      $display("------------------------");
			`uvm_info("run_phase",$sformatf("Correct , Transac. sent to the dut is:%s",
				sequence_item_scoreboard.convert2string()),UVM_LOW);
			$display("data_out_ref=%0h",data_out_ref);
      $display("DUT data_out=%0h",sequence_item_scoreboard.data_out);
      $display("------------------------");
			correct_count++;
		end



		end
	
endtask : run_phase




task ref_model(fifo_sequence_item ref_item);
 
data_in_ref=ref_item.data_in_rand;
	 wr_en_ref=ref_item.wr_en_rand;
	 rd_en_ref=ref_item.rd_en_rand;
	 rst_n_ref=ref_item.rst_n_rand;
	 

if (rst_n_ref == 0) begin
	wr_en_ref=0;
	rd_en_ref=0;
	count_ref=0;
	fifo_queue.delete();
	data_out_ref=ref_item.data_out;
	
end
else if ((wr_en_ref && (count_ref < FIFO_DEPTH)) || (rd_en_ref && (count_ref == 0) && wr_en_ref) ) begin
     fifo_queue.push_back(data_in_ref);
     data_out_ref=ref_item.data_out;
	 count_ref++;
end
else if ((rd_en_ref && (count_ref > 0) &&(!wr_en_ref))|| (rd_en_ref && (count_ref ==FIFO_DEPTH)&&wr_en_ref)) begin
	 data_out_ref=fifo_queue.pop_front();
     count_ref--;
end
else data_out_ref=ref_item.data_out;

if (count_ref == FIFO_DEPTH) ref_item.full_transc=1;
if (count_ref == 0) ref_item.empty_transc=1;
if (count_ref == 1) ref_item.almostempty_transc=1;
if (count_ref == 7) ref_item.almostfull_transc=1;
	


endtask : ref_model


function void report_phase(uvm_phase phase);
	super.report_phase(phase);
	`uvm_info("report_phase",$sformatf("Correct_count:%0d",correct_count),UVM_MEDIUM);
	`uvm_info("report_phase",$sformatf("Error_count:%0d",error_count),UVM_MEDIUM);
endfunction 
	
endclass : fifo_scoreboard
endpackage : fifo_scoreboard_pack


