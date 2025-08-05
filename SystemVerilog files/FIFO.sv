
import fifo_pack::*;

module FIFO(FIFO_INTERF.FIFO_DUT_MODE fifo_interf);

logic [(FIFO_WIDTH-1):0]data_in;
logic wr_ack,overflow,underflow;
logic [(FIFO_WIDTH-1):0]data_out;
bit clk,rst_n,wr_en,rd_en,full,empty,almostfull,almostempty;
 
 assign data_in=fifo_interf.data_in;
 assign clk=fifo_interf.clk;
 assign rst_n=fifo_interf.rst_n;
 assign wr_en=fifo_interf.wr_en;
 assign rd_en=fifo_interf.rd_en;

 assign fifo_interf.wr_ack=wr_ack;
 assign fifo_interf.overflow=overflow;
 assign fifo_interf.full=full;
 assign fifo_interf.empty=empty;
 assign fifo_interf.almostfull=almostfull;
 assign fifo_interf.almostempty=almostempty;
 assign fifo_interf.underflow=underflow; 
 assign fifo_interf.data_out=data_out;


localparam max_fifo_addr = $clog2(FIFO_DEPTH); 
logic [max_fifo_addr-1:0] wr_ptr, rd_ptr;
logic [max_fifo_addr:0] count; 

assign fifo_interf.wr_ptr=wr_ptr;
assign fifo_interf.rd_ptr=rd_ptr;
assign fifo_interf.count=count;

logic [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0]; 
///////////////////////////////////////////////////////

always @(posedge clk or negedge rst_n) begin//always block of the writing 
	if (!rst_n) begin    ///// reseting all the registers /////
		wr_ptr <= 0;
		rd_ptr <= 0;
		count<=0;
		underflow<=0;
		overflow<=0;
		wr_ack<=0;  
	end
	else if ((wr_en && (count < FIFO_DEPTH)) || (rd_en && (count == 0) && wr_en)) begin
		
		mem[wr_ptr] <= data_in;
		wr_ack <= 1; 
		wr_ptr <= wr_ptr + 1;
		
	end
	else begin 
		wr_ack <= 0; 
	
		if (full & wr_en)begin
			overflow <= 1;
			
		end
			
		else begin
			overflow <= 0;
			
		end
			
	end
end

///////////////////////////////////////////////////////

always @(posedge clk or negedge rst_n) begin//always block of the reading
	if (!rst_n) begin   ///// reseting all the registers /////
		wr_ptr <= 0;
		rd_ptr <= 0;
		count<=0;
		underflow<=0;
		overflow<=0;
		wr_ack<=0;       
	end
	else if ((rd_en && (count > 0) &&(!wr_en))  || (rd_en && (count == FIFO_DEPTH) &&wr_en)) begin
		data_out <= mem[rd_ptr];
		rd_ptr <= rd_ptr + 1;
	end
	else begin
		if (empty & rd_en)begin
			underflow <= 1;
		end
			
		else begin
			underflow <= 0;
		end
			
	end
end

///////////////////////////////////////////////////////

always @(posedge clk or negedge rst_n) begin//always block of the counting 
	if (!rst_n) begin    ///// reseting all the registers /////
		wr_ptr <= 0;
		rd_ptr <= 0;
		count<=0;
		underflow<=0;
		overflow<=0;
		wr_ack<=0;     
	end
	else begin
		if	((wr_en && (count < FIFO_DEPTH)) || (rd_en && (count == 0) && wr_en))//including the condition when read and write are high and the memory is empty
			count <= count + 1;
		else if ((rd_en && (count > 0) &&(!wr_en))|| (rd_en && (count ==FIFO_DEPTH)&&wr_en))//including the condition when read and write are high and the memory is full
			count <= count - 1;
	end
end

///////////////////////////////////////////////////////


assign full = (count == FIFO_DEPTH)? 1 : 0;
assign empty = (count == 0)? 1 : 0;
assign almostfull = (count == (FIFO_DEPTH-1))? 1 : 0; //should be equal to 7 not 6
assign almostempty = (count == 1)? 1 : 0;
 

///////////////////////////////////////////////////////




endmodule