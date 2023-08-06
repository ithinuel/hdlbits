// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    //  +---------------------------+
    //  v                          !x
    //  A - x -> B - x -> C - !x -> D - x -> E
    // ^!x      !x       ^ x
    // +-+-------+       +-+
    
    reg [4:0] s;
    wire [4:0] S;
    wire x = data;
    
    assign S[0] = !x & (s[0] | s[1] | s[3]);
    assign S[1] = x & s[0];
    assign S[2] = x & (s[1] | s[2]);
    assign S[3] = !x & s[2];
    assign S[4] = s[4] | (x & s[3]);
    
    assign start_shifting = s[4];
    
    always @(posedge clk) begin
        if (reset) s <= 5'd1;
        else s <= S;
    end
    
endmodule

