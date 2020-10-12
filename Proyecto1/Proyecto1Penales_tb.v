module testbench();
wire [2:0] Cont5p;
wire FIN5P, ENJ5;
wire [2:0] Cont3p;
wire FIN3P, ENJ3;
reg M1, M2, K, noT;
reg D1, D2, D3, D4, D5, P1, P2, P3, P4, P5;
wire [2:0] MGK;
wire [2:0] MFWD;

wire Y;
reg  bot, clk, rst, en;

emp_contpen r1(M1, M2, K, noT, clk, rst, en, Cont5p, FIN5P, Cont3p, FIN3P, ENGAME);
antirebote  d9(bot, clk, rst, en, Y);
emp_game d14(K, D1, D2, D3, D4, D5, P1, P2, P3, P4, P5, en, clk, rst, en, MGK, MFWD, KK, y);
always 
    #2 clk <= ~clk;
    initial begin
  $display("Proyecto Penales");
  $display("clk   rst   M1   M2   K   noT| Cont5p    FIN5P     ENJ5     Cont3p    FIN3P     ENJ3");
  $display("-----------------------------|--------------------------");
  $monitor("%b     %b      %b    %b   %b   %b| %b %b     %b %b %b ", clk, rst, M1, M2, K, noT, Cont5p, FIN5P, Cont3p, FIN3P, ENGAME);
     rst = 0; clk = 1; en= 1;
     #4 rst = 1; M2 = 0; M1 = 0; K = 0; noT = 0; 
     #4 rst = 0; M2 = 0; M1 = 0; K = 0; noT = 0; 
     #4  M2 = 0; M1 = 0; K = 0; noT = 0; 
     #4  M2 = 0; M1 = 1; K = 0; noT = 0;
     #4  M2 = 0; M1 = 0; K = 0; noT = 0;
     #4  M2 = 0; M1 = 0; K = 1; noT = 0;
     #4  M2 = 0; M1 = 0; K = 0; noT = 0;
     #4  M2 = 0; M1 = 0; K = 1; noT = 0;
     #4  M2 = 0; M1 = 0; K = 0; noT = 0;
     #4  M2 = 0; M1 = 0; K = 1; noT = 0;
     #4  M2 = 0; M1 = 0; K = 0; noT = 0;
     #4  M2 = 0; M1 = 0; K = 1; noT = 0;
     #4  M2 = 0; M1 = 0; K = 0; noT = 0;
     #4  M2 = 0; M1 = 0; K = 1; noT = 0;
     #4  M2 = 0; M1 = 0; K = 0; noT = 0;
     #4 rst = 1; M2 = 0; M1 = 0; K = 0; noT = 0; 
     #4 rst = 0; M2 = 0; M1 = 0; K = 0; noT = 0;
     #4  M2 = 0; M1 = 0; K = 0; noT = 0; 
     #4  M2 = 1; M1 = 0; K = 0; noT = 0;
     #4  M2 = 0; M1 = 0; K = 0; noT = 0;
     #4  M2 = 0; M1 = 0; K = 1; noT = 0;
     #4  M2 = 0; M1 = 0; K = 0; noT = 0;
     #4  M2 = 0; M1 = 0; K = 1; noT = 0;
     #4  M2 = 0; M1 = 0; K = 0; noT = 0;
     #4  M2 = 0; M1 = 0; K = 1; noT = 0;
     #4  M2 = 0; M1 = 0; K = 0; noT = 0;
     #4  M2 = 0; M1 = 0; K = 1; noT = 0;
     #4  M2 = 0; M1 = 0; K = 0; noT = 0;
end
initial begin
	#107
	$display("\n");
  $display("Proyecto Penales");
  $display("clk   rst    K  | MGK    MFWD");
  $display("--------------- |--------------------------");
  $monitor(" %b    %b   %b  | %b 	%b    ", clk, rst, K, MGK, MFWD);
     rst = 0; clk = 1; en= 1;
     #4 rst = 1; K = 0; D1 = 0; D2 = 0; D3 = 0; D4 = 0; D5 = 0; P1 = 0; P2 = 0; P3 = 0; P4 = 0; P5 = 0;  
     #4 rst = 0; K = 0; D1 = 1; D2 = 0; D3 = 0; D4 = 0; D5 = 0; P1 = 1; P2 = 0; P3 = 0; P4 = 0; P5 = 0; 
     #4  K = 0;
     #4  K = 1;
     #4  K = 0;
     #4  K = 1;
     #4  K = 0;
     #4  K = 1;
     #4  K = 0;
     #4  K = 1;
     #4  K = 0;
     #4  K = 1;
     #4  K = 0;
     #4 rst = 1; M2 = 0; M1 = 0; K = 0; noT = 0; 
     #4 rst = 0; M2 = 0; M1 = 0; K = 0; noT = 0;
     #4 rst = 1; K = 0; D1 = 0; D2 = 0; D3 = 0; D4 = 0; D5 = 0; P1 = 0; P2 = 0; P3 = 0; P4 = 0; P5 = 0;  
     #4 rst = 0; K = 0; D1 = 1; D2 = 0; D3 = 0; D4 = 0; D5 = 0; P1 = 0; P2 = 1; P3 = 0; P4 = 0; P5 = 0; 
     #4  K = 0;
     #4  K = 1;
     #4  K = 0;
     #4  K = 1;
     #4  K = 0;
     #4  K = 1;
     #4  K = 0;
     #4  K = 1;
     #4  K = 0;
     #4  K = 1;
     #4  K = 0;
     #4 rst = 1; M2 = 0; M1 = 0; K = 0; noT = 0; 
     #4 rst = 0; M2 = 0; M1 = 0; K = 0; noT = 0;
 end

  initial
    #250 $finish;
  initial begin
      $dumpfile("Proyecto1Penales_tb.vcd");
      $dumpvars(0, testbench);
    end
  endmodule
