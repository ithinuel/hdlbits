// SPDX-License-Identifier: MIT

module top_module( 
    input [254:0] in,
    output [7:0] out );
    
    always @(*) begin
        out = 0;
        for (int i = 0; i < 255; i = i + 1) begin
            out = out + { 7'd0, in[i]};
        end
    end

endmodule

