module selector(input_a, input_b, ctrl, out);
    input[31:0] input_a, input_b;
    input ctrl;
    output[31:0] out;

    assign out = (ctrl == 1'b0)? input_a: input_b;
endmodule