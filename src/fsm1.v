// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=1'b0, B=1'b1; 
    reg state = B, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case (state)
            A: if (in) next_state = A;
            else next_state = B;
            B: if (in) next_state = B;
            else next_state = A;
        endcase
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        if (areset) state <= B;
        else state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule

