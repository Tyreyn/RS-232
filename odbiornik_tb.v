`timescale 1ns/10ps
module odbiornik_tb;
    reg clk_i=0,rst_i=0,RXD_i=1;
    wire rxODEBRANE;
    wire [7:0] rxData_o;
    odbiornik UUT(.clk_i(clk_i),
                  .RXD_i(RXD_i),
                  .rxODEBRANE(rxODEBRANE),
                  .rxData_o(rxData_o)
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