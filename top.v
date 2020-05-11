`timescale 1 ns / 1 ps

module top(input clk_i,
           input rst_i,
           input RXD_i,
           output reg rxClk,
           output reg txClk,
           output TXD_o
           );
parameter zegar = 1000000;
parameter MAX_RX = zegar/(2*9600*8);
parameter MAX_TX = zegar/(2*9600);
reg [31:0] rxCounter = 0;
reg [31:0] txCounter = 0;

initial begin
    rxClk = 1'b0;
    txClk = 1'b0;
end

always @(posedge clk_i, negedge rst_i) begin
    if(rst_i == 1 ) begin
        rxCounter <= 0;
        txCounter <= 0;
    end
    else begin   
         if (rxCounter == MAX_RX) begin
            rxCounter <= 0;
            assign rxClk = ~rxClk;
        end 
        else begin
            rxCounter <= rxCounter + 1'b1;
        end
            if (txCounter == MAX_TX) begin
            txCounter <= 0;
            assign txClk = ~txClk;
        end
        else begin
            txCounter <= txCounter + 1'b1;
        end
    end
end
endmodule