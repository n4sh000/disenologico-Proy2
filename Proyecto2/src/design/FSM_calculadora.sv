module FSM_calculadora (
    input  logic clk,
    input  logic rst,

    input  logic tecla_valida,
    input  logic [3:0] tecla,

    output logic sel_num,
    output logic load_digit,

    output logic start_sum,
    output logic show_result,

    output logic [2:0] state_out
);

typedef enum logic [2:0] {
    IDLE,
    NUM1,
    NUM2,
    COMPUTE,
    SHOW
} state_t;

state_t state, next_state;

// =========================
// estado actual
// =========================
always_ff @(posedge clk) begin
    if (!rst)
        state <= IDLE;
    else
        state <= next_state;
end

// salida del estado para el TOP
assign state_out = state;

// =========================
// lógica combinacional
// =========================
always_comb begin

    // defaults
    sel_num     = 1'b0;
    load_digit  = 1'b0;
    start_sum   = 1'b0;
    show_result = 1'b0;

    next_state = state;

    case (state)

        // =========================
        // IDLE
        // =========================
        IDLE: begin
            next_state = NUM1;
        end

        // =========================
        // NUM1
        // =========================
        NUM1: begin
            load_digit = 1'b1;

            if (tecla_valida && tecla == 4'hA)  // * para separar números
                next_state = NUM2;
        end

        // =========================
        // NUM2
        // =========================
        NUM2: begin
            sel_num    = 1'b1;
            load_digit = 1'b1;

            if (tecla_valida && tecla == 4'hB)  // # para calcular
                next_state = COMPUTE;
        end

        // =========================
        // COMPUTE
        // =========================
        COMPUTE: begin
            start_sum = 1'b1;
            next_state = SHOW;
        end

        // =========================
        // SHOW
        // =========================
        SHOW: begin
            show_result = 1'b1;

            // Volver a IDLE con * o con cualquier nueva tecla numérica
            if (tecla_valida) begin
                if (tecla < 4'hA)  // Tecla numérica: reinicia
                    next_state = state;
            end
        end

    endcase
end

endmodule