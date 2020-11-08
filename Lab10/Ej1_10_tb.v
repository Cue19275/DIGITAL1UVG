module testbench();

reg clk, rst, enC, enL, enF;
reg [11:0] in;
wire [3:0] Q1;
wire [3:0] Q2;

union r0(clk, rst, enC, enL, enF, in, Q1, Q2);

always
  #2 clk <= ~clk;
  initial begin
    $display("Lab10_Ej1");
    $display("clk rst enC enL enF in          |Q1   Q2");
    $display("--------------------------------|----------------");
    $monitor("%b   %b   %b   %b   %b   %b|%b %b", clk, rst, enC, enL, enF, in, Q1, Q2);
    rst=0; clk=0; enC= 1; enL = 0; enF = 1; in = 0;
    #4 rst = 1;
    #4 rst = 0;
    #20 in = 0;
    #4 rst = 1; enC = 0; enL = 1; in = 12'b000000000011;
    #4 rst = 0;
    #4 enC = 1; enL = 0;
  end 
  initial
  #100 $finish;
  initial begin
    $dumpfile("EJ1_10_tb.vcd");
      $dumpvars(0, testbench);
    end

endmodule