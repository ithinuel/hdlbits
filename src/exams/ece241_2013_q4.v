// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    reg [1:0] previous_level;
    wire [1:0] level;
    
    assign level = (!s[1])? 2'd0 : (!s[2])? 2'd1: (!s[3])? 2'd2 : 2'd3;
    
    always @(posedge clk) begin
        
        if (reset) begin
            {fr1, fr2, fr3, dfr} <= 4'b1111;
        	previous_level <= 2'b0;
        end else begin
        	previous_level <= level;
            
            if (previous_level < level)
                dfr <= 1'b0;
            else if (previous_level > level)
                dfr <= 1'b1;
            
            fr1 <= !s[3];
            fr2 <= !s[2];
            fr3 <= !s;
        end
    end
endmodule

