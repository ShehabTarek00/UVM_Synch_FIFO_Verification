package fifo_5_sequence_pack;
	
	import fifo_sequence_item_pack::*;

import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_5_sequence extends  uvm_sequence #(fifo_sequence_item);
	`uvm_object_utils(FIFO_5_sequence)
fifo_sequence_item fifo_sequence_item_obj;

	function new(string name = "FIFO_5_sequence");
		super.new(name);
	endfunction 


task body();

	repeat (10) begin  
		fifo_sequence_item_obj=fifo_sequence_item::type_id::create("fifo_sequence_item_obj");
		start_item(fifo_sequence_item_obj);
		assert(fifo_sequence_item_obj.randomize() with {wr_en_rand==0; 
								rd_en_rand==1;rst_n_rand==1;});          
		
		finish_item(fifo_sequence_item_obj);
	end


endtask : body





endclass 
endpackage
