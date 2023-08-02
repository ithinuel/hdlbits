// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    localparam A = 2'd0, B=2'd1, C=2'd2, D=2'd3;
    reg [1:0] state;
    always @(posedge clk or posedge areset) begin
        if (areset) state <= A;
        else case (state)
            A: if (in) state <= B;
            B: if (!in) state <= C;
            C: state <= in? D : A;
            D: state <= in? B : C;
        endcase
           
    end
    
    assign out = state == D;

endmodule

