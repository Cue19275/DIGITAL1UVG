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

module FFD2B(
      input wire clk, rst, en,
      input wire [1:0]D, 
      output wire [1:0]Q
      );

      FFD1B r0(clk, rst, en, D[0], Q[0]);
      FFD1B r1(clk, rst, en, D[1], Q[1]);

endmodule

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

module Contador (
      input wire clk,    // Clock
      input wire clk_en, // Clock Enable
      input wire rst,
      input wire load_en,
      input wire  [11:0] L,
      output reg  [11:0] Q
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

module union (
      input wire clk, rst, enC, enL, enF,
      input wire [11:0] in,
      output wire [3:0]Q1,
      output wire [3:0]Q2  
      );
      wire [11:0]Cuenta;
      wire [7:0]Fet;

      Contador p1(clk, enC, rst, enL, in, Cuenta);
      ROM      p2(Cuenta, Fet);
      fetch    p3(clk, rst, enF, Fet, Q1, Q2);


endmodule