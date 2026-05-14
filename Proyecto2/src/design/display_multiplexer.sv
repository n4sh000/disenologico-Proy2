module disp_mux (
    input logic clk, rst,
    input logic [3:0] d0, d1, d2, d3,
    output logic [3:0] hex_out,
    output logic [3:0] digit
);

logic [15:0] sel;
logic [1:0] sel_idx;

// contador
always_ff @(posedge clk) begin
    if (!rst)
        sel <= 16'd0;
    else
        sel <= sel + 1;
end

assign sel_idx = sel[14:13];

// multiplexor
always_comb begin

    case (sel_idx)

        2'b00: begin
            digit   = 4'b0001;
            hex_out = d0;
        end

        2'b01: begin
            digit   = 4'b0010;
            hex_out = d1;
        end

        2'b10: begin
            digit   = 4'b0100;
            hex_out = d2;
        end

        2'b11: begin
            digit   = 4'b1000;
            hex_out = d3;
        end

        default: begin
            digit   = 4'b0001;
            hex_out = d0;
        end

    endcase

end

endmodule