module top (
 
    input  logic clk,
    input  logic rst,
 
    // teclado
    input  logic [3:0] rows,
    output logic [2:0] cols,
 
    // display físico
    output logic [3:0] digit,
    output logic [6:0] seg
 
);
 
    // =========================================================
    // 1. SEÑALES INTERNAS
    // =========================================================
 
    logic tecla_valida;
    logic [3:0] tecla;
 
    logic [2:0] state;
 
    // Señales de control del FSM
    logic sel_num;
    logic load_digit;
 
    // B3 números
    logic [3:0] n1_d2, n1_d1, n1_d0;
    logic [3:0] n2_d2, n2_d1, n2_d0;
 
    // B4 resultado binario
    logic [11:0] resultado_bin;
    logic start_sum;
    logic done_sum;
 
    // BCD resultado
    logic [3:0] r3, r2, r1, r0;
 
    // display final
    logic [3:0] d0, d1, d2, d3;
    logic [3:0] hex;
 
    // =========================================================
    // 2. TECLADO + ANTIRREBOTE
    // =========================================================
 
    B1_lector_teclado u_kbd (
        .clk(clk),
        .rows(rows),
        .cols(cols),
        .tecla(tecla),
        .tecla_raw(tecla_valida)
    );
 
    // =========================================================
    // 3. FSM
    // =========================================================
 
    FSM_calculadora u_fsm (
        .clk(clk),
        .rst(rst),
        .tecla_valida(tecla_valida),
        .tecla(tecla),
 
        .sel_num(sel_num),
        .load_digit(load_digit),
 
        .start_sum(start_sum),
 
        .state_out(state)
    );
 
    // =========================================================
    // 4. B3 - almacenamiento números
    // =========================================================
 
    B3_almacenar_numeros u_b3 (
        .clk(clk),
        .rst(rst),
        .tecla_valida(tecla_valida),
        .tecla(tecla),
 
        .sel_num(sel_num),
        .load_digit(load_digit),
 
        .d0_1(n1_d0),
        .d1_1(n1_d1),
        .d2_1(n1_d2),
 
        .d0_2(n2_d0),
        .d1_2(n2_d1),
        .d2_2(n2_d2)
    );
 
    // =========================================================
    // 5. B4 - suma
    // =========================================================
 
    B4_sumador u_b4 (
        .clk(clk),
        .rst(rst),
        .start_sum(start_sum),
 
        .d2_1(n1_d2), .d1_1(n1_d1), .d0_1(n1_d0),
        .d2_2(n2_d2), .d1_2(n2_d1), .d0_2(n2_d0),
 
        .resultado(resultado_bin),
        .done(done_sum)
    );
 
    // =========================================================
    // 6. BIN2BCD
    // =========================================================
 
    bin2bcd u_bcd (
        .bin(resultado_bin),
 
        .miles(r3),
        .centenas(r2),
        .decenas(r1),
        .unidades(r0)
    );
 
    // =========================================================
    // 7. DISPLAY SELECTOR
    // =========================================================
 
    display_selector u_sel (
        .state(state),
 
        .n1_d2(n1_d2), .n1_d1(n1_d1), .n1_d0(n1_d0),
        .n2_d2(n2_d2), .n2_d1(n2_d1), .n2_d0(n2_d0),
 
        .r3(r3), .r2(r2), .r1(r1), .r0(r0),
 
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3)
    );
 
    // =========================================================
    // 8. MULTIPLEXOR DISPLAY
    // =========================================================
 
    disp_mux u_mux (
        .clk(clk),
        .rst(rst),
 
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
 
        .hex_out(hex),
        .digit(digit)
    );
 
    // =========================================================
    // 9. DECODER 7 SEGMENTOS
    // =========================================================
 
    disp_decoder u_dec (
        .hex_in(hex),
        .seg(seg)
    );
 
endmodule