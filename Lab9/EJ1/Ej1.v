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