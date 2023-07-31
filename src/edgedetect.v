// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] old = 0;
    always @(posedge clk) begin
    	old <= in;
        pedge <= ~old & in;
    end

endmodule

