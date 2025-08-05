package fifo_test_pack;
import uvm_pkg::*;
`include "uvm_macros.svh"

import fifo_env_pack::*;
import fifo_config_pack::*;
import fifo_sequencer_pack::*;
import fifo_1_sequence_pack::*;
import fifo_2_sequence_pack::*;
import fifo_3_and_4_sequence_pack::*;
import fifo_5_sequence_pack::*;
import fifo_6_sequence_pack::*;

import fifo_agent_pack::*;

class fifo_test extends uvm_test;
`uvm_component_utils(fifo_test)

fifo_env env;
fifo_config fifo_config_obj;

FIFO_1_sequence fifo_1_sequence;
FIFO_2_sequence fifo_2_sequence;
FIFO_3_and_4_sequence fifo_3_and_4_sequence;
FIFO_5_sequence fifo_5_sequence;
FIFO_6_sequence fifo_6_sequence;

function new (string name="fifo_test",uvm_component parent = null);
super.new(name,parent);
endfunction


function void build_phase (uvm_phase phase);
super.build_phase(phase);
env=fifo_env::type_id::create("env",this);
fifo_config_obj=fifo_config::type_id::create("fifo_config_obj");
fifo_1_sequence=FIFO_1_sequence::type_id::create("fifo_1_sequence",this);
fifo_2_sequence=FIFO_2_sequence::type_id::create("fifo_2_sequence",this);
fifo_3_and_4_sequence=FIFO_3_and_4_sequence::type_id::create("fifo_3_and_4_sequence",this);
fifo_5_sequence=FIFO_5_sequence::type_id::create("fifo_5_sequence",this);
fifo_6_sequence=FIFO_6_sequence::type_id::create("fifo_6_sequence",this);


if (!(uvm_config_db#(virtual FIFO_INTERF)::get(this,"","FIFO_INTERF",fifo_config_obj.fifo_vinterf))) 
	`uvm_fatal("build_phase","Unable to get the FIFO_INTERF");


	uvm_config_db#(fifo_config)::set(this,"*","FIFO_CONFIG_OBJ",fifo_config_obj);
endfunction



task run_phase (uvm_phase phase);
super.run_phase(phase);
phase.raise_objection(this);
`uvm_info("run_phase","Reset asserted",UVM_LOW)
fifo_1_sequence.start(env.fifo_agent_obj.fifo_sequencer_obj);
`uvm_info("run_phase","Reset deasserted",UVM_LOW)

`uvm_info("run_phase","FIFO_2 Transaction generation started",UVM_LOW)
fifo_2_sequence.start(env.fifo_agent_obj.fifo_sequencer_obj);
`uvm_info("run_phase","FIFO_2 Transaction generation ended",UVM_LOW)

`uvm_info("run_phase","FIFO_3 & FIFO_4 Transaction generation started",UVM_LOW)
fifo_3_and_4_sequence.start(env.fifo_agent_obj.fifo_sequencer_obj);
`uvm_info("run_phase","FIFO_3 & FIFO_4 Transaction generation ended",UVM_LOW)

`uvm_info("run_phase","FIFO_5 Transaction generation started",UVM_LOW)
fifo_5_sequence.start(env.fifo_agent_obj.fifo_sequencer_obj);
`uvm_info("run_phase","FIFO_5 Transaction generation ended",UVM_LOW)


`uvm_info("run_phase","FIFO_6 Transaction generation started",UVM_LOW)
fifo_6_sequence.start(env.fifo_agent_obj.fifo_sequencer_obj);
`uvm_info("run_phase","FIFO_6 Transaction generation ended",UVM_LOW)

phase.drop_objection(this);
endtask

endclass
endpackage
 