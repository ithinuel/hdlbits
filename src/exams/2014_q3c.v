// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    wire [2:0] Y;
    
    assign z = (y == 3'b011) | (y == 3'b100);
    assign Y0 = Y[0];
    
    always @(*) begin
        case (y)
            3'b000: Y = x? 3'b001 : 3'b000; // 1 : 0
            3'b001: Y = x? 3'b100 : 3'b001; // 4 : 1
            3'b010: Y = x? 3'b001 : 3'b010; // 1 : 2
            3'b011: Y = x? 3'b010 : 3'b001; // 2 : 1
            3'b100: Y = x? 3'b100 : 3'b011; // 4 : 3
            default: Y = 3'b111;
        endcase
    end
    
    always @(posedge clk) ;
    
endmodule

