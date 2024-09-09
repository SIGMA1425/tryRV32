module ALU(input_a, input_b, ctrl, is_zero, out);
    input[31:0] input_a, input_b;
    input[3:0] ctrl;

    output is_zero;
    output[31:0] out;

    wire[31:0] output_adder, output_sub, output_and, output_or, output_xor;

    adder32 adder(
        .a(input_a),
        .b(input_b),
        .s(output_adder),
        .c()
    );

    subtractor subtractor(
        .input_a(input_a),
        .input_b(input_b),
        .sub(output_sub)
    );

    assign output_and = input_a & input_b;
    assign output_or  = input_a | input_b;
    assign output_xor = input_a ^ input_b;

    assign out = (ctrl == 4'b0000)? output_adder:
                 (ctrl == 4'b1000)? output_sub:
                 (ctrl == 4'b0100)? output_xor:
                 (ctrl == 4'b0110)? output_or:
                 (ctrl == 4'b0111)? output_and:
                                    32'h00000000;
endmodule