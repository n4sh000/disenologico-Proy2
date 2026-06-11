module B1_lector_teclado #(
    parameter int MAX_COUNT = 100000
)(
    input  logic       clk,
    input  logic [3:0] rows,

    output logic [3:0] cols,
    output logic [3:0] tecla,
    output logic       tecla_raw
);

    // ================================
    // Registros internos
    // ================================
    logic [24:0] contador = '0;
    logic [1:0]  estado   = '0;

    // ================================
    // SCAN DE COLUMNAS
    // ================================
    always_ff @(posedge clk) begin

        // congelar scanner mientras haya tecla
        if (!tecla_raw) begin

            contador <= contador + 1'b1;

            if (contador >= MAX_COUNT) begin

                contador <= '0;

                if (estado == 3)
                    estado <= 0;
                else
                    estado <= estado + 1'b1;

            end

        end
        else begin

            contador <= '0;

        end

    end

    // ================================
    // LECTURA DEL TECLADO
    // ================================
    always_comb begin

        cols      = 4'b0000;
        tecla     = 4'h0;
        tecla_raw = 1'b0;

        case (estado)

            // =========================
            // COLUMNA 1
            // =========================
            0: begin

                cols = 4'b0001;

                if (rows[0]) begin
                    tecla     = 4'h1;
                    tecla_raw = 1'b1;
                end
                else if (rows[1]) begin
                    tecla     = 4'h4;
                    tecla_raw = 1'b1;
                end
                else if (rows[2]) begin
                    tecla     = 4'h7;
                    tecla_raw = 1'b1;
                end
                else if (rows[3]) begin
                    tecla     = 4'hA;
                    tecla_raw = 1'b1;
                end

            end

            // =========================
            // COLUMNA 2
            // =========================
            1: begin

                cols = 4'b0010;

                if (rows[0]) begin
                    tecla     = 4'h2;
                    tecla_raw = 1'b1;
                end
                else if (rows[1]) begin
                    tecla     = 4'h5;
                    tecla_raw = 1'b1;
                end
                else if (rows[2]) begin
                    tecla     = 4'h8;
                    tecla_raw = 1'b1;
                end
                else if (rows[3]) begin
                    tecla     = 4'h0;
                    tecla_raw = 1'b1;
                end

            end

            // =========================
            // COLUMNA 3
            // =========================
            2: begin

                cols = 4'b0100;

                if (rows[0]) begin
                    tecla     = 4'h3;
                    tecla_raw = 1'b1;
                end
                else if (rows[1]) begin
                    tecla     = 4'h6;
                    tecla_raw = 1'b1;
                end
                else if (rows[2]) begin
                    tecla     = 4'h9;
                    tecla_raw = 1'b1;
                end
                else if (rows[3]) begin
                    tecla     = 4'hB;
                    tecla_raw = 1'b1;
                end

            end

            // =========================
            // COLUMNA 4
            // =========================
            3: begin

                cols = 4'b1000;

                if (rows[0]) begin
                    tecla     = 4'hC;   // A
                    tecla_raw = 1'b1;
                end
                else if (rows[1]) begin
                    tecla     = 4'hD;   // B
                    tecla_raw = 1'b1;
                end
                else if (rows[2]) begin
                    tecla     = 4'hE;   // C
                    tecla_raw = 1'b1;
                end
                else if (rows[3]) begin
                    tecla     = 4'hF;   // D
                    tecla_raw = 1'b1;
                end

            end

            default: begin
                cols      = 4'b0000;
                tecla     = 4'h0;
                tecla_raw = 1'b0;
            end

        endcase

    end

endmodule