module  disp_decoder(
    input   logic  [3:0]  hex_in,
    output  logic  [6:0]  seg    
); 

    always_comb  
       begin  
            case(hex_in) 
                      //7' abcdefg
            4'h0: seg = 7'b1111110;
            4'h1: seg = 7'b0110000;
            4'h2: seg = 7'b1101101;
            4'h3: seg = 7'b1111001;
            4'h4: seg = 7'b0110011;
            4'h5: seg = 7'b1011011;
            4'h6: seg = 7'b1011111;
            4'h7: seg = 7'b1110000;
            4'h8: seg = 7'b1111111;
            4'h9: seg = 7'b1111011;
            default: seg = 7'b0000000;
            endcase
       end 

endmodule



