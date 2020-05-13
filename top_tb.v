`timescale 1 ns / 10 ps

module top_tb;
    reg clk_i=0,rst_i=0,RXD_i=1;
    wire [7:0] data;
    wire txstart;
    wire TXD_o;
    top UUT(.clk_i(clk_i),
            .rst_i(rst_i),
            .RXD_i(RXD_i),
            .TXD_o(TXD_o)
            );

  

    always
        #5 clk_i = ~clk_i;  
    initial begin
        RXD_i = 0;
        #500
        #104160 RXD_i = 1;
        #104160 RXD_i = 0;
        #104160 RXD_i = 1;
        #104160 RXD_i = 1;
        #104160 RXD_i = 1;
        #104160 RXD_i = 1;
        #104160 RXD_i = 0;
        #104160 RXD_i = 0;

        #104160 RXD_i = 1;
        #104160
        #104160
        RXD_i = 0;
        #500
        #104160 RXD_i = 0;
        #104160 RXD_i = 1;
        #104160 RXD_i = 0;
        #104160 RXD_i = 0;
        #104160 RXD_i = 0;
        #104160 RXD_i = 0;
        #104160 RXD_i = 0;
        #104160 RXD_i = 0;
        #104160 RXD_i = 1;

    end
endmodule