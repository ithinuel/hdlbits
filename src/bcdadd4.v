// SPDX-License-Identifier: MIT

module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    wire [2:0] carries;
    bcd_fadd inst[3:0] (.a(a), .b(b), .cin({carries, cin}), .cout({cout, carries}), .sum(sum));
    
endmodule

