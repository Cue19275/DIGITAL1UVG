module testbench();

wire [3:0]Q;
reg [3:0]S;
reg en;

bufftri r(en, S, Q);

initial begin
    $display("Lab9_Ej1");
    $display("en S   | Q ");
    $display("-------|------");
    $monitor("%b %b | %b", en, S, Q);
    en = 0; S=4'b0000;
    #4 en = 1;
    #4 S = 4'b1111;
    #4 S = 4'b1110;
    #4 S = 4'b1100;
    #4 S = 4'b1000;
    #4 S = 4'b0000;
    #4 en = 0;
  end 
  initial
  #30 $finish;
  initial begin
    $dumpfile("Ej4_tb.vcd");
      $dumpvars(0, testbench);
    end

endmodule
