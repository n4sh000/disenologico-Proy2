`timescale 1ns / 1ps

module top_tb;

    logic clk;
    logic rst;
    logic [3:0] rows;
    logic [2:0] cols;
    logic [3:0] digit;
    logic [6:0] seg;

    // Inyección directa en el FSM
    logic tecla_inject;
    logic [3:0] tecla_value;

    // Instancia normal
    top dut (
        .clk(clk),
        .rst(rst),
        .rows(rows),
        .cols(cols),
        .digit(digit),
        .seg(seg)
    );

    // Inyectar teclas directamente en B1 (módulo u_kbd)
    // Forzar salidas del teclado
    initial begin
        force dut.u_kbd.tecla_raw = tecla_inject;
        force dut.u_kbd.tecla = tecla_value;
    end

    // Clock 100MHz
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Tarea para inyectar tecla
    task inject_key(input [3:0] key_code, input integer duration_ms);
        begin
            tecla_value = key_code;
            tecla_inject = 1'b1;
            repeat(duration_ms * 100) @(posedge clk);  // 1ms = 100 ciclos de 10ns
            tecla_inject = 1'b0;
            repeat(50) @(posedge clk);  // debounce
        end
    endtask

    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);

        // Reset
        rst = 0;
        tecla_inject = 1'b0;
        rows = 4'b0000;
        repeat(100) @(posedge clk);
        rst = 1;
        repeat(100) @(posedge clk);

        $display("=== INICIO: 123 + 456 = 579 ===");
        
        // Presionar 1
        $display("T=%0tns: Presionando 1", $time);
        inject_key(4'h1, 1);
        
        // Presionar 2
        $display("T=%0tns: Presionando 2", $time);
        inject_key(4'h2, 1);
        
        // Presionar 3
        $display("T=%0tns: Presionando 3", $time);
        inject_key(4'h3, 1);
        
        // Presionar * (0xA)
        $display("T=%0tns: Presionando * (sep)", $time);
        inject_key(4'hA, 1);
        
        // Presionar 4
        $display("T=%0tns: Presionando 4", $time);
        inject_key(4'h4, 1);
        
        // Presionar 5
        $display("T=%0tns: Presionando 5", $time);
        inject_key(4'h5, 1);
        
        // Presionar 6
        $display("T=%0tns: Presionando 6", $time);
        inject_key(4'h6, 1);
        
        // Presionar # (0xB)
        $display("T=%0tns: Presionando # (calc)", $time);
        inject_key(4'hB, 1);
        
        repeat(1000) @(posedge clk);

        $display("=== FIN ===");
        $display("n1 = %d%d%d", dut.n1_d2, dut.n1_d1, dut.n1_d0);
        $display("n2 = %d%d%d", dut.n2_d2, dut.n2_d1, dut.n2_d0);
        $display("resultado_bin = %d (esperado: 579)", dut.resultado_bin);
        $display("r3=%d, r2=%d, r1=%d, r0=%d (BCD)", dut.r3, dut.r2, dut.r1, dut.r0);

        $finish;
    end

endmodule