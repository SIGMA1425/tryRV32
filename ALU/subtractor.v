module subtractor(input_a, input_b, sub);
    input[31:0] input_a, input_b;
    output[31:0] sub;
    wire[31:0] comp;
    wire[31:0] comp2adder;

    adder32 comp_2(
        .a(comp),
        .b(32'h00000001),
        .s(comp2adder),
        .c()
    );

    adder32 adder(
        .a(input_a),
        .b(comp2adder),
        .s(sub),
        .c()
    );

    assign comp = ~input_b;

endmodule