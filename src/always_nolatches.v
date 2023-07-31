// SPDX-License-Identifier: MIT

// synthesis verilog_input_version verilog_2001
module top_module (
    input [15:0] scancode,
    output left,
    output down,
    output right,
    output up  ); 
    reg [3:0] concat;
    always @(*) case (scancode)
        16'he06b: concat = 4'b1000;
        16'he072: concat = 4'b0100;
        16'he074: concat = 4'b0010;
        16'he075: concat = 4'b0001;
        default: concat = 0;
    endcase
    assign {left, down, right, up} = concat;
endmodule

