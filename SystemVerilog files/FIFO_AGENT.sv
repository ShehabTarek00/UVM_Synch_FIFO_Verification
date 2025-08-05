package fifo_agent_pack;
import uvm_pkg::*;
`include "uvm_macros.svh"

import fifo_sequence_item_pack::*;
import fifo_sequencer_pack::*;
import fifo_driver_pack::*;
import fifo_monitor_pack::*;
import fifo_config_pack::*;


class fifo_agent extends  uvm_agent;
`uvm_component_utils(fifo_agent)

fifo_sequencer fifo_sequencer_obj;
fifo_driver driver_obj;
fifo_monitor fifo_monitor_obj;

fifo_config fifo_config_obj;
uvm_analysis_port #(fifo_sequence_item)  agent_anal_port;


function new(string name ="fifo_agent",uvm_component parent =null);
	super.new(name,parent);
endfunction 

	
function void build_phase(uvm_phase phase);
super.build_phase(phase);	
if (!(uvm_config_db#(fifo_config)::get(this,"","FIFO_CONFIG_OBJ",fifo_config_obj)))
	`uvm_fatal("build_phase","Unable to get the FIFO_CONFIG_OBJ");
	

driver_obj=fifo_driver::type_id::create("driver_obj",this);
fifo_sequencer_obj =fifo_sequencer::type_id::create("fifo_sequencer_obj",this);
fifo_monitor_obj=fifo_monitor::type_id::create("fifo_monitor_obj",this);
agent_anal_port=new("agent_anal_port",this);
endfunction 

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);

	driver_obj.fifo_vinterf=fifo_config_obj.fifo_vinterf;
	fifo_monitor_obj.fifo_vinterf=fifo_config_obj.fifo_vinterf;
	driver_obj.seq_item_port.connect(fifo_sequencer_obj.seq_item_export);
	fifo_monitor_obj.monitor_anal_port.connect(agent_anal_port);

endfunction 

endclass 

	
endpackage : fifo_agent_pack