//Carlos Cuellar #19275 UVG
//Código de la práctica 4 de lab Digital 1

module Ecuacion1_1(input wire A, B, C, output wire Y);

wire out0;
wire out1;
wire out2;
wire out3;
wire out4;
wire out5;


not (out0, A);
not (out1, B);
not (out2, C);
and (out3, out0, out2);
and (out4, A, out1);
and (out5, A, C);
or (Y, out3, out4, out5);
endmodule

module Ecuacion1_2(input wire B, output wire Y);

not (Y, B);

endmodule

module Ecuacion1_3(input wire A, B, C, D, output wire Y);
wire o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11;

not (o0, A);
not (o1, B);
not (o2, C);
not (o3, D);
and (o4, o0, o1, o2, o3);
and (o5, o0, o1, C, D);
and (o6, o0, B, o2, D);
and (o7, o0, B, C, o3);
and (o8, A, B, o2, o3);
and (o9, A, B, C, D);
and (o10, A, o1, o2, D);
and (o11, A, o1, C, o3);
or (Y, o4, o5, o6, o7, o8, o9, o10, o11);

endmodule


module Ecuacion1_4(input wire A, B, C, D, output wire Y);
wire out0, out1, out2, out3;

not (out0, D);
and (out1, A, out0);
and (out2, B, D);
and (out3, A, C);
or (Y, out1, out2, out3);

endmodule

module Ecuacion2_1(input wire A, B, C, D, output wire Y);

assign Y = (~B & ~C & ~D) | (A & (~B | ~C | ~D));

endmodule

module Ecuacion2_3(input wire A, B, C, D, output wire Y);

assign Y = (B | (D & (A | ~C)));

endmodule

module Ecuacion2_2(input wire A, B, C, output wire Y);

assign Y = (C | ~B);

endmodule


module Ecuacion2_4(input wire A, B, C, output wire Y);

assign Y = ((~A & ~C) | B);

endmodule

module Ecuacion5_SOP(input wire A, B, C, output wire Y);

assign Y = ((A & ~B & ~C) | (A & ~B & C) | (A & B & C));

endmodule

module Ecuacion5_POS(input wire A, B, C, output wire Y);

assign Y = ((A | B | C) & (A | B | ~C) & (A |~B | C) & (A | ~B | ~C) & (~A| ~B | C));

endmodule

module Ecuacion5_OG(input wire A, B, C, output wire Y);

wire out0;
wire out1;
wire out2; 
not (out0, B);
and (out1, out0, A);
and (out2, A, C);
or (Y, out1, out2);

endmodule