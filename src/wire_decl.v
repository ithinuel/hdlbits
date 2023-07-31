// SPDX-License-Identifier: MIT

`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    wire intermediate = (a & b) | (c & d);
    assign out = intermediate;
    assign out_n = ~intermediate;
endmodule

