// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
    
    reg [5:0] y;
    wire [5:0] Y;
//    y                    z
//       | w = 0 | w = 1 |
// A 000    001     000    0
// B 001    010     011    0
// C 010    100     011    0
// D 011    101     000    0
// E 100    100     011    1
// F 101    010     011    1
    assign Y[0] = w & (y[0] | y[3]);
    assign Y[1] = !w & y[0];
    assign Y[2] = !w & (y[1] | y[5]);
    assign Y[3] = w & (y[1] | y[2] | y[4] | y[5]);
    assign Y[4] = !w & (y[2] | y[4]);
    assign Y[5] = !w & y[3];
    
    assign z = |y[5:4];
    
    always @(posedge clk) begin
        if (reset) y <= 6'b1;
        else y <= Y;
    end
    
endmodule

