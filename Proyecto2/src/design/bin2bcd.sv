module bin2bcd (
    input  logic [11:0] bin,
    
    output logic [3:0] miles,
    output logic [3:0] centenas,
    output logic [3:0] decenas,
    output logic [3:0] unidades
);

    reg [15:0] bcd;
    integer i;

    always @(*) begin
        bcd = 0;
        
        // Double Dabble Algorithm - CORRECTO
        // Shift left 12 veces (uno por cada bit de entrada)
        // Después de cada shift, ajustar cualquier dígito BCD >= 5
        
        for (i = 0; i < 12; i = i + 1) begin
            // Ajustar ANTES de shiftar (orden correcto)
            if (bcd[3:0] >= 5) 
                bcd[3:0] = bcd[3:0] + 3;
            if (bcd[7:4] >= 5) 
                bcd[7:4] = bcd[7:4] + 3;
            if (bcd[11:8] >= 5) 
                bcd[11:8] = bcd[11:8] + 3;
            if (bcd[15:12] >= 5) 
                bcd[15:12] = bcd[15:12] + 3;
            
            // Shift izquierdo: desplazar BCD y traer un bit del input
            // bin[11-i] es el bit que entra desde la derecha
            bcd = {bcd[14:0], bin[11-i]};
        end
    end

    // Extraer los dígitos BCD finales
    assign unidades = bcd[3:0];
    assign decenas = bcd[7:4];
    assign centenas = bcd[11:8];
    assign miles = bcd[15:12];

endmodule