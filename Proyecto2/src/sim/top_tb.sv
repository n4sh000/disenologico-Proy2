`timescale 1ns / 1ps

module top_tb;

    // ======================================================
    // CLOCK / RESET
    // ======================================================
    logic clk;
    logic rst;

    // Teclado
    logic [3:0] rows;
    wire  [2:0] cols;

    // Display
    logic [3:0] digit;
    logic [6:0] seg;

    // DUT
    top u_dut (
        .clk(clk),
        .rst(rst),
        .rows(rows),
        .cols(cols),
        .digit(digit),
        .seg(seg)
    );

    // ======================================================
    // CLOCK 10 MHz
    // ======================================================
    always #5 clk = ~clk;

    // ======================================================
    // VCD (WAVEFORMS)
    // ======================================================
    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);
    end

    // ======================================================
    // RESET
    // ======================================================
    initial begin
        clk = 0;
        rst = 0;
        rows = 4'b1111;

        repeat(10) @(posedge clk);
        rst = 1;
        repeat(10) @(posedge clk);
        rst = 0;
    end

    // ======================================================
    // TASK: simular tecla REALISTA
    // ======================================================
    task automatic press_key(input int key);
    begin
        // Espera a sincronización del scanner
        repeat(200) @(posedge clk);

        // Simulación simple: solo activa fila (modelo ideal)
        case (key)
            1: rows = 4'b1110;
            2: rows = 4'b1110;
            3: rows = 4'b1110;

            4: rows = 4'b1101;
            5: rows = 4'b1101;
            6: rows = 4'b1101;

            7: rows = 4'b1011;
            8: rows = 4'b1011;
            9: rows = 4'b1011;

            default: rows = 4'b1111;
        endcase

        // Mantener presión
        repeat(20) @(posedge clk);

        // Soltar tecla
        rows = 4'b1111;

        // Debounce + procesamiento FSM
        repeat(200) @(posedge clk);
    end
    endtask

    // ======================================================
    // ESTÍMULOS PRINCIPALES
    // ======================================================
    initial begin

        // Esperar reset completo
        repeat(50) @(posedge clk);

        // ==========================
        // CASO 1: 9 + 1
        // ==========================
        press_key(9);
        press_key(1);

        repeat(2000) @(posedge clk);

        // ==========================
        // CASO 2: 8 + 7
        // ==========================
        press_key(8);
        press_key(7);

        repeat(2000) @(posedge clk);

        // ==========================
        // CASO 3: 5 + 5
        // ==========================
        press_key(5);
        press_key(5);

        repeat(2000) @(posedge clk);

        $display("SIMULACION FINALIZADA");
        $finish;
    end

    // ======================================================
    // MONITOR SIMPLE
    // ======================================================
    initial begin
        forever begin
            @(posedge clk);
            if (rows != 4'b1111)
                $display("[%0t] TECLA ACTIVA rows=%b cols=%b digit=%b seg=%b",
                         $time, rows, cols, digit, seg);
        end
    end

endmodule