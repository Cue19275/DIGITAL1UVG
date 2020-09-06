module testbench();
wire Y;
wire Y0;
wire Y1;
wire Y2;
reg A;
reg B;
reg C;
reg clck, rst;

Ej61  r1(A, B, clck, rst, Y);
Ej62  r2(C, clck, rst, Y0, Y1, Y2);

always
  #1 clck <= ~clck;

//testbench flip flop d con reset asincrono
  initial begin
  $display(" Ejrecicio 6_1");
  $display("clck rst   A  B  |  Y ");
  $display("-----------------|-----");
  $monitor("%b     %b   %b %b | %b  ", clck, rst, A, B, Y);
     rst = 1; A = 0; B = 0; clck = 1;
  #1 rst = 0; A = 0; B = 1;
  #1 rst = 0; A = 1; B = 0;
  #1 rst = 0; A = 1; B = 1;
  end
  
  
  initial
    #4 $finish;
  initial begin
      $dumpfile("Lab6Ej5_tb.vcd");
      $dumpvars(0, testbench);
    end
  endmodule