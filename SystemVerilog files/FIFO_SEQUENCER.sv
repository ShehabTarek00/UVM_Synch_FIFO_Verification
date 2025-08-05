package fifo_sequencer_pack;
	import uvm_pkg::*;
`include "uvm_macros.svh"
import fifo_sequence_item_pack::*;


	class fifo_sequencer extends  uvm_sequencer #(fifo_sequence_item);
`uvm_component_utils(fifo_sequencer)

function new(string name ="fifo_sequencer",uvm_component parent =null);
	super.new(name,parent);
endfunction 


	endclass : fifo_sequencer
	
endpackage : fifo_sequencer_pack
