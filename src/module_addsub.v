// SPDX-License-Identifier: MIT

module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire carry;
    wire [31:0] intermediate_b = b ^ {32{sub}};
    add16 inst_low(.a(a[0+:16]), .b(intermediate_b[0+:16]), .cin(sub), .cout(carry), .sum(sum[0+:16]));
    add16 inst_high(.a(a[16+:16]), .b(intermediate_b[16+:16]), .cin(carry), .cout(), .sum(sum[16+:16]));

endmodule

