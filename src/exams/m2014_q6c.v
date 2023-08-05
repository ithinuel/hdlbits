// SPDX-License-Identifier: MIT

module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
//    y                      z
//       | w = 0 | w = 1 |  
// A 000    001     000
// B 001    010     011
// C 010    100     011
// D 011    101     000
// E 100    100     011
// F 101    010     011
    assign Y2 = y[1] & !w;
    assign Y4 = w & (y[2] | y[3] | y[5] | y[6]);
endmodule

