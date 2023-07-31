module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    wire [11:0] counter;
    bcdcount counter0 (clk, reset, c_enable[0], counter[0 +: 4]);
    bcdcount counter1 (clk, reset, c_enable[1], counter[4 +: 4]);
    bcdcount counter2 (clk, reset, c_enable[2], counter[8 +: 4]);
	
    assign c_enable = { counter[0 +: 8] == 8'h99, counter[0 +: 4] == 4'h9, 1'b1 };
    assign OneHertz = counter == 12'h999;
endmodule

