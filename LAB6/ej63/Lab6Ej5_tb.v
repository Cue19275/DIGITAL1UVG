module testbench();
wire Y0;
wire Y1;
wire Y2;
reg A;
reg clck, rst;

Ej62  r2(A, clck, rst, Y0, Y1, Y2);

always
  #1 clck <= ~clck;

//testbench flip flop d con reset asincrono
  initial begin
  $display(" Ejrecicio 6_2");
  $display("clck rst   A|  Y2 Y1 Y0 ");
  $display("------------|-----");
  $monitor("%b     %b   %b | %b %b %b ", clck, rst, A, Y2, Y1, Y0);
     rst = 1; A = 1; clck = 1;
  #1 rst = 0; A = 1; 
  #1 rst = 0; A = 1; 
  #1 rst = 0; A = 1; 
  #1 rst = 0; A = 1; 
  #1 rst = 0; A = 1; 
  #1 rst = 0; A = 1; 
  #1 rst = 0; A = 1; 
  #1 rst = 0; A = 1;
  #1 rst = 0; A = 1;
  #1 rst = 0; A = 1; 
  #1 rst = 0; A = 1; 
  #1 rst = 0; A = 1; 
  #1 rst = 0; A = 1; 
  #1 rst = 0; A = 1; 
  #1 rst = 0; A = 1; 
  #1 rst = 0; A = 1; 
  #1 rst = 0; A = 1;
  #1 rst = 0; A = 1;  
  #1 rst = 0; A = 0;
  #1 rst = 0; A = 0;
  #1 rst = 0; A = 0;
  #1 rst = 0; A = 0;
  #1 rst = 0; A = 0;
  #1 rst = 0; A = 0;
  #1 rst = 0; A = 0;
  #1 rst = 0; A = 0;  
  #1 rst = 0; A = 0;
  #1 rst = 0; A = 0;
  #1 rst = 0; A = 0;
  #1 rst = 0; A = 0;
  #1 rst = 0; A = 0;
  #1 rst = 0; A = 0;
  #1 rst = 0; A = 0;
  #1 rst = 0; A = 0;  
  end

  
  
  initial
    #33 $finish;
  initial begin
      $dumpfile("Lab6Ej5_tb.vcd");
      $dumpvars(0, testbench);
    end
  endmodule