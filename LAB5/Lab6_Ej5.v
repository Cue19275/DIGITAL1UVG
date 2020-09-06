//UVG Lab 6 
//Carlos Cuellar 19275

module FFDEj5 (
	input wire clck, rset, set, [3:0]D, 
	output reg[3:0]Q
);

always @ (posedge clck, posedge rset) begin
	if (rset)begin 
		Q <= 4'b0;
	end
	else if (set) begin
		Q <= 4'b1111;/* code */
	end
	else
		Q <= D;
	end

endmodule

