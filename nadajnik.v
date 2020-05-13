module nadajnik(input clk_i,
                input [7:0]rxDATA,
                input start,
                output TXD_o,
                output TX_END
                );
parameter s_SPOCZYNEK = 3'b000;
parameter s_START = 3'b001;
parameter s_DATA = 3'b010;
parameter s_STOP = 3'b011;
parameter s_CZYSZCZENIE = 3'b100;
reg [2:0] SM = 0;
reg [31:0] licznik =0;
reg [2:0] licznikBIT =0;
reg przesylanie = 0;
reg [7:0]txDATA =0;
reg txKONIEC = 0;
always @(posedge clk_i) begin
    case(SM)
        s_SPOCZYNEK:
            begin
                koniec <= 0;
                licznik <= 0;
                licznikBIT <=0;
                if(start == 1) begin
                    przesylanie <= 1;
                    txDATA <= rxDATA + 8'h20;
                    SM <= s_START;
                end
            end
        s_START:
            begin
                tx <= 1'b0;
                if(licznik < 10416) begin
                    licznik <= licznik +1;
                    SM <= s_START
                end
                else begin
                    licznik = 0;
                    SM <= s_DATA;
                end
            end
        s_DATA:
            begin
                tx<=txDATA[licznikBIT];
                if(licznik <10416)begin
                    licznik <= licznik + 1;
                    SM <= s_DATA;
                end
                else begin
                    licznik = 0;
                    if(licznikBIT <7)begin
                        licznikBIT<=licznikBIT +1;
                        SM<=s_DATA;
                    end
                    else begin
                        licznikBIT<=0;
                        SM <=s_STOP;
                    end
                end
            end
        s_STOP:
            begin
                tx<=1'b1;
                if(licznik < 10416) begin
                    licznik <= licznik +1;
                    SM<=s_STOP;
                end
                else begin
                txKONIEC = 1'b1;
                SM <= s_CZYSZCZENIE;
                end
            end
        s_CZYSZCZENIE:
            begin
                SM <= s_SPOCZYNEK;
                przesylanie <= 1'b0;
end
assign TXD_o = tx;
assign TX_END = txKONIEC;
endmodule
