//Carlos Cuellar 19275
//UVG Proyecteo1

//FlipFloptipoD 3bits
module FFD3B (input wire clk, rst, en,
			input wire [2:0] D, 
			output reg [2:0] Q);
  always @ (posedge clk or posedge rst) begin
    if (rst) begin
      Q <= 3'b0;
      end
    else if(en) begin
      Q <= D;
      end
  end
endmodule

//FlipFloptipoD 2bits
module FFD2B (input wire clk, rst, en,
			input wire [1:0] D, 
			output reg [1:0] Q);
  always @ (posedge clk or posedge rst) begin
    if (rst) begin
      Q <= 2'b0;
      end
    else if(en) begin
      Q <= D;
      end
  end
endmodule

//FlipFloptipoD 1bits
module FFD1B (input wire clk, rst, en,
			input wire D, 
			output reg Q);
  always @ (posedge clk or posedge rst) begin
    if (rst) begin
      Q <= 1'b0;
      end
    else if(en) begin
      Q <= D;
      end
  end
endmodule

//FlipFloptipoD 5bits
module FFD5B (input wire clk, rst, en,
			input wire [4:0] D, 
			output reg [4:0] Q);
  always @ (posedge clk or posedge rst) begin
    if (rst) begin
      Q <= 5'b0;
      end 

    else if (en) begin
      Q <= D;
      end
  end
endmodule

//Mux2:1 para debug
module mux2_1(
	input wire s1, A0, B0, output wire Y0
);

	assign Y0 = s1? B0:A0;
endmodule

//Modulo de antirebote de un pushb
module antirebote (
	input wire bot, clk, rst,
	output wire b_ar
);
wire A, B;
assign B = (~A & bot)|(A & bot);	 
FFD1B r0(clk, rst, 1'b1, B, A);
assign b_ar	  = (~A & bot);

endmodule

//Modulo de la primera FSM la cual habilita el modo 3 penales o 5 penales
module enable_conts(
	input wire M2, M1, clk, rst,
	output wire E3P, E5P
	);
wire [1:0]FS;
wire [1:0]S;
	assign  FS[1] = (S[1] & ~S[0])|(~S[0] & M2 & ~M1);
	assign  FS[0] =(~S[1] & S[0])| (~S[1] & ~M2 & M1) ;
FFD2B r1(clk, rst, 1'b1, FS, S);
	assign E5P = (S[1] & ~S[0])|(~S[0] & M2 & ~M1);
	assign E3P = (~S[1] & S[0])|(~S[1] & ~M2 & M1);

endmodule

//Modulo de la segunda FSM la cual es un contador de 0 a 3 penales (Modo 1 de juego)
module pen3(
	input wire K, noT, clk, rst, en,
	output wire [2:0] Cont3p,
	output wire FIN, ENJ3
);

wire [1:0]FS;
wire [1:0]S;
	assign FS[1] = (~S[1] & S[0] & K & ~noT)|(S[1]);
	assign FS[0] = (~S[1] & ~S[0] & K & ~noT)|(S[1] & K & ~noT)|(~S[1] & S[0] & noT)|(~S[1] & S[0] & ~K)|(S[1] & S[0]);
FFD2B r2(clk, rst, en, FS, S);
	assign Cont3p[2] = 1'b0;
	assign Cont3p[1] = (~S[1] & S[0] & K & ~noT)|(S[1]);
	assign Cont3p[0] = (~S[1] & ~S[0] & K & ~noT)|(S[1] & K & ~noT)|(~S[1] & S[0] & noT)|(~S[1] & S[0] & ~K)|(S[1] & S[0]);
	assign FIN = (S[1] & K & ~noT)|(S[1]&S[0]);
	assign ENJ3 = (~S[1] & S[0] & K & ~noT)|(~S[0] & noT)|(~S[0] & ~K)|(~S[1] & ~S[0] & K & ~noT)|(~S[1] & S[0] & noT)|(~S[1] & S[0] & ~K);

endmodule

//Modulo de la tercera FSM la cual es un contador de 0 a 5 penales (Modo 2 de juego)
module pen5(
	input wire K, noT, clk, rst, en,
	output wire [2:0] Cont5p,
	output wire FIN, ENJ5
	);
wire [2:0]FS;
wire [2:0]S;
	assign FS[2] = (S[2] & ~S[1])|(~S[2] & S[1] & S[0] & K & ~noT);
	assign FS[1] = (~S[2] & S[1] & ~S[0])|(~S[2] & S[1] & ~K)|(~S[2] & S[1] & noT)|(~S[2] & ~S[1] & S[0] & K & ~noT);
	assign FS[0] = (~S[2] & S[0] & ~K)|(~S[2] & S[0] & noT)|(~S[2] & ~S[0] & K & ~noT)|(S[2] & ~S[1] & S[0])|(S[2] & ~S[1] & K & ~noT);
FFD3B r3(clk, rst, en, FS, S);
	assign Cont5p[2] = (S[2] & ~S[1])|(~S[2] & S[1] & S[0] & K & ~noT);
	assign Cont5p[1] = (~S[2] & S[1] & ~S[0])|(~S[2] & S[1] & ~K)|(~S[2] & S[1] & noT)|(~S[2] & ~S[1] & S[0] & K & ~noT);
	assign Cont5p[0] = (~S[2] & S[0] & ~K)|(~S[2] & S[0] & noT)|(~S[2] & ~S[0] & K & ~noT)|(S[2] & ~S[1] & S[0])|(S[2] & ~S[1] & K & ~noT);
	assign FIN = (S[2] & ~S[1] & S[0])|(S[2] & ~S[1] & K & ~noT);
	assign ENJ5 = (~S[2])|(~S[1] & ~S[0] & ~K)|(~S[1] & ~S[0] & noT);

endmodule

module emp_contpen(
	input wire BM1, BM2, K, noT, clk, rst,
	output wire [2:0] Cont5p,
	output wire FIN5P, ENJ5,
	output wire [2:0] Cont3p,
	output wire FIN3P, ENJ3 
	);
wire UM1;
wire UM2;
wire UE3P;
wire UE5P;

antirebote r4(BM1, clk, rst, UM1);
antirebote r5(BM2, clk, rst, UM2);
enable_conts r6(UM1, UM2, clk, rst, UE3P, UE5P);
pen3 r7(K, noT, clk, rst, UE3P, Cont3p, FIN3P, ENJ3);
pen5 r8(K, noT, clk, rst, UE5P, Cont5p, FIN5P, ENJ5);
endmodule