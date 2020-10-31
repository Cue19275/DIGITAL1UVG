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

module FFT1B(input wire clk, rst, en,
             output wire K);
      wire T; 
      not (T, K);
      FFD1B r(clk, rst, en, T, K);
endmodule