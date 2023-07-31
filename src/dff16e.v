// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
    always @(posedge clk) begin
        if (!resetn) q <= 0;
        else begin
            if (byteena[0]) q[0 +: 8] <= d[0 +: 8];
            if (byteena[1]) q[8 +: 8] <= d[8 +: 8];
        end
    end

endmodule

