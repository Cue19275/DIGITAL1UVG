module ROM(
	input wire [11:0] DIR,
	output wire [7:0] Y
	);
	
	
	reg [7:0] memoria [0:4095];
	
	initial begin
		$readmemh("memory.list", memoria);
	end
	assign Y = memoria[DIR];
endmodule 


module Contador (
	input wire clk,    // Clock
	input wire clk_en, // Clock Enable
	input wire rst,
	input wire load_en,
	input wire  [11:0] L,
	output reg	[11:0] Q
	);
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
		Q <= 12'b0;
		end
		else if(load_en) begin
		Q <= L;
		end
		else if(clk_en) begin
		Q <= Q + 1;
		end
	end

endmodule

module microCode(
	input wire [6:0]S, 
	output reg [12:0]Q
	);
	always @ (S)
	begin
		casex (S)
			7'bxxxxxx0:	Q = 13'b1000000001000;
			7'b00001x1: Q = 13'b0100000001000;
			7'b00000x1: Q = 13'b1000000001000;
			7'b00011x1: Q = 13'b1000000001000;
			7'b00010x1: Q = 13'b0100000001000;
			7'b0010xx1: Q = 13'b0001001000010;
			7'b0011xx1: Q = 13'b1001001100000;
			7'b0100xx1: Q = 13'b0011010000010;
			7'b0101xx1: Q = 13'b0011010000100;
			7'b0110xx1: Q = 13'b1011010100000;
			7'b0111xx1: Q = 13'b1000000111000;
			7'b1000x11: Q = 13'b0100000001000;
			7'b1000x01: Q = 13'b1000000001000;
			7'b1001x11: Q = 13'b1000000001000;
			7'b1001x01: Q = 13'b0100000001000;
			7'b1010xx1: Q = 13'b0011011000010;
			7'b1011xx1: Q = 13'b1011011100000;
			7'b1100xx1: Q = 13'b0100000001000;
			7'b1101xx1: Q = 13'b0000000001001;
			7'b1110xx1: Q = 13'b0011100000010;
			7'b1111xx1: Q = 13'b1011100100000;
			default : Q = 13'b1000000001000;
		endcase
	end
endmodule

//Puede ser varias cosas
module bufftri(
	input wire en,
	input wire [3:0]S,
	output wire [3:0]Q
	);

	assign Q = en ? S:4'bz;

endmodule

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

module FFT(input wire clk, rst,
             output wire K);
	wire T; 
	not (T, K);
    FFD1B r(clk, rst, 1'b1, T, K);

endmodule

module FFD2B(
      input wire clk, rst, en,
      input wire [1:0]D, 
      output wire [1:0]Q
      );

      FFD1B r0(clk, rst, en, D[0], Q[0]);
      FFD1B r1(clk, rst, en, D[1], Q[1]);

endmodule

//Puede ser varias cosas
module FFD4B(
      input wire clk, rst, en,
      input wire [3:0]D, 
      output wire [3:0]Q
      );

      FFD2B r2(clk, rst, en, D[1:0], Q[1:0]);
      FFD2B r3(clk, rst, en, D[3:2], Q[3:2]);

endmodule

module fetch(
      input wire clk, rst, en,
      input wire [7:0]D, 
      output wire [3:0]Q1,
      output wire [3:0]Q2
      );
      FFD4B r4(clk, rst, en, D[7:4], Q1[3:0]);
      FFD4B r5(clk, rst, en, D [3:0], Q2[3:0]);

endmodule

module Acumulador(
      input wire clk, rst, en,
      input wire [3:0]D, 
      output wire [3:0]Q
      );

      FFD2B r2(clk, rst, en, D[1:0], Q[1:0]);
      FFD2B r3(clk, rst, en, D[3:2], Q[3:2]);
endmodule

module Alu(input wire [3:0] W, 
            input wire [3:0]B, 
            input wire [2:0] Sel, 
            output wire carry, zero, 
            output reg [3:0] O
      );
			wire z;
			reg  c;

      		always @ (*) begin
      		case(Sel)
      		0:
      		{c, O} <= W;
      		1:
      		{c, O} <= W-B;
      		2:
      		{c, O} <= B; 
      		3:
      		{c, O} <= W+B;
      		4:
      		{c, O} <= {1'b0, ~(W & B)};
      		default
      		{c, O} <= 5'b0;
      	endcase
      end
      assign z = (O == 4'b0) ? 1'b1:1'b0;
      assign carry = c;
      assign zero = z;

endmodule

module RAM(
	input wire cs, we, //chipselect y write enable
	input wire [11:0] dir, //dirección de la memoria
	inout [3:0] data
	);
	reg [3:0] dataO; 
	reg [3:0] mem [0:4095]; //arreglo de la memoria

	assign data = (cs & !we)? dataO: 4'bz; //Buffer tri-estado 

	always @ (dir or data or cs or we)
	begin 
		if ( cs && we) begin
			mem[dir] = data;
		end
	end

	always @ (dir or cs or we)
	begin
		if (cs && !we) begin
			dataO = mem[dir];
		end
	end 

endmodule 


module uP(
	input wire clock, reset,
	input wire [3:0] pushbuttons,
	output wire phase, c_flag, z_flag,
	output wire [3:0] instr,
	output wire [3:0] oprnd,
	output wire [3:0] data_bus,
	output wire [3:0] FF_out,
	output wire [3:0] accu,
	output wire [7:0] program_byte,
	output wire [11:0] PC,
	output wire [11:0] address_RAM	
	);
	wire [12:0] microCode_O;
	wire [3:0]  ALU_O;
	wire Zero;
	wire Carry;
	wire [6:0] microCode_I;
	assign address_RAM = {oprnd, program_byte};
	assign microCode_I = {instr, c_flag, z_flag, phase}; //instr carry zero phase **CAMBIAR DEPSUES
	Contador pcmod(clock, microCode_O[12], reset, microCode_O[11], address_RAM, PC);
	ROM 	 romterm(PC, program_byte);
	fetch    fetchmod(clock, reset, ~phase, program_byte, instr, oprnd);
	FFT		 phasemod(clock, reset, phase);
	FFD2B    flags(clock, reset, microCode_O[9], {Zero, Carry}, {z_flag, c_flag});	
	microCode decodemod(microCode_I, microCode_O);
	bufftri  bfetch(microCode_O[1], oprnd, data_bus);
	RAM      rammod(microCode_O[5], microCode_O[4],address_RAM, data_bus);
	Acumulador     acumod(clock, reset, microCode_O[10], ALU_O, accu);
	Alu      alumod(accu, data_bus, microCode_O[8:6], Carry, Zero, ALU_O);
	bufftri bALU(microCode_O[3], ALU_O, data_bus);
	bufftri bIn(microCode_O[2], pushbuttons, data_bus);
	FFD4B   outmod(clock, reset, microCode_O[0], data_bus, FF_out);

endmodule

//Fetch 8 accu 4 output 4 