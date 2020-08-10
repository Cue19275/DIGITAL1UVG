
module testbench();
	reg p1, p2, p3, p4, p5,p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18;
	wire Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8,Y9, Y10, Y11;

	Ecuacion1_1 EQ1(p1, p2, p3, Y1);
	Ecuacion1_2 EQ2(p4, Y2);
	Ecuacion1_3 EQ3(p5, p6, p7, p8, Y3);
	Ecuacion1_4 EQ4(p5, p6, p7, p8, Y4);
	Ecuacion2_1 EQ5(p12, p11, p10, p9, Y5);
	Ecuacion2_3 EQ6(p12, p11, p10, p9, Y6);
	Ecuacion2_2 EQ7(p13, p14, p15, Y7);
	Ecuacion2_4 EQ8(p13, p14, p15, Y8);
	Ecuacion5_SOP EQ9(p16, p17, p18, Y9);
	Ecuacion5_POS EQ10(p16, p17, p18, Y10);
	Ecuacion5_OG EQ11(p16, p17, p18, Y11);



initial begin
	$display("EQ1_1");
	$display("A B C | Y1");
	$display("---------");

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
#9
	$display("\n");
	$display("EQ1_2");
	$display("B | Y2");
	$display("------");
	$monitor("%b | %b", p4, Y2);
	p4=0;
	#1 p4 = 1;
  end

initial begin
#11
	$display("\n");
	$display("EQ1_3 y EQ1_4");
	$display("A B C D | Y3 Y4");
	$display("------------");
	$monitor("%b %b %b %b | %b  %b", p5, p6, p7, p8, Y3, Y4);
	   p5 = 0; p6 = 0; p7 = 0; p8 = 0;
	#1 p8 = 1;
	#1 p8 = 0; p7 = 1;
	#1 p8 = 1; 
	#1 p8 = 0; p7 = 0; p6 = 1;
	#1 p8 = 1;
	#1 p8 = 0; p7 = 1;
	#1 p8 = 1;
	#1 p8 = 0; p7 = 0; p6 = 0; p5 = 1;
	#1 p8 = 1;
	#1 p8 = 0; p7 = 1; 
	#1 p8 = 1; 
	#1 p8 = 0; p7 = 0; p6 = 1; 
	#1 p8 = 1;
	#1 p8 = 0; p7 = 1;
	#1 p8 = 1;
	end

initial begin
#27
	$display("\n");
	$display("EQ2_1 y EQ2_3");
	$display("A B C D | Y5 Y6");
	$display("------------");
	$monitor("%b %b %b %b | %b  %b", p12, p11, p10, p9, Y5, Y6);
	   p9 = 0; p10 = 0; p11 = 0; p12 = 0;
	#1 p9 = 1;
	#1 p9 = 0; p10 = 1;
	#1 p9 = 1; 
	#1 p9 = 0; p10 = 0; p11 = 1;
	#1 p9 = 1;
	#1 p9 = 0; p10 = 1;
	#1 p9 = 1;
	#1 p9 = 0; p10 = 0; p11 = 0; p12 = 1;
	#1 p9 = 1;
	#1 p9 = 0; p10 = 1; 
	#1 p9 = 1; 
	#1 p9 = 0; p10 = 0; p11 = 1; 
	#1 p9 = 1;
	#1 p9 = 0; p10 = 1;
	#1 p9 = 1;
	end

	initial begin
#43
	$display("\n");
	$display("EQ2_2 y EQ2_4");
	$display("A B C | Y7 Y8");
	$display("------------");
	$monitor("%b %b %b | %b  %b", p15, p14, p13, Y7, Y8);
	   p15 = 0; p14 = 0; p13 = 0;
    #1 p15 = 1;
    #1 p14 = 1; p15 = 0;
    #1 p15 = 1;
    #1 p13 = 1; p14 = 0; p15 = 0;
    #1 p15 = 1;
    #1 p14 = 1; p15 = 0;
    #1 p15 = 1;
	end

	initial begin
#51
	$display("\n");
	$display("Ejercicio 5");
	$display("A B C | Y9 Y10 Y11");
	$display("-----------------");
	$monitor("%b %b %b | %b  %b  %b", p16, p17, p18, Y9, Y10, Y11);
	   p16 = 0; p17 = 0; p18 = 0;
    #1 p18 = 1;
    #1 p17 = 1; p18 = 0;
    #1 p18 = 1;
    #1 p16 = 1; p17 = 0; p18 = 0;
    #1 p18 = 1;
    #1 p17 = 1; p18 = 0;
    #1 p18 = 1;
	end

initial 
	#59 $finish;


initial begin
    $dumpfile("EJ4_tb.vcd");
    $dumpvars(0, testbench);
  end
  
endmodule