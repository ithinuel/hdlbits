// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
);
    //               +---+       +-+
    //               v  !x       v x
    // A -> B/f=1 -> C/f=0 - x -> D - !x -> E - x -> F/g=1 - y -> G/g=1 -> y -> I/g=1
    //               ^                     !x         |           ^ !y
    //               +----------------------+         |           y  v
    //                                                 \--- !y -> H/g=1 -> !y -> J/g=0
    reg [9:0] s;
    wire [9:1] S;

    assign S[1] = s[0];
    assign S[2] = s[1] | (!x & (s[2] | s[4]));
    assign S[3] = x & (s[2] | s[3]);
    assign S[4] = s[3] & !x;
    assign S[5] = s[4] & x;
    assign S[6] = y & (s[5] | s[7]);
    assign S[7] = !y & (s[5] | s[6]);
    assign S[8] = (s[6] & y) | s[8];
    assign S[9] = (s[7] & !y) | s[9];

    assign f = s[1];
    assign g = |s[8:5];

    always @(posedge clk) begin
        if (!resetn) s <= 10'b1;
        else s <= {S, 1'b0};
    end

endmodule

