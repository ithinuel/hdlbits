// SPDX-License-Identifier: MIT

module top_module( 
    input a, 
    input b, 
    output out );
    assign out = ~(a | b);
endmodule

