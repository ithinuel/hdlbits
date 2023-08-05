// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    localparam A=2'b01;
    localparam B=2'b10;
    reg [1:0] state;
    wire [1:0] next_state;
   
    always @(*) begin
        case (state)
            A: next_state = x? B : A;
            default: next_state = B;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if (areset) state = 2'b01;
        else state <= next_state;
    end
    
    assign z = (state[0] & x) | (state[1] & !x);
endmodule

