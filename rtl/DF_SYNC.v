module DF_SYNC #(parameter data_width = 4 , NUM_STAGES = 2)(
    input wire CLK ,
    input wire RST ,
    input wire [data_width - 1 : 0] unsync_bus ,
    output reg [data_width - 1 : 0] sync_bus 
);
    integer i;
    reg [NUM_STAGES-1:0] MULTI_FLIP_FLOP [data_width - 1 : 0] ;

    always @(posedge CLK or negedge RST) begin
        if(!RST) begin
            for (i = 0; i<data_width ; i = i+1) begin
                MULTI_FLIP_FLOP[i] <= 0 ;
            end
        end
        else begin
            for (i = 0; i<data_width ; i = i+1) begin
                MULTI_FLIP_FLOP[i] <= {unsync_bus[i] , MULTI_FLIP_FLOP[i][NUM_STAGES-1:1]} ;
            end
            end
        end

    always @(*) begin
        for (i = 0; i<data_width ; i = i+1) begin
            sync_bus[i] = MULTI_FLIP_FLOP[i][0] ;
         end
        end

endmodule