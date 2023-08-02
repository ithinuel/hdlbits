// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=1'b0, ON=1'b1; 
    reg state, next_state;

    always @(*) begin
        if (state == OFF && j) next_state = ON;
        else if (state == ON && k) next_state = OFF;
        else next_state = state;
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) state <= OFF;
        else state <= next_state;
    end

    // Output logic
    assign out = (state == ON);

endmodule

