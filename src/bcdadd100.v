// SPDX-License-Identifier: MIT

module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    wire [99:0] carries;
    bcd_fadd insts[99:0](.a(a), .b(b), .cin({carries[98:0], cin}), .cout(carries), .sum(sum));
    
    assign cout = carries[99];
endmodule

