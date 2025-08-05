

interface FIFO_INTERF(clk);
import fifo_pack::*;
input  clk;

logic [(FIFO_WIDTH-1):0] data_in;
bit rst_n, wr_en, rd_en;
logic  [(FIFO_WIDTH-1):0] data_out;
logic wr_ack, overflow;
bit full, empty, almostfull, almostempty;
logic underflow; 
 

localparam max_fifo_addr = $clog2(FIFO_DEPTH);
logic [max_fifo_addr-1:0] wr_ptr, rd_ptr;
logic [max_fifo_addr:0] count; 


modport FIFO_DUT_MODE (input clk,data_in, wr_en, rd_en, rst_n,output full, empty, almostfull, almostempty, wr_ack, overflow, underflow, data_out,count,wr_ptr,rd_ptr);
endinterface