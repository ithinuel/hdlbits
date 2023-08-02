// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    localparam WALK_LEFT=1'b0, WALK_RIGHT=1'b1;
    reg state;
    wire next_state;

    always @(*) begin
        // State transition logic
        case ({bump_left, bump_right})
            2'b00: next_state = state;
            2'b10: next_state = WALK_RIGHT;
            2'b01: next_state = WALK_LEFT;
            2'b11: next_state = !state;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if (areset) state <= WALK_LEFT;
        else state <= next_state;
    end

    // Output logic
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);

endmodule

