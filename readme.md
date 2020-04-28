#Obsługa portu RS-232
Moduły nadajnika i odbiornika danych w standardzie RS-232 dla następujących parametrów transmisji: 8 bitów danych, bez bitu parzystości, jeden bit stopu, szybkość transmisji 9600bps bez sprzętowej kontroli przepływu (no flow control).
Moduły należy połączyć tak, aby odbiornik RS232 po otrzymaniu każdego znaku, podawał go do sumatora i po dodaniu wartości 20h, moduł nadajnika wysyłał go.

Porty układu:
clk_i - zegar 100MHz,
rst_i - reset asynchroniczny sterowany wirtualnym przyciskiem BTN0,
RXD_i - wejście danych,
TXD_o - wyjście danych RS232.