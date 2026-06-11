module B3_almacenar_numeros (
    input  logic clk,
    input  logic rst,

    input  logic tecla_valida,
    input  logic [3:0] tecla,

    input  logic sel_num,
    input  logic load_digit,

    output logic [3:0] d0_1,
    output logic [3:0] d1_1,
    output logic [3:0] d2_1,

    output logic [3:0] d0_2,
    output logic [3:0] d1_2,
    output logic [3:0] d2_2
);

    // =====================================================
    // registro de flanco (EVITA DOBLE ESCRITURA)
    // =====================================================
    logic tecla_valida_d;

    always_ff @(posedge clk) begin
        if (!rst)
            tecla_valida_d <= 1'b0;
        else
            tecla_valida_d <= tecla_valida;
    end

    wire tecla_pulse = tecla_valida && !tecla_valida_d;

    // =====================================================
    // almacenamiento
    // =====================================================
    always_ff @(posedge clk) begin

        if (!rst) begin
            d0_1 <= 0; d1_1 <= 0; d2_1 <= 0;
            d0_2 <= 0; d1_2 <= 0; d2_2 <= 0;
        end

        else if (load_digit && tecla_pulse && ((tecla != 4'hA) && (tecla != 4'hB) && (tecla != 4'hC) && (tecla != 4'hD) && (tecla != 4'hE) && (tecla != 4'hF))) begin

            // =====================
            // NUMERO 1
            // =====================
            if (!sel_num) begin
                d2_1 <= d1_1;
                d1_1 <= d0_1;
                d0_1 <= tecla;
            end

            // =====================
            // NUMERO 2
            // =====================
            else begin
                d2_2 <= d1_2;
                d1_2 <= d0_2;
                d0_2 <= tecla;
            end

        end

        else if (load_digit && tecla_pulse && tecla == 4'hC) begin

            // =====================
            // NUMERO 1
            // =====================
            if (!sel_num) begin
                d2_1 <= 0;
                d1_1 <= d2_1;
                d0_1 <= d1_1;
            end

            // =====================
            // NUMERO 2
            // =====================
            else begin
                d2_2 <= 0;
                d1_2 <= d2_2;
                d0_2 <= d1_2;
            end

        end
    end

endmodule