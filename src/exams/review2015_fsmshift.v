// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    localparam MAX = 3'd4;
    
    reg [2:0] count;
    
    assign shift_ena = count < MAX;
    
    always @(posedge clk) begin
        if (reset) count <= 1'b0;
        else if (count < MAX) count <= count + 3'd1;
    end
    
endmodule

