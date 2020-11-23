//Intento de RAM
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

