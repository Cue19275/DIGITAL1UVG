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

module JKFF1B (
      input wire clk, rst, en,
      input wire J, K,
      output wire P
      );
      wire Q;

      assign Q = (J & ~P) | (~K & P);


      FFD1B t(clk, rst, en, Q, P);
endmodule