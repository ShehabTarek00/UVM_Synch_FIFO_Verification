package fifo_3_and_4_sequence_pack;
	
	import fifo_sequence_item_pack::*;

import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_3_and_4_sequence extends  uvm_sequence #(fifo_sequence_item);
	`uvm_object_utils(FIFO_3_and_4_sequence)
fifo_sequence_item fifo_sequence_item_obj;

	function new(string name = "FIFO_3_and_4_sequence");
		super.new(name);
	endfunction 


task body();

	  for (int i = 0; i < 10; i++) begin
	  fifo_sequence_item_obj=fifo_sequence_item::type_id::create("fifo_sequence_item_obj");
	  start_item(fifo_sequence_item_obj);  
		assert(fifo_sequence_item_obj.randomize() with {wr_en_rand==1; 
								rd_en_rand==0;rst_n_rand==1;});         
		
		
		


		if (i == 8) begin
			assert(fifo_sequence_item_obj.randomize() with {wr_en_rand==1; 
								rd_en_rand==1;rst_n_rand==1;});         
	
		
		
		end

		finish_item(fifo_sequence_item_obj);

	end
endtask : body





endclass 
endpackage 
