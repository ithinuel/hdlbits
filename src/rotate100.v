// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 
    always @(posedge clk) begin
        casez ({ena, load})
            3'bzz1: q <= data;
            3'b010: q <= {q[0], q[99:1]};
            3'b100: q <= {q[98:0], q[99]};
        endcase
    end

endmodule

