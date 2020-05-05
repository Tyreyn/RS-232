module odbiornik_tb;
    reg clk_i,rst_i,RXD_i;
    wire div_clk,TXD_o;
    wire stop,tx;
    odbiornik UUT(.clk_i(clk_i),
                  .rst_i(rst_i),
                  .RXD_i(RXD_i),
                  .TXD_o(TXD_o)
                  );

  

    initial begin
        rst_i = 0;
        clk_i = 0;
        RXD_i = 1;
    end   
    always
        #5 clk_i = ~clk_i;  
    initial begin
        RXD_i = 0;
        #75 RXD_i = 1;
        #75 RXD_i = 1;
        #75 RXD_i = 1;
        #75 RXD_i = 1;
        #75 RXD_i = 1;
        #75 RXD_i = 1;
        #75 RXD_i = 0;
        #75 RXD_i = 0;
        #75 RXD_i = 1;
    end
endmodule