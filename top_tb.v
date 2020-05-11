`timescale 1 ns / 1 ps

module top_tb;
    reg clk_i,rst_i,RXD_i;
    wire TXD_o;
    top UUT(.clk_i(clk_i),
                  .rst_i(rst_i),
                  .RXD_i(RXD_i),
                  .TXD_o(TXD_o),
                  .rxClk(rxClk),
                  .txClk(txClk)
                  );

  

    initial begin
        rst_i = 0;
        clk_i = 0;
        
    end   
    always
        #5 clk_i = ~clk_i;  
    
endmodule