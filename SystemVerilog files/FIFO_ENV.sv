package fifo_env_pack;
	import uvm_pkg::*;
`include "uvm_macros.svh"
import fifo_agent_pack::*;
import fifo_scoreboard_pack::*;
import fifo_coverage_pack::*;

class fifo_env extends uvm_env;
`uvm_component_utils(fifo_env)

function new (string name="fifo_env",uvm_component parent = null);
super.new(name,parent);
endfunction


fifo_agent fifo_agent_obj;
fifo_scoreboard fifo_scoreboard_obj;
fifo_coverage fifo_coverage_obj;


function void build_phase(uvm_phase phase);
super.build_phase(phase);	
fifo_agent_obj=fifo_agent::type_id::create("fifo_agent_obj",this);
fifo_scoreboard_obj=fifo_scoreboard::type_id::create("fifo_scoreboard_obj",this);
fifo_coverage_obj=fifo_coverage::type_id::create("fifo_coverage_obj",this);


endfunction 

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);

	fifo_agent_obj.agent_anal_port.connect(fifo_coverage_obj.coverage_export);
	fifo_agent_obj.agent_anal_port.connect(fifo_scoreboard_obj.scoreboard_export);
	
endfunction 



endclass





endpackage : fifo_env_pack