// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
    localparam PARITY=4'd8, WAIT=4'd12, STOP=4'd13, DONE=4'd14, ERR=4'd15;
    
    reg [3:0] state;
    wire [3:0] next_state;
    
    reg [7:0] data;
    wire odd;
    parity inst(clk, reset | (state >= PARITY), in, odd);
    
    always @(*) begin
        if (state == WAIT) next_state = in? WAIT : 4'b0;
        else if (state < PARITY) next_state = state + 4'd1;
        else if (state == PARITY) next_state = (odd == !in)? STOP : ERR;
        else if (state == STOP) next_state = in? DONE : ERR;
        else if (state == DONE) next_state = in? WAIT : 4'b0;
        else if (state == ERR) next_state = in? WAIT : ERR;
        else next_state = WAIT;
    end
    
    always @(posedge clk) begin
        if (reset) state <= WAIT;
        else begin
            state <= next_state;
            if (state < PARITY) begin
                data <= {in, data[7:1]};
            end
        end
    end
    
    assign done = state == DONE;
    assign out_byte = data[7:0];
endmodule

