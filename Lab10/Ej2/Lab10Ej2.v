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

module FFD2B(
      input wire clk, rst, en,
      input wire [1:0]D, 
      output wire [1:0]Q
      );

      FFD1B r0(clk, rst, en, D[0], Q[0]);
      FFD1B r1(clk, rst, en, D[1], Q[1]);

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
            output reg C, Z, 
            output reg [3:0] O
      );
      reg [4:0] AI;

      always @ (W, B, Sel)
      begin
      case (Sel)
            3'b000:
            begin 
            AI = 5'b00000;
            AI = W;
            C = 0;
            Z = 0;
            O = AI[3:0];
      end
      3'b010:
            begin 
            AI = 5'b00000;
            AI = B;
            C = 0;
            Z = 0;
            O = AI[3:0];
      end
      3'b100:
            begin 
            AI = 5'b00000;
            AI = ~(W&B);
            C = 0;
            Z = 0;
            O = AI[3:0];
      end
      3'b001:
            begin 
            AI = 5'b00000;
            AI = W-B;
            C = AI[4];
            Z = (AI==5'b00000);
            O = AI[3:0];
      end
      3'b011:
            begin 
            AI = 5'b00000;
            AI = W+B;
            C = AI[4];
            Z = (AI==5'b00000);
            O = AI[3:0];
      end
      endcase // Sel
end
endmodule

module bufftri4b(
      input wire en,
      input wire [3:0]S,
      output wire [3:0]Q
      );

      assign Q = en ? S:4'bz;

endmodule

module unionalu (
      input wire clk, rst, en, enb1, enb2,  
      input wire [3:0] in,
      input wire [2:0] Sel, 
      output wire C, Z, 
      output wire [3:0] O
      );
      wire [3:0] BB; 
      wire [3:0]ALUB; 
      wire [3:0]ACB; 
      wire [3:0]OALU;
     bufftri4b p0(enb1, in, BB);
     Acumulador P1(clk, rst, en, OALU, ACB);
     Alu          p2(ACB, BB, Sel, C, Z, OALU);
     bufftri4b    p3(enb2, OALU, O);

endmodule