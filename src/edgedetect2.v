// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] old;
    always @(posedge clk) begin
        old <= in;
        anyedge <= old ^ in;
    end

endmodule

