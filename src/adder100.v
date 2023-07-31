// SPDX-License-Identifier: MIT

module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );

    wire [98:0] carries;
    adder insts[99:0] (.a(a), .b(b), .cin({carries[98:0], cin}), .cout({cout, carries}), .sum(sum));
    
endmodule

module adder(input a, b, cin, output sum, cout);
    wire half_sum = a ^ b;
	wire half_cout = a & b;
    assign sum = half_sum ^ cin;
    assign cout = half_sum & cin | half_cout;
endmodule
