// SPDX-License-Identifier: MIT

module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    
    wire [7:0] q1, q2, q3;
    
    my_dff8 inst0(clk, d, q1);
    my_dff8 inst1(clk, q1, q2);
    my_dff8 inst2(clk, q2, q3);
    
    assign q = (sel == 0)? d :
        (sel == 1)? q1 :
        (sel == 2)? q2 : q3;

endmodule

