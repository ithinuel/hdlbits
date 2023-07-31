// SPDX-License-Identifier: MIT

module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//

    wire [7:0] minab = (a<b)? a : b;
    wire [7:0] mincd = (c<d)? c : d;
    
    assign min = (minab<mincd)? minab : mincd;

endmodule

