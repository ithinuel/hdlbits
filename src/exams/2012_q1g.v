module top_module (
    input [4:1] x,
    output f
); 
	wire a,b,c,d;
    assign {d,c,b,a} = x;
    assign f = (!a & c) | (!b&!d) | &x;
endmodule

