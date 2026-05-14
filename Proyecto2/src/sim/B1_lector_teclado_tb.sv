`timescale 1ns/1ps

module B1_lector_teclado_tb;

    // ==========================
    // Señales
    // ==========================
    logic clk;
    logic [3:0] rows;

    logic [2:0] cols;
    logic [3:0] tecla;
    logic       tecla_raw;

    // ==========================
    // DUT
    // ==========================
    B1_lector_teclado #(
        .MAX_COUNT(5)
    ) dut (
        .clk(clk),
        .rows(rows),
        .cols(cols),
        .tecla(tecla),
        .tecla_raw(tecla_raw)
    );

    // ==========================
    // CLOCK
    // ==========================
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ==========================
    // VCD
    // ==========================
    initial begin
        $dumpfile("B1_lector_teclado_tb.vcd");
        $dumpvars(0, B1_lector_teclado_tb);
    end

    // ==========================
    // ESTÍMULOS
    // ==========================
    initial begin

        rows = 4'b0000;

        // esperar scans
        #100;

        // tecla "1"
        rows = 4'b0001;
        #100;

        // soltar
        rows = 4'b0000;
        #100;

        // tecla "5"
        rows = 4'b0010;
        #100;

        // tecla "9"
        rows = 4'b0100;
        #100;

        // tecla "B"
        rows = 4'b1000;
        #100;

        $finish;

    end

endmodule