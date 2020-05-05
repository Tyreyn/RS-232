module nadajnik(input clk_i,
                input [7:0]data_rx,
                input trans,
                output stop,
                output tx
                );
reg [7:0] dane;
reg reg_stop;
reg start = 1'b0;
reg [4:0] licznik_bit = 4'b0000;
reg reg_TXD;
always @(posedge clk_i) begin
    dane = data_rx + 8'b00100000;
    if(trans == 1 ) begin
        start <= 1'b1;
        if(start == 1) begin
            reg_TXD <= dane[licznik_bit]; 
            licznik_bit<=licznik_bit+1;
        end
        if(licznik_bit == 7) begin
           licznik_bit <=0;
            start = 1'b0;
            reg_stop = 1'b1;
        end
    end
end
assign tx = reg_TXD;
assign stop = reg_stop;
endmodule
