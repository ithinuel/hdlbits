// SPDX-License-Identifier: MIT

//    y                      z
//       | w = 0 | w = 1 |  
// A 000    001     000
// B 001    010     011
// C 010    100     011
// D 011    101     000
// E 100    100     011
// F 101    010     011

module top_module (
    input [3:1] y,
    input w,
    output Y2);

    wire [3:1] next_y;
    
    assign Y2 = next_y[2];
    
    always @(*) begin
        case (y)
            3'b000: next_y = w? 3'b000 : 3'b001;
            3'b001: next_y = w? 3'b011 : 3'b010;
            3'b010: next_y = w? 3'b011 : 3'b100;
            3'b011: next_y = w? 3'b000 : 3'b101;
            3'b100: next_y = w? 3'b011 : 3'b100;
            3'b101: next_y = w? 3'b010 : 3'b011;
            default: next_y = 3'b000;
        endcase
    end
endmodule

