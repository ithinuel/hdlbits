// SPDX-License-Identifier: MIT

module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    add1 inst[99:0] (.a(a), .b(b), .cin({cout[98:0], cin}), .cout(cout[99:0]), .sum(sum));
endmodule

module add1(
    input a, b,
    input cin,
    output cout, sum
);
    wire half_sum = a ^ b;
    wire half_cout = a & b;
    assign sum = half_sum ^ cin;
    assign cout = half_sum & cin | half_cout;
endmodule

