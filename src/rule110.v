// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q[511] <= |q[511:510];
            for (int i = 0; i < 510; i = i + 1) begin
                case (q[i +: 3])
                    3'b111, 3'b100, 3'b000: q[i+1] <= 1'b0;
                    default: q[i+1] <= 1'b1;
                endcase
            end
        end
    end

endmodule

