// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] counter; // 0-4 counting, 5 disc, 6 flag, 7 saturating, err
    
    always @(posedge clk) begin
        if (reset) counter <= 0;
        else begin
            if (!in) counter <= 0;
            if (in && counter != 7) counter <= counter + 3'd1;
            
            disc <= (counter == 5) & !in;
            flag <= (counter == 6) & !in;
        end
    end
    
	assign err = counter == 7;
    
endmodule

