package fifo_sequence_item_pack;

import uvm_pkg::*;
`include "uvm_macros.svh"
import fifo_pack::*;


class fifo_sequence_item extends  uvm_sequence_item;
	`uvm_object_utils(fifo_sequence_item)


		int RD_EN_ON_DIST;
		int WR_EN_ON_DIST;

function new (int RD=30,int WR=70,string name ="fifo_sequence_item");
	super.new(name);
	this.RD_EN_ON_DIST=RD;
 	this.WR_EN_ON_DIST=WR;
endfunction 


function string convert2string();
return $sformatf("%s rst_n=%b,wr_en=%b,rd_en=%b,data_in=%0h,data_out=%0h,count=%0d,wr_ack=%b,full=%b,empty=%b,overflow=%b,underflow=%b,almostfull=%b,almostempty=%b",
				super.convert2string(),
				rst_n_rand,wr_en_rand,rd_en_rand,
				data_in_rand,data_out,count,
				wr_ack_transc,full_transc,empty_transc,
				overflow_transc,underflow_transc,
				almostfull_transc,almostempty_transc);
endfunction 



function string convert2string_stim();
return $sformatf("rst_n=%b,wr_en=%b,rd_en=%b,data_in=%0h,data_out=%0h,count=%0d,wr_ack=%b,full=%b,empty=%b,overflow=%b,underflow=%b,almostfull=%b,almostempty=%b",
				rst_n_rand,wr_en_rand,rd_en_rand,
				data_in_rand,data_out,count,
				wr_ack_transc,full_transc,empty_transc,
				overflow_transc,underflow_transc,
				almostfull_transc,almostempty_transc);
endfunction 



bit full_transc,empty_transc,almostfull_transc,almostempty_transc,wr_ack_transc, overflow_transc,underflow_transc;

rand logic [FIFO_WIDTH-1:0]data_in_rand;
logic [FIFO_WIDTH-1:0] data_out;
rand bit rst_n_rand,wr_en_rand,rd_en_rand;
bit clock_transc;
logic [3:0] count;

constraint rst_constraint {rst_n_rand dist{1'b0:=10,1'b1:=90};}
constraint write_constraint {wr_en_rand dist{1'b0:=(100-WR_EN_ON_DIST),1'b1:=WR_EN_ON_DIST};}
constraint read_constraint {rd_en_rand dist{1'b0:=(100-RD_EN_ON_DIST),1'b1:=RD_EN_ON_DIST};}
constraint data_in_constraint {data_in_rand inside {[0:16'hFFFF]};}


endclass : fifo_sequence_item
	
endpackage : fifo_sequence_item_pack