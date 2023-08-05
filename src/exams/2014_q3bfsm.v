// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    
    reg [2:0] y;
    wire [2:0] Y;
    
    assign z = (y == 3'b011) | (y == 3'b100);
    
    always @(*) begin
        case (y)
            3'b000: Y = x? 3'b001 : 3'b000; // 1 : 0
            3'b001: Y = x? 3'b100 : 3'b001; // 4 : 1
            3'b010: Y = x? 3'b001 : 3'b010; // 1 : 2
            3'b011: Y = x? 3'b010 : 3'b001; // 2 : 1
            3'b100: Y = x? 3'b100 : 3'b011; // 4 : 3
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) y <= 3'b0;
        else y <= Y;
    end

endmodule

