module testbench();
 reg clk, rst, en, enb1, enb2;  
reg [3:0] in;
reg [2:0] Sel; 
wire C, Z; 
wire [3:0] O;

unionalu rt(clk, rst, en, enb1, enb2, in, Sel, C, Z, O);


  always
  #2 clk <= ~clk;
  initial begin
    $display("Lab10_Ej2");
    $display("clk rst en enb1 enb2 in   Sel    |C Z O");
    $display("---------------------------------|----------------");
    $monitor("%b   %b   %b   %b    %b   %b   %b  |%b %b %b", clk, rst, en, enb1, enb2, in, Sel, C, Z, O);
    rst=0; clk=0; en = 0; enb1 = 0; enb2 = 0; in = 3; Sel= 3'b010;
    #4 rst = 1;
    #4 rst = 0;
    #4 enb2 = 1; enb1 = 1; en = 1;
    #4 Sel = 3'b000; in = 2;  //Se debe de seguir mostrando el 3 en la tabla
    #4 in =2; en = 0;
    #4 Sel = 3'b001; 
    #4 Sel = 3'b011;
    #4 Sel = 3'b100;

    
  end 
  initial
  #36 $finish;
  initial begin
    $dumpfile("Lab10Ej2_tb.vcd");
      $dumpvars(0, testbench);
    end

endmodule