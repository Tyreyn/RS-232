`timescale 1 ns / 10 ps

module top(input clk_i,
           input rst_i,
           input RXD_i,
           output reg CLK,
           output TXD_o
           );
wire [7:0] data;
wire txstart;
wire koniec;
odbiornik OD(clk_i,RXD_i,rst_i,txstart,data);
nadajnik NAD(clk_i,data,txstart,TXD_o,koniec);

endmodule