// SPDX-License-Identifier: MIT

module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    wire [5:0] Y;
//   y                   z
//     | w = 0 | w = 1 |
// A 0     0       1     0
// B 1     3       2     0
// C 2     3       4     0
// D 3     0       5     0
// E 4     3       4     1
// F 5     3       2     1
    
    assign Y1 = w & y[0];
    assign Y3 = !w & (y[1] | y[2] | y[4] | y[5]);
    
endmodule

