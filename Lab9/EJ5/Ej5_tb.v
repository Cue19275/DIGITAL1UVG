module testbench();

wire [12:0]Q;
reg [6:0]S;

ROMCASE d(S, Q);
  initial begin
    $display("Lab9_Ej5");
    $display("S       | Q");
    $display("--------|--");
    $monitor("%b | %b", S, Q);
    S = 7'b0000000;
    #1 S = 7'bxxxxxx0;
    #1 S = 7'b00001x1;     
    #1 S = 7'b00000x1;       
    #1 S = 7'b00011x1;       
    #1 S = 7'b00010x1;       
    #1 S = 7'b0010xx1;       
    #1 S = 7'b0011xx1;       
    #1 S = 7'b0100xx1;       
    #1 S = 7'b0101xx1;       
    #1 S = 7'b0110xx1;       
    #1 S = 7'b0111xx1;       
    #1 S = 7'b1000x11;       
    #1 S = 7'b1000x01;       
    #1 S = 7'b1001x11;       
    #1 S = 7'b1001x01;       
    #1 S = 7'b1010xx1;       
    #1 S = 7'b1011xx1;       
    #1 S = 7'b1100xx1;       
    #1 S = 7'b1101xx1;     
    #1 S = 7'b1110xx1;     
    #1 S = 7'b1111xx1;  
    #1 S = 7'b0000111;
    #1 S = 7'b0000011;
    #1 S = 7'b0001111;
    #1 S = 7'b0001011;
    #1 S = 7'b0010111;
    #1 S = 7'b0011111;
    #1 S = 7'b0100111;
    #1 S = 7'b0101111;
    #1 S = 7'b0110111;
    #1 S = 7'b0111111;
    #1 S = 7'b1000111;
    #1 S = 7'b1000101;
    #1 S = 7'b1001111;
    #1 S = 7'b1001101;
    #1 S = 7'b1010111;
    #1 S = 7'b1011111;
    #1 S = 7'b1100111;
    #1 S = 7'b1101111;
    #1 S = 7'b1110111;
    #1 S = 7'b1111111;
  end 
  initial
  #100 $finish;
  initial begin
    $dumpfile("Ej5_tb.vcd");
      $dumpvars(0, testbench);
    end

endmodule
