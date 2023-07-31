// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    localparam line = 16;
    
    wire [256*4 - 1: 0] neighbours;
    
    genvar a, b, c;
    generate
        for (a = 0; a < 16; a++) begin: outer
            for (b = 0; b < 16; b++) begin: inner
                localparam idx = a * 16 + b;
                if ((a == 0) && (b == 0)) begin
                    // bottom right
                    assign neighbours[idx*4 +: 4] =
                        q[17]  + q[16]  + q[31] +
                        q[1]   +          q[15] +
                        q[241] + q[240] + q[255];
                end else if ((a == 0) && (b == 15)) begin
                    // bottom left
                    assign neighbours[idx*4 +: 4] =
                        q[16]  + q[31]  + q[30] +
                        q[0]   +          q[14] +
                        q[240] + q[255] + q[254];
                end else if ((a == 15) && (b == 0)) begin
                    // top right
                    assign neighbours[idx*4 +: 4] =
                        q[1]   + q[0]    + q[15] +
                        q[241] +           q[255] +
                        q[225] + q[224]  + q[239];
                end else if ((a == 15) && (b == 15)) begin
                    // top left
                    assign neighbours[idx*4 +: 4] =
                        q[0]   + q[15]   + q[14] +
                        q[240] +           q[254] +
                        q[224] + q[239]  + q[238];
                end else if (a == 0) begin
                    // bottom
                    assign neighbours[idx*4 +: 4] =
                        q[idx + line  + 1] + q[idx + line]  + q[idx + line  - 1] +
                        q[idx + 1]         +                  q[idx         - 1] +
                        q[15*line + b + 1] + q[15*line + b] + q[15*line + b - 1];
                end else if (a == 15) begin
                    // top
                    assign neighbours[idx*4 +: 4] =
                        q[b + 1]          + q[b]          + q[b - 1]          +
                        q[idx + 1]        +                 q[idx        - 1] +
                        q[idx - line + 1] + q[idx - line] + q[idx - line - 1];
                end else if (b == 0) begin
                    // right
                    assign neighbours[idx*4 +: 4] =
                        q[idx + line + 1] + q[idx + line] + q[(a+1)*line + line - 1] +
                        q[idx + 1]        +                 q[a*line     + line - 1] +
                        q[idx - line + 1] + q[idx - line] + q[(a-1)*line + line - 1];
                end else if (b == 15) begin
                    // left
                    assign neighbours[idx*4 +: 4] =
                        q[(a+1)*line] + q[idx + line] + q[idx + line - 1] +
                        q[a*line]     +                 q[idx        - 1] +
                        q[(a-1)*line] + q[idx - line] + q[idx - line - 1];
                end else begin 
                    assign neighbours[idx*4 +: 4] =
                        q[idx + line + 1] + q[idx + line] + q[idx + line - 1] +
                        q[idx + 1]        +                 q[idx        - 1] +
                        q[idx - line + 1] + q[idx - line] + q[idx - line - 1];
                end
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

