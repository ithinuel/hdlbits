module top_module (
    input clk,
    input x,
    output z
); 
    reg a = 0, b = 0, c = 0;
    always @(posedge clk) begin
        a <= a ^ x;
        b <= x & !b;
        c <= x | !c;
    end
    assign z = !(a | b | c);
endmodule

