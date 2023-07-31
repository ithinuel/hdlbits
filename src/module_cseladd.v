// SPDX-License-Identifier: MIT

module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    
    wire [15:0] assume_0, assume_1, lower;
    wire carry;

    add16 inst_low(.a(a[15:0]), .b(b[15:0]), .cin(0), .cout(carry), .sum(lower));
    add16 inst_zero(.a(a[31:16]), .b(b[31:16]), .cin(0), .cout(), .sum(assume_0));
    add16 inst_one (.a(a[31:16]), .b(b[31:16]), .cin(1), .cout(), .sum(assume_1));
    
    assign sum = { (carry?assume_1:assume_0), lower };
endmodule

