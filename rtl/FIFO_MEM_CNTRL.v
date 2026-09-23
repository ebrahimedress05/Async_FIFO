module FIFO_MEM_CNTRL #(parameter data_width = 8 , parameter depth = 8 , parameter addr_width = 3)(
    input wire [data_width-1 : 0] W_data ,
    input wire W_inc ,
    input wire W_full ,
    input wire W_RST ,
    input wire [addr_width-1 : 0] W_addr ,
    input wire W_CLK ,
    input wire [addr_width-1 : 0] R_addr ,
    output wire [data_width-1 : 0] R_data
);
    // Memory array definition
    reg [data_width-1 : 0] mem [depth-1 : 0] ;
    wire W_clken ;

    // Write enable condition (write only if not full)
    assign W_clken = W_inc & !W_full ;

    // Write data on clock edge
    integer i;
    always @(posedge W_CLK or negedge W_RST) begin
        if(!W_RST) begin
            for (i = 0 ; i<depth ; i=i+1) begin
                mem[i] <= 'b0 ;
            end
        end
        else if(W_clken) begin
            mem[W_addr] <= W_data ;
        end
    end

    // Continuous read data out
    assign R_data = mem[R_addr] ;
endmodule