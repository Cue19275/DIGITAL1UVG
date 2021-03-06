module testbench();
//Se crean todas las variables necesarias para importar al uP
    reg clock, reset;
    reg [3:0] pushbuttons;
    wire phase, c_flag, z_flag;
    wire [3:0] instr, oprnd, accu, data_bus, FF_out;
    wire [7:0] program_byte;
    wire [11:0] PC, address_RAM;

    integer nota = 0;
    integer immediateDelay = 16;
    integer jumpDelay = 656;
    integer memoryDelay = 276;
//Se importa el modulo del uP
    uP uPmodule(.clock(clock),
                .reset(reset),
                .pushbuttons(pushbuttons),
                .phase(phase),
                .c_flag(c_flag),
                .z_flag(z_flag),
                .instr(instr),
                .oprnd(oprnd),
                .accu(accu),
                .data_bus(data_bus),
                .FF_out(FF_out),
                .program_byte(program_byte),
                .PC(PC),
                .address_RAM(address_RAM));
    //Se establece que el reloj hara un cambio de estado cada 5 unidades de tiempo
    always 
        #5  clock = ~clock;
    initial begin
        //Se crea la estructura de la tabla para leer datos
        #1
        $display("Proyecto uP");
        $display("|clk| |rst|  |PB    |    |PC  |   |prog_byte |  || accu   d_bus  FF_out  C Z");
        $display("-----------------------------------------------------------------------------");
        $monitor("|%b  | |%b  |  |%b  |    |%d|   |%h        |  || %b   %b   %b    %b %b", clock, reset, pushbuttons, PC, program_byte, accu, data_bus, FF_out, c_flag, z_flag);
        //Se hace el reset inicial y se establece que el input externo siempre tendra valor de 1 (decimal)
        clock = 0; reset = 0; pushbuttons = 1;
        #2 reset = 1;
        #1 reset = 0;
    end
    
    //Se termina el monitoreo de las variables despues de 325 unidades de tiempo      
    initial
    #325$finish;
    initial begin
      $dumpfile("uP_tb.vcd");
      $dumpvars(0, testbench);
    end
  endmodule
