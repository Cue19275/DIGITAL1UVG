//Testbench rom
module testbench();

reg [11:0]DIR;
wire [7:0] Y;

ROM r(DIR, Y);

initial begin

	$display("ROM_4Kx8");
	$display("DIR	        | Y");
	$monitor("%b	| %b", DIR, Y);
	DIR = 0;
	#1 DIR = 0;
	#1 DIR = 1;
	#1 DIR = 2;
	#1 DIR = 3;
	#1 DIR = 4;
	#1 DIR = 5;
	#1 DIR = 6;
	#1 DIR = 7;
	#1 DIR = 8;
	#1 DIR = 9;
	#1 DIR = 10;
	#1 DIR = 11;
	#1 DIR = 12;
	#1 DIR = 13;
	#1 DIR = 2000;
	#1 DIR = 1;
	#1 DIR = 4000;

end 
initial
	#20 $finish;	
initial begin
      $dumpfile("ROM_tb.vcd");
      $dumpvars(0, testbench);
    end
  endmodule