module comp(input_a, input_b, signed_en, res);
    input[31:0] input_a, input_b;
    input signed_en;
    wire[1:0] signed_res, unsigned_res;
    output[1:0] res;

    assign unsigned_res = (input_a == input_b)? 2'b01:
                         (input_a < input_b)? 2'b10:
                                              2'b00;

    assign signed_res = ($signed(input_a) == $signed(input_b))? 2'b01:
                        ($signed(input_a) < $signed(input_b))? 2'b10:
                                                               2'b00;

    assign res = (signed_en == 1'b1)? signed_res: unsigned_res;

endmodule
