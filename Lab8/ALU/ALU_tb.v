//Testbench ALU
module testbench();

reg [3:0] A;
reg [3:0] B;
reg [2:0] SEL;
wire [3:0] Y;

ALU_BB r(A, B, SEL, Y);

initial begin

	$display("ALU 4 bits");
	$display("A   B   SEL  | Y");
	$monitor("%b  %b  %b   | %b", A, B, SEL, Y);
	A = 0; B= 0; SEL = 0;
	#1 A = 4'b1000; B = 4'b0111; SEL = 3'b000;
	#1 SEL = 3'b001;
	#1 SEL = 3'b010;
	#1 SEL = 3'b011;
	#1 SEL = 3'b100;
	#1 SEL = 3'b101;
	#1 SEL = 3'b110;
	#1 SEL = 3'b111;
end
initial
	#9 $finish;	
initial begin
      $dumpfile("ALU_tb.vcd");
      $dumpvars(0, testbench);
    end
  endmodule