//Tristate buffer
module bufftri(
	input wire en,
	input wire [3:0]S,
	output wire [3:0]Q
	);

	assign Q = en ? S:4'bz;

endmodule