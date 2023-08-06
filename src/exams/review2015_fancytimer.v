// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    // v------------------------------------------------------------------------------- ack -+
    // A - start_shift -> B/shift_ena=1 - shift_ena_i -> C/shift_ena=0 - done_counting -> D/done=1
    
    wire start_shifting, shift_ena_i, done_counting;
    
    reg [3:0] s;
    wire [3:0] S;
    wire [3:0] delay;
    wire [9:0] q;
    
    assign done_counting = s[2] && (q == 10'd999) && (delay == 4'd0);
    
    assign S[0] = (s[0] & !start_shifting) | (s[3] & ack);
    assign S[1] = (s[0] & start_shifting) | (s[1] & shift_ena_i);
    assign S[2] = (s[1] & !shift_ena_i) | (s[2] & !done_counting);
    assign S[3] = (s[2] & done_counting) | (s[3] & !ack);
    
    assign counting = s[2];
    assign done = s[3];
    assign count = delay;
    
    always @(posedge clk) begin
        if (reset) s <= 4'b1;
        else begin
            s <= S;
        end
    end
    
    seqdet seq(clk, reset | !s[0], data, start_shifting);
    // use a delay of 3 instead of 4 as the State machine inherently introduces a 1 tick delay.
    delay_n #(.MAX(3'd3)) shift_dur(clk, reset | s[0], shift_ena_i);
    shiftcount shift_count(clk, s[1], s[2] && (q == 10'd999), data, delay);
    count1k counter(clk, reset | !s[2], q);
    
endmodule

module seqdet (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    //  +---------------------------+
    //  v                          !x
    //  A - x -> B - x -> C - !x -> D - x -> E
    // ^!x      !x       ^ x
    // +-+-------+       +-+
    
    reg [4:0] s;
    wire [4:0] S;
    wire x = data;
    
    assign S[0] = !x & (s[0] | s[1] | s[3]);
    assign S[1] = x & s[0];
    assign S[2] = x & (s[1] | s[2]);
    assign S[3] = !x & s[2];
    assign S[4] = s[4] | (x & s[3]);
    
    assign start_shifting = S[4];
    
    always @(posedge clk) begin
        if (reset) s <= 5'd1;
        else s <= S;
    end
    
endmodule

module delay_n #(
    parameter CNT_WIDTH = 3,
    parameter MAX = 3'd4
) (
    input clk,
    input reset,      // Synchronous reset
    output o);
        
    reg [CNT_WIDTH - 1:0] count;
    
    assign o = count < MAX;
    
    always @(posedge clk) begin
        if (reset) count <= 1'b0;
        else if (count < MAX) count <= count + 1'd1;
    end
    
endmodule

module shiftcount (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
    
    reg [3:0] shift_reg;
    
    assign q = shift_reg;
    
    always @(posedge clk) begin
        if (shift_ena) shift_reg <= { shift_reg[2:0], data };
        else if (count_ena) shift_reg <= shift_reg - 4'd1;
    end

endmodule

module count1k (
    input clk,
    input reset,
    output [9:0] q);
    
    always @(posedge clk) begin
        if (reset) q <= 10'd0;
        else q <= (q==10'd999)? 10'd0 : (q + 10'd1);
    end

endmodule


