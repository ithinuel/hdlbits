// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    wire [7:0] hh_i;
    wire last_ss = ss == 8'h59;
    wire last_mm = mm == 8'h59;
    wire last_hh = hh_i == 8'h11;
    wire reset_s = reset | last_ss;
    wire reset_m = reset | (reset_s && last_mm);
    wire reset_h = reset | (reset_m && last_hh);
    
    wire [1:0] en_ss = { ss[3:0] == 4'h9 & ena, ena };
    wire [1:0] en_mm = { mm[3:0] == 4'h9 & last_ss, last_ss };
    wire [1:0] en_hh = { hh_i[3:0] == 4'h9 & last_mm & last_ss, last_mm & last_ss}; 
   
    assign hh = (hh_i == 0)? 8'h12 : hh_i;
    
    always @(posedge clk) begin
        if (reset) begin
            pm <= 0;
        end else if (last_hh & last_mm && last_ss)
            pm <= !pm;
    end
    
    count_digit seconds[1:0] (clk, reset_s, en_ss, 8'h0, ss);
    count_digit minutes[1:0] (clk, reset_m, en_mm, 8'h0, mm);
    count_digit hours[1:0] (clk, reset_h, en_hh, 8'h0, hh_i); 
endmodule

module count_digit (
    input clk,
    input reset,        // Synchronous active-high reset
    input enable,
    input [3:0] load,
    output [3:0] q);
    always @(posedge clk) begin
        if (reset) q <= load;
    	else if (enable) begin
        	if (q == 4'd9) q <= 0;
        	else q <= q + 4'd1;
    	end
    end
endmodule
