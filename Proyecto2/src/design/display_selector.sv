module display_selector (
    input  logic [2:0] state,

    input  logic [3:0] n1_d2, n1_d1, n1_d0,
    input  logic [3:0] n2_d2, n2_d1, n2_d0,

    input  logic [3:0] r3, r2, r1, r0, // resultado 4 dígitos

    output logic [3:0] d0,
    output logic [3:0] d1,
    output logic [3:0] d2,
    output logic [3:0] d3
);

    always_comb begin

        case (state)

            // =====================
            // MOSTRAR NUM1
            // =====================
            3'd1: begin
                d0 = n1_d0;
                d1 = n1_d1;
                d2 = n1_d2;
                d3 = 4'd1;
            end

            // =====================
            // MOSTRAR NUM2
            // =====================
            3'd2: begin
                d0 = n2_d0;
                d1 = n2_d1;
                d2 = n2_d2;
                d3 = 4'd2;
            end

            // =====================
            // RESULTADO
            // =====================
            3'd4: begin
                d0 = r0;
                d1 = r1;
                d2 = r2;
                d3 = r3;
            end

            // =====================
            // DEFAULT
            // =====================
            default: begin
                d0 = 0;
                d1 = 0;
                d2 = 0;
                d3 = 0;
            end

        endcase

    end

endmodule