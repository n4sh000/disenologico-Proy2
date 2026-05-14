`timescale 1ns/1ps

module bin2bcd_tb;

    // DUT inputs
    logic [11:0] bin;

    // DUT outputs
    logic [3:0] miles;
    logic [3:0] centenas;
    logic [3:0] decenas;
    logic [3:0] unidades;

    // =========================
    // Instancia del DUT
    // =========================
    bin2bcd dut (
        .bin(bin),
        .miles(miles),
        .centenas(centenas),
        .decenas(decenas),
        .unidades(unidades)
    );

    // =========================
    // Task de prueba
    // =========================
    task probar(input [11:0] valor);

        begin

            bin = valor;

            #1;

            $display("-----------------------------------");
            $display("BINARIO = %0d", valor);
            $display("BCD     = %0d%0d%0d%0d",
                     miles,
                     centenas,
                     decenas,
                     unidades);

        end

    endtask

    // =========================
    // Estímulos
    // =========================
    initial begin

        $display("INICIO TEST BIN2BCD");

        probar(0);
        probar(1);
        probar(5);
        probar(9);

        probar(10);
        probar(15);
        probar(42);
        probar(99);

        probar(100);
        probar(255);
        probar(512);

        probar(999);
        probar(1023);

        probar(2048);
        probar(4095);

        $display("FIN TEST");

        $finish;

    end

    initial begin
        $dumpfile("bin2bcd_tb.vcd");
        $dumpvars(0, bin2bcd_tb);
    end

endmodule