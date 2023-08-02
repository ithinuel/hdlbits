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
    
    localparam SURVIVE_HEIGHT = 5'd20;
    localparam WALK_LEFT=3'b0, WALK_RIGHT=3'b1, FALL=3'd2, DIG=3'd3, SPLAT=3'd4;
    
    reg [2:0] prev_state;
    reg [2:0] state;
    wire [2:0] next_prev_state;
    wire [2:0] next_state;

    reg [4:0] fall_survival;
    wire [4:0] next_fall_survival;
    always @(*) begin
        // State transition logic
        next_fall_survival = (!aaah)? SURVIVE_HEIGHT : (fall_survival==0)? 4'd0 : (fall_survival - 4'd1);
        next_prev_state = ((state == next_state) || digging)? prev_state : state;
        
        if (state == SPLAT) next_state = SPLAT;
        else if (!ground && !aaah) next_state = FALL;
        else if (aaah && ground) next_state = (fall_survival==0)? SPLAT : prev_state;
        else if (ground && (dig || digging)) begin
            next_state = DIG;
        end else casez ({bump_left, bump_right})
            2'b00: next_state = state;
            2'b10: next_state = WALK_RIGHT;
            2'b01: next_state = WALK_LEFT;
            2'b11: next_state = (state==WALK_LEFT)?WALK_RIGHT:WALK_LEFT;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            prev_state <= next_prev_state;
            state <= next_state;
            fall_survival <= next_fall_survival;
        end
    end

    // Output logic
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL);
    assign digging = (state == DIG);

endmodule

