module adder32(a, b, s, c);
    input[31:0] a, b;
    
    output[31:0] s;
    output c;

    wire [31:0] g, p, c_in, c_out;

    assign g = a & b;
    assign p = a ^ b;
    assign c_in = {c_out[30:0], 1'b0};
    assign s = p ^ c_in;
    assign c_out = g | (p & c_in);
    assign c = c_out[31];
endmodule
    
