module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    reg [3:0] delay;
    assign out = delay[0];
    always @(posedge clk) begin
        if (!resetn) delay <= 0;
        else delay = { in, delay[3:1] };
    end

endmodule

