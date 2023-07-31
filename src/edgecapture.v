// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] old;
    always @(posedge clk) begin
        old <= in;
        if (reset) out <= 0;
        else out <= out | (old & ~in);
    end
endmodule

