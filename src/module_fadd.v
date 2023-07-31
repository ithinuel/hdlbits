// SPDX-License-Identifier: MIT

module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire carry;
    
    add16 inst0(.a(a[15:0]), .b(b[15:0]), .cin(0), .cout(carry), .sum(sum[15:0]));
    add16 inst1(.a(a[31:16]), .b(b[31:16]), .cin(carry), .cout(), .sum(sum[31:16]));

endmodule

module add1 ( input a, input b, input cin, output sum, output cout );

 	wire half_out = a ^ b;
    wire half_carry = a & b;
    
    assign sum = half_out ^ cin;
    assign cout = half_out & cin | half_carry;

endmodule

