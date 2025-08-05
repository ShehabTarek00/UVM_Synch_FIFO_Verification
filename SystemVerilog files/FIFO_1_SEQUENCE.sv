package fifo_1_sequence_pack;
	
	import fifo_sequence_item_pack::*;

import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_1_sequence extends  uvm_sequence #(fifo_sequence_item);
	`uvm_object_utils(FIFO_1_sequence)
fifo_sequence_item fifo_sequence_item_obj;



	function new(string name = "FIFO_1_sequence");
		super.new(name);
	endfunction 


task body();
	fifo_sequence_item_obj=fifo_sequence_item::type_id::create("fifo_sequence_item_obj");
start_item(fifo_sequence_item_obj);

		assert(fifo_sequence_item_obj.randomize() with {data_in_rand==16'h0BCC;wr_en_rand==0; 
								rd_en_rand==0;rst_n_rand==0;});         
		
		
		
finish_item(fifo_sequence_item_obj);
endtask : body





endclass 
endpackage
