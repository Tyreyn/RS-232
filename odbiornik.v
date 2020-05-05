module odbiornik(input clk_i,
                 input rst_i,
                 input RXD_i,
                 output TXD_o
                 );
reg [7:0] rx_data = 8'b00000000;
reg [3:0] licznik_bit = 4'b0000;
reg start = 1'b0;
reg trans = 1'b0;
wire stop;
reg [32:0] licznik = 32'd0;
parameter DIV = 32'd10;
wire reg_TXD;
wire div_clk;

always @(posedge clk_i, negedge rst_i) begin
    if(rst_i == 1 ) begin
        licznik <= 32'd0;
        rx_data <= 0;
        licznik_bit <= 0;
    end
    else begin   
        licznik <= licznik + 32'd1;
        if(licznik>=(DIV-1))
  		    licznik <= 32'd0;
    end
end

assign div_clk = (licznik<(DIV/2))?1'b0:1'b1;

always @(posedge div_clk) begin
    if(RXD_i == 0) begin
        start <= 1'b1;
    end
    if(start == 1) begin
        rx_data[licznik_bit] <= RXD_i;
        licznik_bit = licznik_bit + 1;
        if(licznik_bit == 7) begin
            start <= 1'b0;
            trans = 1'b1;
        end
    end
    if(trans == 1)
        if(stop == 1) begin 
            licznik_bit <= 0;
            rx_data <= 0;
            trans = 1'b0 ;
        end
end
nadajnik nad_1(div_clk,rx_data[7:0],trans,stop,reg_TXD);
assign TXD_o = reg_TXD;

endmodule
