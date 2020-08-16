//Carlos Cuellar #19275 UVG
//Código Lab5 Digital I

module testbench();
	reg p1, p2, p3;
	wire Y1, Y2, Y3, Y4, Y5, Y6, hi, lo;
	assign hi = 1; 
	assign lo = 0;

	T1Mux8_1 op1(p1, p2, p3, hi, lo, Y1);
	T1Mux4_1 op2(p1, p2, p3, Y2);
	T1Mux2_1 op3(p1, p2, p3, Y3);
	T2Mux8_1 op4(p1, p2, p3, hi, lo, Y4);
	T2Mux4_1 op5(p1, p2, p3, Y5);
	T2Mux2_1 op6(p1, p2, p3, Y6);

initial begin
	$display("T1Mux8_1");
	$display("A B C | Y1");
	$display("----------");

	$monitor("%b %b %b | %b", p1, p2, p3, Y1);
		p1 = 0; p2 = 0; p3 = 0;
	#1 p3 = 1;
    #1 p2 = 1; p3 = 0;
    #1 p3 = 1;
    #1 p1 = 1; p2 = 0; p3 = 0;
    #1 p3 = 1;
    #1 p2 = 1; p3 = 0;
    #1 p3 = 1;
  end

  initial begin
 #10
 	$display("\n");
 	$display("T1Mux4_1");
	$display("A B C | Y2");
	$display("----------");

	$monitor("%b %b %b | %b", p1, p2, p3, Y2);
		p1 = 0; p2 = 0; p3 = 0;
	#1 p3 = 1;
    #1 p2 = 1; p3 = 0;
    #1 p3 = 1;
    #1 p1 = 1; p2 = 0; p3 = 0;
    #1 p3 = 1;
    #1 p2 = 1; p3 = 0;
    #1 p3 = 1;
  end

    initial begin
 #19
 	$display("\n");
 	$display("T1Mux2_1");
	$display("A B C | Y3");
	$display("----------");

	$monitor("%b %b %b | %b", p1, p2, p3, Y3);
		p1 = 0; p2 = 0; p3 = 0;
	#1 p3 = 1;
    #1 p2 = 1; p3 = 0;
    #1 p3 = 1;
    #1 p1 = 1; p2 = 0; p3 = 0;
    #1 p3 = 1;
    #1 p2 = 1; p3 = 0;
    #1 p3 = 1;
  end
   
    initial begin
 #28
 	$display("\n");
 	$display("T2Mux8_1");
	$display("A B C | Y4");
	$display("----------");

	$monitor("%b %b %b | %b", p1, p2, p3, Y4);
		p1 = 0; p2 = 0; p3 = 0;
	#1 p3 = 1;
    #1 p2 = 1; p3 = 0;
    #1 p3 = 1;
    #1 p1 = 1; p2 = 0; p3 = 0;
    #1 p3 = 1;
    #1 p2 = 1; p3 = 0;
    #1 p3 = 1;
  end

    initial begin
 #37
 	$display("\n");
 	$display("T2Mux4_1");
	$display("A B C | Y5");
	$display("----------");

	$monitor("%b %b %b | %b", p1, p2, p3, Y5);
		p1 = 0; p2 = 0; p3 = 0;
	#1 p3 = 1;
    #1 p2 = 1; p3 = 0;
    #1 p3 = 1;
    #1 p1 = 1; p2 = 0; p3 = 0;
    #1 p3 = 1;
    #1 p2 = 1; p3 = 0;
    #1 p3 = 1;
  end

    initial begin
 #46
 	$display("\n");
 	$display("T2Mux2_1");
	$display("A B C | Y6");
	$display("----------");

	$monitor("%b %b %b | %b", p1, p2, p3, Y6);
		p1 = 0; p2 = 0; p3 = 0;
	#1 p3 = 1;
    #1 p2 = 1; p3 = 0;
    #1 p3 = 1;
    #1 p1 = 1; p2 = 0; p3 = 0;
    #1 p3 = 1;
    #1 p2 = 1; p3 = 0;
    #1 p3 = 1;
  end

initial
	#55 $finish;

initial begin
	$dumpfile("lab5_tb.vcd");
	$dumpvars(0, testbench);
end

endmodule