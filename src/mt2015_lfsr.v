// SPDX-License-Identifier: MIT

module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

    wire L = KEY[1];
    
    always @(posedge KEY[0]) begin
        LEDR <= { L? SW[2] : LEDR[2] ^ LEDR[1], L? SW[1] : LEDR[0], L? SW[0] : LEDR[2] };
    end
endmodule

