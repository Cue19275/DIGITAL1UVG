module testbench();

wire K;
reg clk, rst, en;

FFT1B d(clk, rst, en, K);
always
  #2 clk <= ~clk;
  initial begin
    $display("Lab9_Ej2");
    $display("clk rst en|K");
    $display("----------|-");
    $monitor("%b  %b  %b |%b", clk, rst, en, K);
    rst=0; clk=0; en= 0;
    #4 rst = 1;
    #4 rst = 0;
    #4 en = 1;
    #30 en = 1;
  end 
  initial
  #50 $finish;
  initial begin
    $dumpfile("EJ2_tb.vcd");
      $dumpvars(0, testbench);
    end

endmodule

