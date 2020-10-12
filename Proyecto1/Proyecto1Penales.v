//Carlos Cuellar 19275
//UVG Proyecteo1

//FlipFloptipoD 3bits
module FFD3B (input wire clk, rst, en,
            input wire [2:0] D, 
            output reg [2:0] Q);
            always @ (posedge clk or posedge rst) begin
           if (rst) begin
           Q <= 3'b0;
            end
            else if(en) begin
           Q <= D;
            end
            end
endmodule

//FlipFloptipoD 2bits
module FFD2B (input wire clk, rst, en,
            input wire [1:0] D, 
            output reg [1:0] Q);
            always @ (posedge clk or posedge rst) begin
            if (rst) begin
            Q <= 2'b0;
            end
            else if(en) begin
           Q <= D;
            end
            end
endmodule

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

//FlipFloptipoD 5bits
module FFD5B (input wire clk, rst, en,
            input wire [4:0] D, 
            output reg [4:0] Q);
            always @ (posedge clk or posedge rst) begin
            if (rst) begin
           Q <= 5'b0;
           end 

            else if (en) begin
            Q <= D;
            end
            end
endmodule

//Mux2:1 para debug
module mux2_1(
    input wire s1, A0, B0, output wire Y0
    );

    assign Y0 = s1? B0:A0;
endmodule

//Modulo de antirebote de un pushb
module antirebote (
    input wire bo, clk, rst, en,
    output wire bar
    );
    wire Alv, B;
    assign B = (~Alv & bo)|(Alv & bo);     
    FFD1B r0(clk, rst, en, B, Alv);
    assign bar= (~Alv & bo);
endmodule

//Modulo de la primera FSM la cual habilita el modo 3 penales o 5 penales
module enable_conts(
    input wire M2, M1, clk, rst,
    output wire E3P, E5P
    );
    wire [1:0]FS;
    wire [1:0]S;
    assign  FS[1] = (S[1] & ~S[0])|(~S[0] & M2 & ~M1);
    assign  FS[0] =(~S[1] & S[0])| (~S[1] & ~M2 & M1) ;
    FFD2B r1(clk, rst, 1'b1, FS, S);
    assign E5P = (S[1] & ~S[0])|(~S[0] & M2 & ~M1);
    assign E3P = (~S[1] & S[0])|(~S[1] & ~M2 & M1);
endmodule

//Modulo de la segunda FSM la cual es un contador de 0 a 3 penales (Modo 1 de juego)
module pen3(
    input wire K, noT, clk, rst, en,
    output wire [2:0] Cont3p,
    output wire FIN, ENJ3
    );

    wire [1:0]FS;
    wire [1:0]S;
    assign FS[1] = (~S[1] & S[0] & K & ~noT)|(S[1]);
    assign FS[0] = (~S[1] & ~S[0] & K & ~noT)|(S[1] & K & ~noT)|(~S[1] & S[0] & noT)|(~S[1] & S[0] & ~K)|(S[1] & S[0]);
    FFD2B r2(clk, rst, en, FS, S);
    assign Cont3p[2] = 1'b0;
    assign Cont3p[1] = (~S[1] & S[0] & K & ~noT)|(S[1]);
    assign Cont3p[0] = (~S[1] & ~S[0] & K & ~noT)|(S[1] & K & ~noT)|(~S[1] & S[0] & noT)|(~S[1] & S[0] & ~K)|(S[1] & S[0]);
    assign FIN = (S[1] & K & ~noT)|(S[1]&S[0]);
    assign ENJ3 = (~S[1] & S[0] & K & ~noT)|(~S[0] & noT)|(~S[0] & ~K)|(~S[1] & ~S[0] & K & ~noT)|(~S[1] & S[0] & noT)|(~S[1] & S[0] & ~K);
endmodule

//Modulo de la tercera FSM la cual es un contador de 0 a 5 penales (Modo 2 de juego)
module pen5(
        input wire K, noT, clk, rst, en,
        output wire [2:0] Cont5p,
        output wire FIN, ENJ5
        );
        wire [2:0]FS;
       wire [2:0]S;
        assign FS[2] = (S[2] & ~S[1])|(~S[2] & S[1] & S[0] & K & ~noT);
        assign FS[1] = (~S[2] & S[1] & ~S[0])|(~S[2] & S[1] & ~K)|(~S[2] & S[1] & noT)|(~S[2] & ~S[1] & S[0] & K & ~noT);
        assign FS[0] = (~S[2] & S[0] & ~K)|(~S[2] & S[0] & noT)|(~S[2] & ~S[0] & K & ~noT)|(S[2] & ~S[1] & S[0])|(S[2] & ~S[1] & K & ~noT);
        FFD3B r3(clk, rst, en, FS, S);
        assign Cont5p[2] = (S[2] & ~S[1])|(~S[2] & S[1] & S[0] & K & ~noT);
        assign Cont5p[1] = (~S[2] & S[1] & ~S[0])|(~S[2] & S[1] & ~K)|(~S[2] & S[1] & noT)|(~S[2] & ~S[1] & S[0] & K & ~noT);
        assign Cont5p[0] = (~S[2] & S[0] & ~K)|(~S[2] & S[0] & noT)|(~S[2] & ~S[0] & K & ~noT)|(S[2] & ~S[1] & S[0])|(S[2] & ~S[1] & K & ~noT);
        assign FIN = (S[2] & ~S[1] & S[0])|(S[2] & ~S[1] & K & ~noT);
        assign ENJ5 = (~S[2])|(~S[1] & ~S[0] & ~K)|(~S[1] & ~S[0] & noT);

endmodule

module FSM_game (
    input wire C, K, noT, clk, rst, en,
    output wire [2:0] MP,
    output wire [2:0] MD
      );
    wire [4:0]FS;
    wire [4:0]S;
    assign FS[4]= (S[4] & ~S[3] & ~S[2] & ~C)|(S[4] & ~S[3] & ~S[2] & ~K)|(S[4] & ~S[3] & ~S[2] & noT)|(S[4] & ~S[3] & ~S[2] & ~S[1] & ~S[0])|(~S[3] & ~S[2] & ~S[1] & ~S[0] & ~C & K & ~noT);
    assign FS[3]= (~S[4] & S[3])|(~S[4] & S[2] & S[1] & S[0] & K & ~noT)|(~S[4] & S[1] & S[0] & ~C & K & ~noT)|(~S[4] & S[2] & ~S[0] & ~C & K & ~noT)|(S[4] & ~S[3] & ~S[2] & S[1] & C & K & ~noT)|(S[4] & ~S[3] & ~S[2] & S[0] & C & K & ~noT);
    assign FS[2]= (~S[4] & S[2] & ~K)|(~S[4] & S[2] & noT)|(~S[4] & S[2] & ~S[0] & C)|(S[4] & ~S[3] & S[2] & ~S[1] & ~S[0])|(~S[4] & S[3] & ~S[0] & ~C & K & ~noT)|(S[4] & ~S[3] & ~S[2] & S[1] & S[0] & K & ~noT)|(~S[4] & ~S[3] & ~S[1] & S[0] & ~C & K & ~noT)|(~S[4] & ~S[2] & S[1] & ~S[0] & ~C & K & ~noT)|(~S[4] & S[2] & ~S[1] & S[0])|(~S[4] & S[3] & S[1] & S[0] & K & ~noT)|(~S[4] & ~S[2] & S[1] & S[0] & C & K & ~noT)|(S[4] & ~S[3] & ~S[2] & ~S[0] & C & K & ~noT);
    assign FS[1]= (~S[4] & S[1] & ~K)|(~S[4] & S[1] & noT)|(~S[4] & S[1] & ~S[0] & C)|(~S[4] & S[2] & S[1] & ~C)|(~S[3] & ~S[2] & S[1] & ~K)|(~S[3] & ~S[2] & S[1] & noT)|(~S[4] & S[3] & S[1] & S[0] & ~C)|(~S[3] & ~S[2] & S[1] & ~S[0] & ~C)|(~S[4] & S[3] & S[2] & S[0] & K & ~noT)|(~S[3] & ~S[2] & ~S[1] & S[0] & K & ~noT)|(S[4] & ~S[3] & ~S[2] & ~S[1] & C & K & ~noT)|(S[4] & ~S[3] & ~S[2] & S[0] & C & K & ~noT);
    assign FS[0]= (~S[4] & S[0] & ~K)|(~S[4] & S[0] & noT)|(~S[4] & S[2] & S[0] & ~C)|(~S[3] & ~S[2] & S[0] & ~K)|(~S[3] & ~S[2] & S[0] & noT)|(~S[4] & S[3] & S[2] & S[1] & S[0])|(~S[4] & ~S[3] & S[2] & ~S[1] & K & ~noT)|(~S[4] & ~S[2] & S[1] & ~S[0] & K & ~noT)|(~S[4] & ~S[3] & ~S[0] & C & K & ~noT)|(S[4] & ~S[3] & ~S[2] & ~S[0] & ~C & K & ~noT)|(~S[4] & S[3] & ~S[2] & ~S[1] & S[0])|(S[4] & ~S[3] & ~S[2] & S[1] & C & K & ~noT)|(~S[4] & S[3] & ~S[2] & ~S[1] & C & K & ~noT);
    FFD5B r11(clk, rst, en, FS, S);

      assign MP[2] = (~S[4] & S[3] & ~S[1] & S[0])|(~S[4] & ~S[3] & S[2] & ~S[1]) ;
      assign MP[1] = (~S[4] & ~S[3] & ~S[2] & S[1])|(~S[4] & S[3] & ~S[1] & ~S[0])|(~S[4] & S[2] & S[1] & S[0])|(~S[4] & S[3] & S[1] & S[0]);
      assign MP[0] = (~S[4] & ~S[3] & ~S[2] & S[0])|(~S[4] & ~S[3] & ~S[1] & S[0])|(~S[4] & S[3] & ~S[1] & ~S[0])|(~S[4] & S[2] & S[1] & ~S[0])|(~S[4] & S[3] & S[1] & ~S[0]);
      assign MD[2] = (S[4] & ~S[3] & S[2] & ~S[1] & ~S[0])|(S[4] & ~S[3] & ~S[2] & S[1] & S[0]);
      assign MD[1] = (S[4] & ~S[3] & ~S[2] & ~S[1] & S[0])|(S[4] &  ~S[3] & ~S[2] & S[1] & ~S[0])|(~S[4] & S[3] & S[1] & S[0])|(~S[4] & S[3] & S[1] & ~S[0])|(~S[4] & S[3] & S[2]);
      assign MD[0] = (S[4] & ~S[3] & ~S[2] & S[1] & ~S[0])|(S[4] & ~S[3] & ~S[1] & ~S[0])|(~S[4] & S[3] & ~S[2] & ~S[1])|(~S[4] & S[2] & S[1] & S[0])|(~S[4] & S[2] & S[1] & ~S[0]);
endmodule


module main_inputs(
  input wire D1, D2, D3, D4, D5, P1, P2, P3, P4, P5, kick_b,
  output wire C, K, noT
  );
  assign C = (D1 & P1)|(D2 & P2)|(D3 & P3)|(D4 & P4)|(D5 & P5);
  assign K =  kick_b;
  //(kick_b & D1)|(kick_b & D2)|(kick_b & D3)|(kick_b & D4)|(kick_b & D4);
  assign noT = ((D1&D2)|(D1&D3)|(D1&D4)|(D1&D5)|(D2&D3)|(D2&D4)|(D2&D5)|(D3&D4)|(D3&D5)|(D4&D5))|((P1&P2)|(P1&P3)|(P1&P4)|(P1&P5)|(P2&P3)|(P2&P4)|(P2&P5)|(P3&P4)|(P3&P5)|(P4&P5));
endmodule 

module delayen(
  input wire clen, clk, rst, en,
  output wire clend
  );
  wire Uclen;
  FFD1B r14(clk, rst, en, clen, Uclen);
  FFD1B r31(clk, rst, en, Uclen, clend);
endmodule 

module emp_contpen(
    input wire BM1, BM2, K, noT, clk, rst, en,
    output wire [2:0] Cont5p,
    output wire FIN5P,
    output wire [2:0] Cont3p,
    output wire FIN3P,
    output wire ENGAME
    );
    wire UM1;
    wire UM2;
    wire UE3P;
    wire UE5P;
    wire ENJ3;
    wire ENJ5;
    wire UENGAME;
    //wire UK;
    //wire UnoT;

    antirebote r4(BM1, clk, rst, en, UM1);
    antirebote r5(BM2, clk, rst, en, UM2);
    //antirebote r9(K, clk, rst, en, UK);
    //antirebote r10(noT, clk, rst, en, UnoT);
    enable_conts r6(UM1, UM2, clk, rst, UE3P, UE5P);
    pen3 r7(K, noT, clk, rst, UE3P, Cont3p, FIN3P, ENJ3);
    pen5 r8(K, noT, clk, rst, UE5P, Cont5p, FIN5P, ENJ5);
    assign UENGAME = (ENJ5&ENJ3&(UE3P|UE5P));
    delayen r15(UENGAME, clk, rst, en, ENGAME);
endmodule

module emp_game(
  input wire KB, D1, D2, D3, D4, D5, P1, P2, P3, P4, P5,
  input wire ENJF, clk, rst, en,
  output wire [2:0]MGK, 
  output wire [2:0]MFWD,
  output wire KK, noTT 
  );
  wire UKB;
  wire UC;
  wire UK;
  wire Unot;
  antirebote r16(KB, clk, rst, en, UKB);
  main_inputs r17(D1, D2, D3, D4, D5, P1, P2, P3, P4, P5, UKB, UC, UK, Unot);
  FSM_game r18(UC, UK, Unot, clk, rst, ENJF, MGK, MFWD);
  assign KK = UK;
  assign noTT = Unot;
endmodule

module emp_final(
  input wire KB, D1, D2, D3, D4, D5, P1, P2, P3, P4, P5,
  input wire clk, rst, en,
  input wire BM1, BM2,
  output wire [2:0] Cont5p,
  output wire FIN5P,
  output wire [2:0] Cont3p,
  output wire FIN3P,
  output wire [2:0]MGK, 
  output wire [2:0]MFWD 
  );
  wire UENJF;
  wire UC;
  wire UK;
  wire Unot;
  emp_contpen r20(BM1, BM2, UK, Unot, clk, rst, en, Cont5p,FIN5P, Cont3p, FIN3P, UENJF);
  emp_game r19(KB, D1, D2, D3, D4, D5, P1, P2, P3, P4, P5, UENJF, clk, rst, en, MGK, MFWD, UK, Unot);

endmodule


