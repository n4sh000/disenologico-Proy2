`timescale 1ns/1ps

module B2_antreb_tb;

    // =====================================
    // SEÑALES
    // =====================================
    logic clk;
    logic btn;

    logic cs_antreb;

    // =====================================
    // DUT
    // =====================================
    B2_antreb #(
        .NUM_CYCLES(7)
    ) dut (
        .clk(clk),
        .btn(btn),
        .cs_antreb(cs_antreb)
    );

    // =====================================
    // CLOCK
    // =====================================
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // =====================================
    // VCD
    // =====================================
    initial begin
        $dumpfile("B2_antreb_tb.vcd");
        $dumpvars(0, B2_antreb_tb);
    end

    // =====================================
    // ESTÍMULOS
    // =====================================
    initial begin

        // estado inicial
        btn = 0;

        #40;

        // =================================
        // REBOTE DE SUBIDA
        // =================================
        btn = 1; #10;
        btn = 0; #10;
        btn = 1; #10;
        btn = 0; #10;
        btn = 1;

        // mantener estable
        #100;

        // =================================
        // REBOTE DE BAJADA
        // =================================
        btn = 0; #10;
        btn = 1; #10;
        btn = 0; #10;
        btn = 1; #10;
        btn = 0;

        // mantener estable
        #100;

        $finish;

    end

endmodule