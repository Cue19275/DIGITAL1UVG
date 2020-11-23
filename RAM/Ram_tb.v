//Testbench RAM
module Testbench();

reg cs, we; //chipselect y write enable
reg [11:0] dir; //dirección de la memoria
reg [3:0] data;
wire [3:0] dataout;
wire  [3:0] datain;

RAM r1(cs, we, dir, data);


assign data = (cs && !we)? dataout: datain; //Buffer tri-estado


initial begin
	$display("RAM");
	$display("cs|we|dir      |data|");
	$monitor("%b|%b|%b       |%b|", cs, we, dir, data);
	cs = 1; we = 1;
	#1 dir = 0; data = 0;
end 
initial
	#20 $finish;	
initial begin
      $dumpfile("Ram_tb.vcd");
      $dumpvars(0, Testbench);
    end
  endmodule