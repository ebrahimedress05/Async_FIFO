module ASYNC_FIFO #(
    parameter data_width = 8,
    parameter depth      = 8,
    parameter addr_width = 3,
    parameter NUM_STAGES = 2
)(
    input  wire [data_width-1:0] W_data,
    input  wire                  W_inc,
    input  wire                  R_inc,
    input  wire                  W_CLK,
    input  wire                  W_RST,
    input  wire                  R_CLK,
    input  wire                  R_RST,    
    output wire [data_width-1:0] R_data,
    output wire                  W_full,
    output wire                  R_empty
);

    wire [addr_width : 0]   R_ptr;
    wire [addr_width : 0]   W_ptr;
    wire [addr_width-1 : 0] W_addr;
    wire [addr_width-1 : 0] R_addr;
    wire [addr_width : 0]   wq2_rptr;
    wire [addr_width : 0]   rq2_wptr;    

    // Memory module
    FIFO_MEM_CNTRL #(
        .data_width(data_width),
        .depth(depth),
        .addr_width(addr_width)
    ) FIFO_MEM_CNTRL (
        .W_data(W_data),
        .W_inc(W_inc),
        .W_full(W_full),
        .W_addr(W_addr),
        .W_CLK(W_CLK),
        .R_addr(R_addr),
        .R_data(R_data) 
    );

    // Write pointer module
    FIFO_wptr #(
        .addr_width(addr_width)
    ) FIFO_wptr (
        .W_inc(W_inc),
        .W_CLK(W_CLK),
        .W_RST(W_RST),
        .wq2_rptr(wq2_rptr),
        .W_addr(W_addr),
        .W_ptr(W_ptr),
        .W_full(W_full)
    );

    // Read pointer module
    FIFO_rptr #(
        .addr_width(addr_width)
    ) FIFO_rptr (
        .R_inc(R_inc),
        .R_CLK(R_CLK),
        .R_RST(R_RST),
        .rq2_wptr(rq2_wptr),
        .R_addr(R_addr),
        .R_ptr(R_ptr),
        .R_empty(R_empty)
    );

    // Sync write pointer to read clock
    DF_SYNC #(
        .data_width(addr_width+1),
        .NUM_STAGES(NUM_STAGES)
    ) DF_SYNC_R (
        .CLK(R_CLK),
        .RST(R_RST),
        .unsync_bus(W_ptr),
        .sync_bus(rq2_wptr) 
    );

    // Sync read pointer to write clock
    DF_SYNC #(
        .data_width(addr_width+1),
        .NUM_STAGES(NUM_STAGES)
    ) DF_SYNC_W (
        .CLK(W_CLK),
        .RST(W_RST),
        .unsync_bus(R_ptr),
        .sync_bus(wq2_rptr) 
    );

endmodule