`timescale 1ns/1ps

module bin2bcd_tb;

    // =========================
    // señales
    // =========================

    logic [11:0] bin;

    logic [3:0] miles;
    logic [3:0] centenas;
    logic [3:0] decenas;
    logic [3:0] unidades;

    // =========================
    // DUT
    // =========================

    bin2bcd dut (
        .bin(bin),

        .miles(miles),
        .centenas(centenas),
        .decenas(decenas),
        .unidades(unidades)
    );

    // =========================
    // VCD
    // =========================

    initial begin
        $dumpfile("bin2bcd_tb.vcd");
        $dumpvars(0, bin2bcd_tb);
    end

    // =========================
    // estímulos
    // =========================

    initial begin

        // ---------------------
        // prueba principal
        // ---------------------
        bin = 12'd10;

        #10;

        $display("BIN       = %0d", bin);
        $display("MILES     = %0d", miles);
        $display("CENTENAS  = %0d", centenas);
        $display("DECENAS   = %0d", decenas);
        $display("UNIDADES  = %0d", unidades);

        // esperado:
        // decenas  = 1
        // unidades = 0

        // ---------------------
        // más pruebas útiles
        // ---------------------

        bin = 12'd9;
        #10;

        bin = 12'd99;
        #10;

        bin = 12'd123;
        #10;

        bin = 12'd999;
        #10;

        $finish;

    end

endmodule