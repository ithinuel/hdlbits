// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    reg enabled;
    wire next_enabled = s | enabled;

`ifdef 0
    reg [2:0] history;
    reg [1:0] counter;
    
    always @(posedge clk) begin
        if (reset) begin
            enabled <=  1'b0;
            history <= 3'b0;
            counter <= 2'd3;
        end else begin
            enabled <= next_enabled;
            history <= { w, history[2:1] };
            if (enabled) begin
                counter <= (counter < 2'd2)? counter + 2'd1 : 2'd0;
            end
        end
    end
    
    assign z = ((history == 3'b011) | (history == 3'b101) | (history == 3'b110)) & (counter == 2'd2);
`else
    reg [2:0] state;
    wire [2:0] next_state;
    reg [2:0] history;
    
    always @(*) begin
        case (state)
            3'b001: next_state = 3'b010;
            3'b010: next_state = 3'b100;
            default: next_state = 3'b001;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            enabled <=  1'b0;
            state <= 3'b100;
            history <= 3'b000;
        end else begin
            enabled <= next_enabled;
            if (enabled) begin
            	state <= next_state;
            	history <= { w, history[2:1] };
            end
        end
    end
    
    assign z = ((history == 3'b011) | (history == 3'b101) | (history == 3'b110)) & state[2];
`endif
endmodule

