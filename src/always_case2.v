// SPDX-License-Identifier: MIT

// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    always @(*) case (in)
        4'h8: pos = 3;
        4'h4, 4'hC: pos = 2;
        4'h2, 4'h6, 4'hA, 4'hE: pos = 1;
        default: pos = 0;

    endcase
endmodule

