// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=1'b0, ON=1'b1; 
    reg state;

    always @(posedge clk) begin
        // State flip-flops with synchronous reset
        if (reset) state <= OFF;
        else if (state == OFF && j) state <= ON;
        else if (state == ON && k) state <= OFF;
    end

    // Output logic
    assign out = (state == ON);

endmodule

