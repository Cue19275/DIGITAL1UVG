//Testbench del ejercicio5
module testbench();
wire [3:0] Q1;
reg [3:0] D1;
reg clck, rst, set;

FFDEj5  r1(clck, rst, set, D1, Q1);

always
  #1 clck <= ~clck;

//testbench flip flop d con reset asincrono
  initial begin
  $display(" Ejrecicio 5");
  $display("St C R  D    |  Q ");
  $display("------------|-----");
  $monitor("%b %b %b %b  | %b  ", set, clck, rst, D1, Q1);
     rst = 1; set = 1; D1[3] = 1; D1[2] = 1; D1[1] = 0; D1[0] = 0;  clck = 0;
  #5 rst = 0; set = 0; D1[3] = 0; D1[2] = 1; D1[1] = 1; D1[0] = 0;
  #5 rst = 0; set = 1; D1[3] = 1; D1[2] = 1; D1[1] = 1; D1[0] = 1;
  #5 rst = 0; set = 0; D1[3] = 0; D1[2] = 0; D1[1] = 1; D1[0] = 1;
  #5 rst = 0; set = 0; D1[3] = 1; D1[2] = 1; D1[1] = 0; D1[0] = 1;
  end
  initial
    #21 $finish;
  initial begin
      $dumpfile("Lab6Ej5_tb.vcd");
      $dumpvars(0, testbench);
    end
  endmodule