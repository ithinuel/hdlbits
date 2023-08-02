// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
    
    localparam WAIT=2'd0, B0=2'd1, B1=2'd2, B2=2'd3;
    reg [1:0] state;
    wire [1:0] next_state;
    
    reg [23:0] data;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state)
            WAIT: next_state = in[3]? B0 : WAIT;
            B0, B1: next_state = state + 2'b1;
            B2: next_state = in[3]? B0 : WAIT;
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT;
        end else begin
            state <= next_state;
            data <= {data[15:0], in};
        end
    end
 
    // Output logic
    assign done = state == B2;
    assign out_bytes = (state == B2)? data : 24'b0;

endmodule


