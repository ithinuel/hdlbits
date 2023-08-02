// SPDX-License-Identifier: MIT

module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3;

    // State transition logic: next_state = f(state, in)
    assign next_state = (state == A)? (in?B:A) :
        (state == B)? (in?B:C) :
        (state == C)? (in?D:A) :
        in?B:C;
    // Output logic:  out = f(state) for a Moore state machine
    assign out = state == D;

endmodule

