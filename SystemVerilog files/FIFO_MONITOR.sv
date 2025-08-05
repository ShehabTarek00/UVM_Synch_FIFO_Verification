package fifo_monitor_pack;
	import uvm_pkg::*;
`include "uvm_macros.svh"

import fifo_sequence_item_pack::*;




class fifo_monitor extends  uvm_monitor;
	`uvm_component_utils(fifo_monitor);

virtual FIFO_INTERF fifo_vinterf;
fifo_sequence_item fifo_sequence_item_obj;

uvm_analysis_port#(fifo_sequence_item) monitor_anal_port;

function new (string name="fifo_monitor",uvm_component parent = null);
super.new(name,parent);
endfunction

function void build_phase (uvm_phase phase);
super.build_phase(phase);
monitor_anal_port=new("monitor_anal_port",this);
endfunction



task run_phase(uvm_phase phase);
	super.run_phase(phase);
forever begin
	fifo_sequence_item_obj=fifo_sequence_item::type_id::create("fifo_sequence_item_obj");

@(negedge fifo_vinterf.clk);


fifo_sequence_item_obj.rst_n_rand = fifo_vinterf.rst_n;
fifo_sequence_item_obj.wr_en_rand = fifo_vinterf.wr_en;
fifo_sequence_item_obj.wr_ack_transc = fifo_vinterf.wr_ack;
fifo_sequence_item_obj.rd_en_rand = fifo_vinterf.rd_en;
fifo_sequence_item_obj.full_transc = fifo_vinterf.full;
fifo_sequence_item_obj.empty_transc = fifo_vinterf.empty;
fifo_sequence_item_obj.almostfull_transc = fifo_vinterf.almostfull;
fifo_sequence_item_obj.almostempty_transc = fifo_vinterf.almostempty;
fifo_sequence_item_obj.overflow_transc = fifo_vinterf.overflow;
fifo_sequence_item_obj.underflow_transc = fifo_vinterf.underflow;

fifo_sequence_item_obj.data_in_rand = fifo_vinterf.data_in;
fifo_sequence_item_obj.data_out = fifo_vinterf.data_out;
fifo_sequence_item_obj.count=fifo_vinterf.count;



monitor_anal_port.write(fifo_sequence_item_obj);
`uvm_info("run_phase",fifo_sequence_item_obj.convert2string(),UVM_HIGH);
end

endtask : run_phase


	
endclass : fifo_monitor

	
endpackage : fifo_monitor_pack