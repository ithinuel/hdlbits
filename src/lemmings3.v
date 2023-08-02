// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging );

    localparam WALK_LEFT=2'b0, WALK_RIGHT=2'b1, FALL=2'd2, DIG=2'd3;
    reg [1:0] prev_state;
    reg [1:0] state;
    wire [1:0] next_state;

    always @(*) begin
        // State transition logic
        if (!ground) next_state = FALL;
        else if (aaah && ground) next_state = prev_state;
        else if (ground && dig) next_state = DIG;
        else if (digging && ground) next_state = DIG;
        else casez ({bump_left, bump_right})
            2'b00: next_state = state;
            2'b10: next_state = WALK_RIGHT;
            2'b01: next_state = WALK_LEFT;
            2'b11: next_state = (state==WALK_LEFT)?WALK_RIGHT:WALK_LEFT;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if (areset) state <= WALK_LEFT;
        else if (state != next_state) begin
            if (state != DIG) begin
            	prev_state <= state;
            end
            state <= next_state;
        end
    end

    // Output logic
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL);
    assign digging = (state == DIG);

endmodule

