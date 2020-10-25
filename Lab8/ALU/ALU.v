//UVG DIGITAL 1 2020//UVG Digital 1 2020
//Carlos Cuellar 19275
//Lab8_Ej3

module ALU_BB(
	input wire 	[3:0]A,
	input wire 	[3:0]B,
	input wire 	[2:0]SEL,
	output reg	[3:0]Y
	);
	always @ (*)
	begin
	case (SEL)
		3'b000:  Y = A & B ;
		3'b001:  Y = A | B;
		3'b010:  Y = A + B;

		3'b100:  Y = A & ~B;
		3'b101:  Y = A | ~B;
		3'b110:  Y = A - B;
		3'b111:  Y = (A > B)?3'b001 : 3'b000;
		default :  Y = A & B;
	endcase
	end
endmodule