package fifo_driver_pack;
import fifo_sequence_item_pack::*;

import fifo_config_pack::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_driver extends uvm_driver#(fifo_sequence_item);
	`uvm_component_utils(fifo_driver);

fifo_sequence_item sequence_item_obj;

virtual FIFO_INTERF fifo_vinterf;
function new (string name="fifo_driver",uvm_component parent = null);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
        sequence_item_obj = fifo_sequence_item::type_id::create("sequence_item_obj");


        seq_item_port.get_next_item(sequence_item_obj);
        fifo_vinterf.rst_n= sequence_item_obj.rst_n_rand;
        fifo_vinterf.wr_en= sequence_item_obj.wr_en_rand;
        fifo_vinterf.rd_en= sequence_item_obj.rd_en_rand;
        fifo_vinterf.data_in= sequence_item_obj.data_in_rand;
        
        @(negedge fifo_vinterf.clk);
        seq_item_port.item_done();
        `uvm_info("run_phase",sequence_item_obj.convert2string_stim(),UVM_HIGH)
    end

endtask

endclass

	
endpackage : fifo_driver_pack