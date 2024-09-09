module ALU(input_a, input_b, ctrl, is_zero, out);
    input[31:0] input_a, input_b;
    input[3:0] ctrl;

    output is_zero;
    output[31:0] out;

    wire[31:0] output_adder;

    adder32 adder(
        .a(input_a),
        .b(input_b),
        .s(output_adder),
        .c()
    );

    assign out = (ctrl == 4'b0000)? output_adder:
                                    32'h00000000;
endmodule