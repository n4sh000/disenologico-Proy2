module B4_sumador (
    input  logic clk,
    input  logic rst,

    input  logic start_sum,

    input  logic [3:0] d2_1,
    input  logic [3:0] d1_1,
    input  logic [3:0] d0_1,

    input  logic [3:0] d2_2,
    input  logic [3:0] d1_2,
    input  logic [3:0] d0_2,

    output logic [11:0] resultado,
    output logic done
);

    // =========================
    // Conversión BCD a entero
    // =========================
    logic [10:0] num1;
    logic [10:0] num2;

    always_comb begin
        num1 = (d2_1 * 100) + (d1_1 * 10) + d0_1;
        num2 = (d2_2 * 100) + (d1_2 * 10) + d0_2;
    end

    // =========================
    // Suma y salida
    // =========================
    always_ff @(posedge clk) begin

        if (!rst) begin
            resultado <= 0;
            done      <= 0;
        end

        else if (start_sum) begin
            resultado <= num1 + num2;
            done      <= 1;
        end

        else begin
            done <= 0;
        end

    end

endmodule