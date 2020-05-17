`timescale 1ns/10ps
module odbiornik(input clk_i,
                 input RXD_i, 
                 input rst_i,
                 output rxODEBRANE,
                 output [7:0]rxData_o            
                 );
parameter s_SPOCZYNEK = 3'b000;
parameter s_START = 3'b001;
parameter s_DATA = 3'b010;
parameter s_STOP = 3'b011;
parameter s_CZYSZCZENIE = 3'b100;
parameter s_RESET = 3'b101;
reg rxDATA = 1'b1;
reg rxDATA_R = 1'b1;
reg [32:0] licznik = 0;
reg odebrane = 0;
reg [2:0]SM = 0;
reg [7:0] rxBIT = 0;
reg [2:0] licznikBIT = 0;

always @(posedge clk_i, negedge rst_i) begin
    if(rst_i == 1)begin
        SM <= s_RESET;
    end
    else begin
        rxDATA_R <= RXD_i;
        rxDATA <= rxDATA_R;
    end
end

always @(posedge clk_i) begin
    case(SM)
    s_RESET:
        begin
            licznik <= 0;
            licznikBIT <= 0;
            odebrane <= 0;
            rxBIT <= 0;
            SM <= s_SPOCZYNEK;
        end
    s_SPOCZYNEK:
        begin
            licznik = 0;
            licznikBIT = 0;
            odebrane = 0;
            if(rxDATA == 1'b0)
                SM <= s_START;
            else 
                SM <= s_SPOCZYNEK;
        end
    
    s_START:
        begin
            if(licznik == 10416/2) begin
                if(rxDATA == 1'b0) begin
                    licznik <= 0;
                    SM <= s_DATA;
                end
                else
                    SM <= s_SPOCZYNEK;
            end
            else begin
                licznik <= licznik +1;
                SM <= s_START;
            end
        end
    s_DATA:
        begin
            if(licznik < 10416) begin
                licznik <= licznik +1;
                SM <= s_DATA;
            end
            else begin
                licznik <=0;
                rxBIT[licznikBIT] <= rxDATA;
                if(licznikBIT < 7) begin
                    licznikBIT <= licznikBIT +1;
                    SM <= s_DATA;
                end
                else begin
                    licznikBIT <= 0;
                    SM <= s_STOP;
                end
            end
        end
        s_STOP:
            begin
                if(licznik < 10416) begin
                    licznik <= licznik +1;
                    SM <= s_STOP;
                end
                else begin
                    odebrane <= 1'b1;
                    licznik <= 0;
                    SM <= s_CZYSZCZENIE;
                end
            end
        s_CZYSZCZENIE:
            begin
                SM <= s_SPOCZYNEK;
                odebrane <= 1'b0;
            end
        default:
            SM <= s_SPOCZYNEK;
    endcase
end
    assign rxODEBRANE = odebrane;
    assign rxData_o = rxBIT;

endmodule
