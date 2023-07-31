// SPDX-License-Identifier: MIT

module top_module( 
    input [31:0] in,
    output [31:0] out );//

    assign out[0 +: 8] = in[24 +: 8];
    assign out[8 +: 8] = in[16 +: 8];
    assign out[16 +: 8] = in[8 +: 8];
    assign out[24 +: 8] = in[0 +: 8];
endmodule

