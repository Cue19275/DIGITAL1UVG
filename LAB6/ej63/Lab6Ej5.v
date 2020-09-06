//UVG Lab 6 
//Carlos Cuellar 19275

module FFDEj5(input wire clck, rset, set, 
			  input wire [3:0] D, 
			  output reg [3:0] Q);
always @ (posedge clck or posedge rset) begin
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

module FFD (
	input wire D1,   
	input wire clk, 
	input wire reset,
	output reg  Q1  	
);

always @(posedge clk) 
begin
 if(reset==1'b1)
  Q1 <= 1'b0; 
 else 
  Q1 <= D1; 
end 

endmodule

module Ej61(input wire A, B, clck1, rset,
			output wire Y1);
wire S1F, S0F, S1, S0;

assign S1F = (S1 & A & B)|(S0 & B);
assign S0F = (~S1 & ~S0 & A);
assign Y1   = (S1 & A & B); 

FFD r0(S0F, clck1, rset, S0);
FFD r1(S1F, clck1, rset, S1);

endmodule

module Ej62 (
	input wire A, clck2, rset,
	output wire Y0, Y1, Y2
);

wire S2F, S1F, S0F, S2, S1, S0;

assign S2F = (~S2 & S1 & S0 & A) | (~S2 & ~S1 & ~S0 & ~A) | (S2 & ~S1 & S0) | (S2 & ~S0 & A) | (S2 & S1 & ~A); 
assign S1F = (~S1 & S0 & A) | (S1 & ~S0 & A) | (S1 & S0 & ~A) | (~S1 & ~S0 & ~A);
assign S0F = (~S0);

assign Y2 = (S2);
assign Y1 = (~S2 & S1) | (S2 & ~S1);
assign Y0 = (~S1 & S0) | (S1 & ~S0);

FFD k0(S0F, clck2, rset, S0);
FFD k1(S1F, clck2, rset, S1);
FFD k2(S2F, clck2, rset, S2);

endmodule

