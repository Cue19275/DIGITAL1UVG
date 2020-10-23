//Testbench pc
module testbench();
reg 	clk;    // Clock
reg 	clk_en; // Clock Enable
reg 	rst;
reg		load_en;
reg  	[11:0] L;
wire 	[11:0] Q;

Contador r1(clk, clk_en, rst, load_en, L, Q);
always
	#2 clk <= ~clk;
initial begin
	$display("Contador_12B/PC");
	$display("clk rst clk_en  load_en     L      	        |Q");
	$monitor("%b   %b   %b        %b       %b         |%b", clk, rst, clk_en, load_en, L, Q);
	rst = 0; clk = 1; clk_en = 0; load_en = 0; L = 000000000000;
	#4 rst = 1;
	#4 rst = 0;
	#4 clk_en =1;
	#4 clk_en =1;
	#4 clk_en =1;
	#4 clk_en =1;
	#4 clk_en =1;
	#4 clk_en =1;
	#4 clk_en =1;
	#4 clk_en =1;
	#4 clk_en =1;
	#4 clk_en =1;
	#4 clk_en =1;
	#4 clk_en =1;
	#4 clk_en =1;
	#4 clk_en =1;
	#4 rst = 1;
	#4 rst = 0; clk_en = 0; load_en = 1;
	#4 L = 12'b000000011111;
	#20 clk_en = 1; load_en = 0;
	#10 load_en = 1;


end
initial
	#200 $finish;	
initial begin
      $dumpfile("Contador_tb.vcd");
      $dumpvars(0, testbench);
    end
  endmodule

