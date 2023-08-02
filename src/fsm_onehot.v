// SPDX-License-Identifier: MIT

module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    wire [9:0] s = state;
    
    assign next_state[0] = !in & (|s[4:0] | |s[9:7]);
    assign next_state[1] = in & (s[0] | |s[9:8]);
    assign next_state[2] = in & s[1];
    assign next_state[3] = in & s[2];
    assign next_state[4] = in & s[3];
    assign next_state[5] = in & s[4];
    assign next_state[6] = in & s[5];
    assign next_state[7] = in & |s[7:6];
    assign next_state[8] = !in & s[5];
    assign next_state[9] = !in & s[6];
    
    assign out2 = s[7] | s[9];
    assign out1 = s[8] | s[9];
    
endmodule

