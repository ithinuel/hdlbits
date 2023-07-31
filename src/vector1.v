// SPDX-License-Identifier: MIT

`default_nettype none     // Disable implicit nets. Reduces some types of bugs.
module top_module( 
    input wire [15:0] in,
    output wire [7:0] out_hi,
    output wire [7:0] out_lo );
    assign out_hi = in[8 +: 8];
    assign out_lo = in[0 +: 8];
endmodule

