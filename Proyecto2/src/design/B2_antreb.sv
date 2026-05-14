module B2_antreb #(
    parameter NUM_CYCLES = 13
)
(
    input logic clk,
    input logic btn,
    output logic cs_antreb
);

logic ff_a;
logic ff_b;
logic ff_c;

logic cs_stbl;
logic fg_count;

logic [$clog2(NUM_CYCLES)-1:0] ff_count;

assign cs_stbl = ~(ff_a ^ ff_b);

always_ff @( posedge clk ) begin
    ff_a <= btn;
    ff_b <= ff_a;
end



always_ff @(posedge clk) begin

    if (cs_stbl) begin

        if (!fg_count)
            ff_count <= ff_count + 1'b1;

    end
    else begin

        ff_count <= '0;

    end

end

assign fg_count = (ff_count == NUM_CYCLES-1)? 1: 0;

always_ff @( posedge clk ) begin
    if (fg_count) begin
        ff_c <= ff_b;
    end
end

assign cs_antreb = ff_c;

endmodule