module FIFO_rptr #(parameter addr_width = 3)(
    input wire R_inc ,
    input wire R_CLK ,
    input wire R_RST ,
    input wire [addr_width : 0] rq2_wptr ,
    output reg [addr_width-1 : 0] R_addr ,
    output reg [addr_width : 0] R_ptr ,
    output reg R_empty
);
    integer i ;
    reg extra_bit ;
    wire [addr_width : 0] R_ptr_in ;

    // read address logic
    always @(posedge R_CLK or negedge R_RST) begin
        if(!R_RST) begin
            R_addr <= 'b0 ;
            extra_bit <= 'b0 ;
        end
        else if (R_inc & !R_empty) begin
            if (&R_addr) begin
                R_addr <= 'b0 ;
                extra_bit <= extra_bit + 1 ;
            end
            else begin
                R_addr <= R_addr + 1 ;
            end
        end
    end

    assign R_ptr_in = {extra_bit , R_addr} + (R_inc & !R_empty) ;

    // gray code logic
    always @(posedge R_CLK or negedge R_RST) begin
        if(!R_RST) begin
            R_ptr <= 'b0 ;
        end 
        else begin
            for (i=0 ; i<addr_width ; i=i+1) begin
                R_ptr[i] <= R_ptr_in[i] ^ R_ptr_in[i+1] ;
            end 
             R_ptr[addr_width] <= R_ptr_in[addr_width] ;
        end
    end

    // empty flag logic    
    always @(*) begin
        if(rq2_wptr == {R_ptr}) begin
            R_empty = 1 ;
        end
        else begin
            R_empty = 0 ;
        end
    end 

endmodule