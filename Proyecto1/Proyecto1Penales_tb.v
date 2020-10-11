module testbench();
//wire [2:0] Cont5p;
//wire FIN5P, ENJ5;
//wire [2:0] Cont3p;
//wire FIN3P, ENJ3;
//reg M1, M2, K, noT, clk, rst;

wire Y;
reg  bot, clk, rst;

//emp_contpen r1(M2, M1, K, noT, clk, rst, Cont5p, FIN5P, ENJ5, Cont3p, FIN3P, ENJ3);
antirebote  d9(bot, clk, rst, Y);
always 
	#1 clk <= ~clk;
	initial begin
  $display("Proyecto Penales");
  $display("clk   rst   bot|Y");
  $display("------------|-----");
  $monitor("%b     %b    %b| %b", clk, rst, bot, Y);
     rst = 1; clk = 1;
     #1 rst = 0; bot = 1;
     #3  bot =1; rst = 0;
     #3  bot =0; rst = 1;
     #3  bot =1;
     #3  bot =0;
     #3  bot =1;
     #3  bot =0;
     #3  bot =1;
     #3  bot =0;
     #3  bot =1;
     #3  bot =0;
     #3  bot =1;
     #3  bot =0;

end

  initial
    #50 $finish;
  initial begin
      $dumpfile("Proyecto1Penales_tb.vcd");
      $dumpvars(0, testbench);
    end
  endmodule
