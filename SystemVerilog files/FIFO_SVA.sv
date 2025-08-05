

module fifo_sva (FIFO_INTERF.FIFO_DUT_MODE fifo_interface);
import fifo_pack::*;
bit clk;

logic [(FIFO_WIDTH-1):0] data_in;
bit rst_n, wr_en, rd_en;
logic  [(FIFO_WIDTH-1):0] data_out;
logic wr_ack, overflow;
bit full, empty, almostfull, almostempty;
logic underflow;


localparam max_fifo_addr = $clog2(FIFO_DEPTH);
logic [max_fifo_addr-1:0] wr_ptr, rd_ptr;
logic [max_fifo_addr:0] count; 

assign clk=fifo_interface.clk;
assign rst_n=fifo_interface.rst_n;

assign data_in=fifo_interface.data_in;
assign data_out=fifo_interface.data_out;

assign wr_en=fifo_interface.wr_en;
assign wr_ack=fifo_interface.wr_ack;
assign rd_en=fifo_interface.rd_en;

assign overflow=fifo_interface.overflow;
assign underflow=fifo_interface.underflow;

assign full=fifo_interface.full;
assign empty=fifo_interface.empty;

assign almostfull=fifo_interface.almostfull;
assign almostempty=fifo_interface.almostempty;

assign count=fifo_interface.count;

assign wr_ptr=fifo_interface.wr_ptr;
assign rd_ptr=fifo_interface.rd_ptr;



 property reset_flags_property;
  @(posedge clk) disable iff(rst_n) (rst_n == 0) |=> (full == 0 && empty== 1 && almostfull== 0 && almostempty== 0 );
endproperty



 property reset_regs_property;
  @(posedge clk) disable iff(rst_n) (rst_n == 0) |=> (overflow == 0 && underflow== 0 && wr_ack== 0 && wr_ptr== 0 && rd_ptr== 0 && count== 0);
endproperty


 property full_property;
  @(posedge clk) disable iff(!rst_n) (count == FIFO_DEPTH) |-> (full == 1);
endproperty


 property empty_property;
  @(posedge clk) (count== 0) |-> (empty== 1);
endproperty


 property almostfull_property;
  @(posedge clk) disable iff(!rst_n)(count == FIFO_DEPTH-1) |-> (almostfull== 1);
endproperty


 property almostempty_property;
  @(posedge clk) disable iff(!rst_n)(count == 1) |-> (almostempty== 1);
endproperty


 property ov_property;
  @(posedge clk) disable iff(!rst_n)(count == FIFO_DEPTH &&(wr_en == 1)) |=> (overflow== 1);
endproperty


 property un_property;
  @(posedge clk) disable iff(!rst_n)(count== 0 &&(rd_en == 1)) |=> (underflow== 1);
endproperty


 property wr_ack_property;
  @(posedge clk) disable iff(!rst_n) ((wr_en && (count < FIFO_DEPTH)) || (rd_en && (count == 0) && wr_en)) |=> (wr_ack== 1);
endproperty

assert property(reset_regs_property); cover property(reset_regs_property);
assert property(reset_flags_property); cover property(reset_flags_property);

assert property(full_property); cover property(full_property);
assert property(empty_property); cover property(empty_property);

assert property(almostfull_property); cover property(almostfull_property);
assert property(almostempty_property); cover property(almostempty_property);

assert property(ov_property); cover property(ov_property);
assert property(un_property); cover property(un_property);

assert property(wr_ack_property); cover property(wr_ack_property);



endmodule : fifo_sva