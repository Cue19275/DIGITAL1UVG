//UVG DIGITAL 1 2020//UVG Digital 1 2020
//Carlos Cuellar 19275
//Lab8_Ej2

module ROM(
	input wire [11:0] DIR,
	output wire [7:0] Y
	);
	
	assign Y = memoria[DIR];
	reg [7:0] memoria [0:4095];
	
	initial begin
		$readmemh("datos.list", memoria);
	end

endmodule 