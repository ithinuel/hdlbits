// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    localparam line = 16;
    
    wire [256*4 - 1: 0] neighbours;
    
    genvar y, x;
    generate
        for (y = 0; y < 16; y++) begin: outer
            for (x = 0; x < 16; x++) begin: inner
                localparam lt = ((y==15)?0:(y+1))*16 + ((x==15)?0:(x+1));
                localparam l = y*16 + ((x==15)?0:(x+1));
                localparam lb = ((y==0)?15:(y-1))*16 + ((x==15)?0:(x+1));
                
                localparam t = ((y==15)?0:(y+1))*16 + x;
                localparam c = y*16 + x;
                localparam b = ((y==0)?15:(y-1))*16 + x;
                
                localparam rt = ((y==15)?0:(y+1))*16 + ((x==0)?15:(x-1));
                localparam r = y*16 + ((x==0)?15:(x-1));
                localparam rb = ((y==0)?15:(y-1))*16 + ((x==0)?15:(x-1));
                assign neighbours[c*4 +: 4] =
                    q[lt] + q[t] + q[rt] +
                    q[l ]        + q[r ] +
                    q[lb] + q[b] + q[rb];
            end
        end
    endgenerate

    always @(posedge clk) begin
        if (load) q <= data;
        else begin
            for (int i = 0; i < 16; i++) begin
                for (int j = 0; j < 16; j++) begin
                    case (neighbours[(i*16+j)*4 +: 4])
                        4'd3: q[i*16+j] <= 1'b1;
                        4'd2: q[i*16+j] <= q[i*16+j];
                        default: q[i*16+j] <= 1'b0;
                    endcase
                end
            end
        end
    end
    
endmodule

