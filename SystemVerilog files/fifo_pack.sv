package fifo_pack;
parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;

static bit test_finished;
static int error_count=0;
static int correct_count=0;

endpackage 