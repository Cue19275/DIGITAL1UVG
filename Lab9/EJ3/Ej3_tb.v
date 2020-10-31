module testbench();
wire P;
reg clk, rst, en, J, K;

JKFF1B t(clk, rst, en, J, K, P);
always
  #2 clk <= ~clk;
  initial begin
    $display("Lab9_Ej2¿3");
    $display("clk rst en J K|P");
    $display("--------------|-");
    $monitor("%b  %b  %b  %b %b |%b", clk, rst, en, J, K, P);
    rst=0; clk=0; en= 1; J = 0; K = 0;
    #4 rst = 1;
    #4 rst = 0;
    #4 J = 1; K = 0;
    #4 J = 0; K = 1;
    #4 J = 1; K = 1;
    #4 J = 0; K = 0;
  end 
  initial
  #30 $finish;
  initial begin
    $dumpfile("EJ3_tb.vcd");
      $dumpvars(0, testbench);
    end

endmodule 