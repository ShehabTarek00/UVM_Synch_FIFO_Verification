vlib work
vlog -f FIFO_files.list +cover -covercells 
vsim -voptargs=+acc work.FIFO_TOP -cover 
add wave -position insertpoint \
sim:/FIFO_TOP/fifo_interf/clk \
sim:/FIFO_TOP/fifo_interf/rst_n \
sim:/FIFO_TOP/fifo_interf/wr_ack \
sim:/FIFO_TOP/fifo_interf/overflow \
sim:/FIFO_TOP/fifo_interf/underflow \
sim:/FIFO_TOP/fifo_interf/full \
sim:/FIFO_TOP/fifo_interf/empty \
sim:/FIFO_TOP/fifo_interf/almostfull \
sim:/FIFO_TOP/fifo_interf/almostempty \
sim:/FIFO_TOP/fifo_interf/wr_en \
sim:/FIFO_TOP/fifo_interf/rd_en \
sim:/FIFO_TOP/fifo_interf/data_in \
sim:/FIFO_TOP/fifo_interf/data_out 
coverage save FIFO.ucdb -onexit -du work.FIFO
run -all
