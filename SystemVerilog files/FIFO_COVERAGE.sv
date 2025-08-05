package fifo_coverage_pack;
import uvm_pkg::*;
`include "uvm_macros.svh"
import fifo_sequence_item_pack::*;
import fifo_pack::*;

	class fifo_coverage extends  uvm_component;
		`uvm_component_utils(fifo_coverage)

fifo_sequence_item sequence_item_coverage;
uvm_analysis_export #(fifo_sequence_item) coverage_export;
uvm_tlm_analysis_fifo #(fifo_sequence_item) coverage_uvm_fifo;

		bit cv_clk;
        bit cv_wr;
        bit cv_rd;
        bit cv_full;
        bit cv_empty;
        bit cv_almostfull;
        bit cv_almostempty;
        bit cv_ov;
        bit cv_un;
        bit cv_wr_ack;
			

covergroup fifo_cvgroup;

 
cv_wr_f_e:cross cv_wr,cv_full,cv_empty
{
bins wr_full_high= binsof(cv_wr) intersect {1} && binsof(cv_full) intersect {1};
bins wr_empty_high= binsof(cv_wr) intersect {1} && binsof(cv_empty) intersect {1};
bins wr_full_low= binsof(cv_wr) intersect {1} && binsof(cv_full) intersect {0};
bins wr_empty_low= binsof(cv_wr) intersect {1} && binsof(cv_empty) intersect {0};
option.cross_auto_bin_max=0;
}


cv_rd_f_e:cross cv_rd,cv_full,cv_empty
{

bins rd_full_high= binsof(cv_rd) intersect {1} && binsof(cv_full) intersect {1};
bins rd_empty_high= binsof(cv_rd) intersect {1} && binsof(cv_empty) intersect {1};

bins rd_full_low= binsof(cv_rd) intersect {1} && binsof(cv_full) intersect {0};
bins rd_empty_low= binsof(cv_rd) intersect {1} && binsof(cv_empty) intersect {0};
option.cross_auto_bin_max=0;
}


cv_wr_rd_almostf_almoste:cross cv_wr,cv_rd,cv_almostfull,cv_almostempty
{
bins wr_almostfull_high= binsof(cv_wr) intersect {1} && binsof(cv_almostfull) intersect {1};
bins wr_almostempty_high= binsof(cv_wr) intersect {1} && binsof(cv_almostempty) intersect {1};

bins rd_almostfull_high= binsof(cv_rd) intersect {1} && binsof(cv_almostfull) intersect {1};
bins rd_almostempty_high= binsof(cv_rd) intersect {1} && binsof(cv_almostempty) intersect {1};

bins wr_almostfull_low= binsof(cv_wr) intersect {1} && binsof(cv_almostfull) intersect {0};
bins wr_almostempty_low= binsof(cv_wr) intersect {1} && binsof(cv_almostempty) intersect {0};

bins rd_almostfull_low= binsof(cv_rd) intersect {1} && binsof(cv_almostfull) intersect {0};
bins rd_almostempty_low= binsof(cv_rd) intersect {1} && binsof(cv_almostempty) intersect {0};
	
	option.cross_auto_bin_max=0;
}

cv_wr_rd_ov_un:cross cv_wr,cv_rd,cv_ov,cv_un
{
bins wr_ovf_high= binsof(cv_wr) intersect {1} && binsof(cv_ov) intersect {1};
bins wr_unf_high= binsof(cv_wr) intersect {1} && binsof(cv_un) intersect {1};

bins rd_ovf_high= binsof(cv_rd) intersect {1} && binsof(cv_ov) intersect {1};
bins rd_unf_high= binsof(cv_rd) intersect {1} && binsof(cv_un) intersect {1};

bins wr_ovf_low= binsof(cv_wr) intersect {1} && binsof(cv_ov) intersect {0};
bins wr_unf_low= binsof(cv_wr) intersect {1} && binsof(cv_un) intersect {0};

bins rd_ovf_low= binsof(cv_rd) intersect {1} && binsof(cv_ov) intersect {0};
bins rd_unf_low= binsof(cv_rd) intersect {1} && binsof(cv_un) intersect {0};
	option.cross_auto_bin_max=0;
}


cv_wr_rd_wrack:cross cv_wr,cv_rd,cv_wr_ack
{
	bins wr_ack_high= binsof(cv_wr) intersect {1} && binsof(cv_wr_ack) intersect {1};
	bins wr_ack_low= binsof(cv_wr) intersect {1} && binsof(cv_wr_ack) intersect {0};
	
	bins rd_ack_high= binsof(cv_rd) intersect {1} && binsof(cv_wr_ack) intersect {1};
	bins rd_ack_low= binsof(cv_rd) intersect {1} && binsof(cv_wr_ack) intersect {0};
	option.cross_auto_bin_max=0;
}

endgroup 



function new (string name="fifo_coverage",uvm_component parent = null);
super.new(name,parent);
fifo_cvgroup=new();
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);	
coverage_export=new("coverage_export",this);
coverage_uvm_fifo=new("coverage_uvm_fifo",this);
endfunction 


function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);	
coverage_export.connect(coverage_uvm_fifo.analysis_export);
endfunction 


task run_phase(uvm_phase phase);
	super.run_phase(phase);	

	forever begin
		coverage_uvm_fifo.get(sequence_item_coverage);

            cv_wr = sequence_item_coverage.wr_en_rand;
            cv_rd = sequence_item_coverage.rd_en_rand;
            cv_full = sequence_item_coverage.full_transc;
            cv_empty = sequence_item_coverage.empty_transc;
            cv_almostfull = sequence_item_coverage.almostfull_transc;
            cv_almostempty = sequence_item_coverage.almostempty_transc;
            cv_ov = sequence_item_coverage.overflow_transc;
            cv_un = sequence_item_coverage.underflow_transc;
            cv_wr_ack = sequence_item_coverage.wr_ack_transc;
            

		fifo_cvgroup.sample();
			end
	
endtask : run_phase


	endclass : fifo_coverage
	
endpackage 