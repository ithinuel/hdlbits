// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
    localparam WAIT=4'd0, START=4'd1, STOP=4'd9, DONE=4'd10, ERR=4'd11;
    
    reg [3:0] state;
    wire [3:0] next_state;
    
    reg [8:0] data;
    
    always @(*) begin
        if (state == WAIT) next_state = in? WAIT : START;
        else if (state < STOP) next_state = state + 4'd1;
        else if (state == STOP) next_state = in? DONE : ERR;
        else if (state == DONE) next_state = in? WAIT : START;
        else if (state == ERR) next_state = in? WAIT : ERR;
        else next_state = WAIT;
    end
    
    always @(posedge clk) begin
        if (reset) state <= WAIT;
        else begin
            state <= next_state;
            data <= {in, data[8:1]};
        end
    end
    
    assign done = state == DONE;
    assign out_byte = data[7:0];
endmodule


