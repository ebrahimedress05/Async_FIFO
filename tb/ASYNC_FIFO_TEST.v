`timescale 1ns/1ps

module ASYNC_FIFO_TEST ();

    // Parameters
    parameter write_period = 10;
    parameter read_period  = 25;
    parameter data_width   = 8; 
    parameter depth        = 8; 
    parameter addr_width   = 3;
    parameter NUM_STAGES   = 2; 

    // DUT Signals
    reg [data_width-1 : 0] W_data_test;
    reg W_inc_test, R_inc_test;
    reg W_CLK_test, W_RST_test;
    reg R_CLK_test, R_RST_test;    
    wire [data_width-1 : 0] R_data_test;
    wire W_full_test, R_empty_test;

    // Scoreboard Variables
    integer i = 0;

    // Clock Generation
    always #(write_period / 2.0) W_CLK_test = ~W_CLK_test;
    always #(read_period  / 2.0) R_CLK_test = ~R_CLK_test;

    // DUT Instantiation
    ASYNC_FIFO #(
        .data_width(data_width),
        .depth(depth),
        .addr_width(addr_width),
        .NUM_STAGES(NUM_STAGES)
    ) DUT (
        .W_data(W_data_test),
        .W_inc(W_inc_test),
        .R_inc(R_inc_test),
        .W_CLK(W_CLK_test),
        .W_RST(W_RST_test),
        .R_CLK(R_CLK_test),
        .R_RST(R_RST_test),    
        .R_data(R_data_test),
        .W_full(W_full_test),
        .R_empty(R_empty_test)
    );


    // -------------------------------------------------------------
    // TEST SEQUENCES
    // -------------------------------------------------------------

    // WRITE Process
    initial begin
        //intialization && reset 
        W_data_test = 'b0 ;
        W_inc_test = 'b0 ;
        W_CLK_test = 'b0 ;
        W_RST_test = 'b0 ;
        #(write_period)
        W_RST_test = 'b1 ;
        #(write_period)

        // WRITE 9 BYTE DATA
        W_inc_test = 'b1 ;
        write('h51) ; 
        write('hf1) ;
        write('h05) ;
        write('h33) ;
        write('h48) ;
        write('h96) ;
        write('hAC) ;
        write('hA6) ;
        write('hA0) ;
        #(write_period) 
        W_inc_test = 'b0 ;                              
    end

    // READ Process
    initial begin
        //intialization && reset
        R_inc_test = 'b0 ;
        R_CLK_test = 'b0 ;
        R_RST_test = 'b0 ;
        #(read_period)
        R_RST_test = 'b1 ;
        #(read_period) 

        // WRITE 9 BYTE DATA
        R_inc_test = 'b1 ;
        #(read_period * 9) 
        R_inc_test = 'b0 ;   

        #(read_period * 2) 
        $stop ;   
    end
    
    // writing task 
    task write ;
    input [data_width-1 : 0] write_data ; 
    begin
        W_data_test = write_data ;
        #(write_period) ;
    end
    endtask
endmodule