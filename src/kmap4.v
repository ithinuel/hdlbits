// SPDX-License-Identifier: MIT

module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

    wire [3:0] abcd = {a, b, c, d};
    always @(*) case (abcd)
        4'b0010, 4'b0001, 4'b0100, 4'b0111, 4'b1110, 4'b1101, 4'b1000, 4'b1011: out = 1'b1;
        default: out = 1'b0;
    endcase
endmodule

