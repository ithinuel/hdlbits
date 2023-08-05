// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    localparam S0=2'd0, S1=2'd1, S2=2'd2;
    reg [1:0] state;
    wire [1:0] next_state;
    
    always @(*) begin
        case (state)
            S0: next_state = x? S1 : S0; // x0 : 0->S0, 1->S1
            S1: next_state = x? S1 : S2; // x1 : 0->S2, 1->S1
            S2: next_state = x? S1 : S0; // 10 : 0->S0, 1->S1
        endcase
    end
    
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= S0;
        end else begin
            state <= next_state;
        end 
    end
    
    assign z = (state == S2) & x; // 10 (s2) & 1 (x)
    
endmodule

