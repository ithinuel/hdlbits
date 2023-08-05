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
// A 000     0       1     0
// B 001     3       2     0
// C 010     3       4     0
// D 011     0       5     0
// E 100     3       4     1
// F 101     3       2     1
    
    assign z = |y[5:4];
    
    always @(*) begin
        Y[0] = !w & (y[0] | y[3]);
        Y[1] = w & y[0];
        Y[2] = w & (y[1] | y[5]);
        Y[3] = !w & (y[1] | y[2] | y[4] | y[5]);
        Y[4] = w & (y[2] | y[4]);
        Y[5] = w & y[3];
    end
    
    always @(posedge clk) begin
        if (reset) y <= 6'b1;
        else y <= Y;
    end
    
endmodule

