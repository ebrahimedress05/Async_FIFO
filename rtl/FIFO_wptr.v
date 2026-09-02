module FIFO_wptr #(parameter addr_width = 3)(
    input wire W_inc ,
    input wire W_CLK ,
    input wire W_RST ,
    input wire [addr_width : 0] wq2_rptr ,
    output reg [addr_width-1 : 0] W_addr ,
    output reg [addr_width : 0] W_ptr ,
    output reg W_full
);
    integer i ;
    reg extra_bit ;
    wire [addr_width : 0] W_ptr_in ;

    // write address logic
    always @(posedge W_CLK or negedge W_RST) begin
        if(!W_RST) begin
            W_addr <= 'b0 ;
            extra_bit <= 'b0 ;
        end
        else if (W_inc & !W_full) begin
            if (&W_addr) begin
                W_addr <= 'b0 ;
                extra_bit <= extra_bit + 1 ;
            end
            else begin
                W_addr <= W_addr + 1 ;
            end
        end
    end

    assign W_ptr_in = {extra_bit , W_addr} + (W_inc & !W_full) ;
 
    // gray code logic
    always @(posedge W_CLK or negedge W_RST) begin
        if(!W_RST) begin
            W_ptr <= 'b0 ;
        end 
        else begin
            for (i=0 ; i<addr_width ; i=i+1) begin
                W_ptr[i] <= W_ptr_in[i] ^ W_ptr_in[i+1] ;
            end 
             W_ptr[addr_width] <= W_ptr_in[addr_width] ;
        end
    end    

    // full flag logic    
    always @(*) begin
        if(wq2_rptr == {~W_ptr[addr_width] , ~W_ptr[addr_width-1] , W_ptr[addr_width-2 : 0]}) begin
            W_full = 1 ;
        end
        else begin
            W_full = 0 ;
        end
    end 

endmodule