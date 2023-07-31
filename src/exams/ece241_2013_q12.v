module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 

    reg [7:0] Q;
    wire [2:0] addr = {A,B,C};
    assign Z = Q[addr];
    
    always @(posedge clk) begin
        if (enable) begin
            Q <= {Q[6:0], S};        
        end
    end
endmodule

