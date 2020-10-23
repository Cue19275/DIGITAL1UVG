//Carlos Cuellar #19275 UVG
//Código Lab5 Digital I

module mux2_1(
	input wire s1, A0, B0, output wire Y0
);

	assign Y0 = s1? B0:A0;
endmodule

module mux4_1(
	input wire	[1:0]s1, 
	input wire A1, B1, C1, D1, 
	output wire	Y1
);

	wire Y1_1, Y1_2;

	mux2_1 r(s1[0], A1, B1, Y1_1);
	mux2_1 r2(s1[0], C1, D1, Y1_2);
	mux2_1 r3(s1[1], Y1_1, Y1_2, Y1);
endmodule

module mux8_1(
	input wire	[2:0]s1, 
	input wire	A2, B2, C2, D2, E2, F2, G2, H2,
	output wire	Y2 
	);
	wire Y2_1, Y2_2;

	mux4_1 r1(s1[1:0], A2, B2, C2, D2, Y2_1);
	mux4_1 r2(s1[1:0], E2, F2, G2, H2, Y2_2);
	mux2_1 r3(s1[2]. Y2_1, Y2_2, Y2);
endmodule

//Tabla 1 con mux 8:1
module T1Mux8_1(
	input wire	A, B, C, hi, lo,
	output wire	OUT_1
);
	wire [2:0]s1;
	assign s1[0] = C;
	assign s1[1] = B;
	assign s1[2] = A;
	

	mux8_1 op1(s1[2:0], lo, hi, hi, lo, hi, lo, lo, hi, OUT_1);
endmodule

module T1Mux4_1(
	input wire	A, B, C,
	output wire	OUT_2	
);

	wire [1:0]s1;
	assign s1[0] = B;
	assign s1[1] = A;
	mux4_1 op2(s1[1:0], C, ~C, ~C, C, OUT_2);
endmodule

module T1Mux2_1(
	input wire	A, B, C,
	output wire	OUT_3
	);
	
	wire s1, n1, n2;
	assign s1 = A;
	assign n1 = B^C;
	assign n2 = ~(B^C);
	mux2_1 op3(s1, n1, n2, OUT_3);
endmodule

module T2Mux8_1(
	input wire	A, B, C, hi, lo,
	output wire	OUT_4
	);

	wire [2:0]s1;
	assign s1[0] = C;
	assign s1[1] = B;
	assign s1[2] = A;

	mux8_1 op4(s1[2:0], hi, hi, lo, lo, lo, hi, hi, lo, OUT_4);
endmodule

module T2Mux4_1(
	input wire A, B, C,
	output wire OUT_5
	);
	
	wire	[1:0]s1, hi, lo;
	assign	hi = 1;
	assign	lo = 0;
	assign	s1[0] = B;
	assign	s1[1] = A;

	mux4_1 	op5(s1[1:0], hi, lo, hi, ~C, OUT_5);
endmodule

module T2Mux2_1(
	input wire A, B, C
	output wire OUT_6
	);
	wire	s1, x1, x2;
	assign	s1 = A;
	assign	x1 = ~B;
	assign	x2 = ~(B & C);

	mux2_1 op6(s1, x1, x2, OUT_6); 
endmodule 