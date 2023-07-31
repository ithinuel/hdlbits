// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    wire [3:0] enables;
    assign enables = { q[0 +: 12] == 12'h999, q[0 +: 8] == 8'h99, q[0 +: 4] == 4'h9, 1'b1};
    assign ena = enables[3:1];
    count_digit counter[3:0] ({4{clk}}, {4{reset}}, enables, q);
endmodule

module count_digit (
    input clk,
    input reset,        // Synchronous active-high reset
    input enable,
    output [3:0] q);
    always @(posedge clk) begin
        if (reset) q <= 0;
    	else if (enable) begin
        	if (q == 4'd9) q <= 0;
        	else q <= q + 4'd1;
    	end
    end
endmodule
