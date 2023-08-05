// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    reg carry;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
            carry <= 1;
        end else begin
            z <= !x ^ carry;
            carry <= !x & carry;
        end
    end
endmodule

