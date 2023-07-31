// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input d,
    output q
);
	wire q_pos, q_neg;
    always @(posedge clk) q_pos <= d;
    always @(negedge clk) q_neg <= d;
    assign q = (q_pos & clk) | (q_neg & !clk);
endmodule

