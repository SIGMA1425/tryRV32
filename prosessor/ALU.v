module ALU(input_a, input_b, ctrl, is_zero, out);
    input[31:0] input_a, input_b;
    input[3:0] ctrl;

    output is_zero;
    output[31:0] out;

    wire[31:0] output_adder, output_sub, output_and, output_or, output_xor;
    wire[31:0] output_slt, output_sltu;
    wire[31:0] output_sll, output_srl, output_sra;

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
    assign output_slt = ($signed(input_a) < $signed(input_b))? 32'h00000001:32'h0000000;
    assign output_sltu = (input_a < input_b)? 32'h00000001: 32'h00000000;
    assign output_sll = input_a << input_b;
    assign output_srl = input_a >> input_b;
    assign output_sra = $signed(input_a) >>> input_b;


    assign out = (ctrl == 4'b0000)? output_adder:
                 (ctrl == 4'b0001)? output_sll:
                 (ctrl == 4'b0010)? output_slt:
                 (ctrl == 4'b0011)? output_sltu:
                 (ctrl == 4'b0100)? output_xor:
                 (ctrl == 4'b0101)? output_srl:
                 (ctrl == 4'b0110)? output_or:
                 (ctrl == 4'b0111)? output_and:
                 (ctrl == 4'b1000)? output_sub:
                 (ctrl == 4'b1101)? output_sra:
                                    32'h00000000;
endmodule
