// SPDX-License-Identifier: MIT

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    // v------------------------------------------------------------------------------- ack -+
    // A - start_shift -> B/shift_ena=1 - shift_ena_i -> C/shift_ena=0 - done_counting -> D/done=1
    
    wire start_shifting;
    wire shift_ena_i;
    
    reg [3:0] s;
    wire [3:0] S;
   
    assign S[0] = (s[0] & !start_shifting) | (s[3] & ack);
    assign S[1] = (s[0] & start_shifting) | (s[1] & shift_ena_i);
    assign S[2] = (s[1] & !shift_ena_i) | (s[2] & !done_counting);
    assign S[3] = (s[2] & done_counting) | (s[3] & !ack);
    
    assign shift_ena = s[1];
    assign counting = s[2];
    assign done = s[3];
    
    always @(posedge clk) begin
        if (reset) s <= 4'b1;
        else begin
            s <= S;
        end
    end
    
    seqdet seq(clk, reset | !s[0], data, start_shifting);
    // use a delay of 3 instead of 4 as the State machine inherently introduces a 1 tick delay.
    delay #(.MAX(3'd3)) delay(clk, reset | s[0], shift_ena_i);

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

module delay #(
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

