
module FIFO_TOP;
import uvm_pkg::*;
`include "uvm_macros.svh"
import fifo_test_pack::*;

bit clk;

initial begin
    clk = 0;
    forever begin
      #1 clk =~clk;
    end
  end


FIFO_INTERF fifo_interf(clk);

FIFO fifo_dut(fifo_interf);

initial begin
  uvm_config_db#(virtual FIFO_INTERF)::set(null,"uvm_test_top","FIFO_INTERF",fifo_interf);
  run_test("fifo_test");
end

bind FIFO fifo_sva fifo_sva_inst(fifo_interf);


endmodule : FIFO_TOP