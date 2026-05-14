module bin2bcd (
    input  logic [11:0] bin,

    output logic [3:0] miles,
    output logic [3:0] centenas,
    output logic [3:0] decenas,
    output logic [3:0] unidades
);

    integer i;

    logic [11:0] shift_in;
    logic [3:0] b3, b2, b1, b0;

    always_comb begin

        shift_in = bin;

        b3 = 0;
        b2 = 0;
        b1 = 0;
        b0 = 0;

        for (i = 0; i < 12; i = i + 1) begin

            // ===== ajuste BCD manual =====
            if (b3 >= 5) b3 = b3 + 3;
            if (b2 >= 5) b2 = b2 + 3;
            if (b1 >= 5) b1 = b1 + 3;
            if (b0 >= 5) b0 = b0 + 3;

            // shift global
            {b3, b2, b1, b0, shift_in} =
            {b3, b2, b1, b0, shift_in} << 1;

        end

        miles     = b3;
        centenas  = b2;
        decenas   = b1;
        unidades  = b0;

    end

endmodule