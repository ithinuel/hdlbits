module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
 
    // assign s = ...
    // assign overflow = ...

    wire [7:0] carry;
    add1 inst[7:0](.a(a), .b(b), .cin({carry[6:0], 1'b0}), .sum(s), .cout(carry));
    assign overflow = (a[7] & b[7] & !s[7]) | (!a[7] & !b[7] & s[7]);
    
endmodule

module add1(input a, b, cin, output sum, cout);
    wire half_sum = a ^ b;
    wire half_cout = a & b;
    assign sum = half_sum ^ cin;
    assign cout = half_sum & cin | half_cout;
endmodule

