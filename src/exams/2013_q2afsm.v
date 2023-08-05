// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    reg [3:0] s;
    wire [3:0] S;
    
    assign S[0] = (!(|r) & s[0]) | (!r[1] & s[1]) | (!r[2] & s[2]) | (!r[3] & s[3]);
    assign S[1] = r[1] & (s[0] | s[1]);
    assign S[2] = r[2] & ((!r[1] & s[0]) | s[2]);
    assign S[3] = r[3] & ((!(|r[2:1]) & s[0]) | s[3]);
    
    assign g = s[3:1];
    
    always @(posedge clk) begin
        if (!resetn) s <= 4'b1;
        else s <= S;
    end
endmodule

