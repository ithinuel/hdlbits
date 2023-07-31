// SPDX-License-Identifier: MIT

module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    wire na, nb, nc, nd;
    assign {na, nb, nc, nd} = ~{a, b, c, d};
    assign out = (nb & nc) | (na & nd) | (b & c & d) | (a & nb & d);
endmodule

