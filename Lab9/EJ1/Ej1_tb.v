module testbench();

wire Q;
wire [1:0]Q2;
wire [3:0]Q4;
reg [3:0]D4;
reg [1:0]D2;
reg D;
reg clk, rst, en;

FFD1B a(clk, rst, en, D, Q);
FFD2B b(clk, rst, en, D2, Q2);
FFD4B c(clk, rst, en, D4, Q4);

always
  #2 clk <= ~clk;
  initial begin
    $display("Lab9_Ej1");
    $display("clk rst en D D2 D4|Q Q2 Q4");
    $display("------------------|----------------");
    $monitor("%b %b %b %b %b   %b|%b %b  %b", clk, rst, en, D, D2, D4, Q, Q2, Q4);
    rst=0; clk=0; en= 0; D=1'b1; D2=2'b10; D4=4'b1100;
    #4 rst = 1;
    #4 rst = 0;
    #4 en = 1;
    #4 en = 1;
  end 
  initial
  #20 $finish;
  initial begin
    $dumpfile("EJ1_tb.vcd");
      $dumpvars(0, testbench);
    end

endmodule