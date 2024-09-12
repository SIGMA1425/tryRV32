module judge(rs1data, rs2data, ctrl, result);
    input[31:0] rs1data, rs2data;
    input[2:0] ctrl;
    output result;
    wire signed_en;
    wire[1:0] comp_res;

    comp comp(
        .input_a(rs1data),
        .input_b(rs2data),
        .signed_en(signed_en),
        .res(comp_res)
    );

    assign signed_en = (ctrl != 3'b110 && ctrl != 3'b111)? 1'b1: 1'b0;

    assign result = (ctrl == 3'b000 && comp_res[0] == 1'b1)? 1'b1:
                    (ctrl == 3'b001 && comp_res[0] != 1'b1)? 1'b1:
                    (ctrl == 3'b100 && comp_res[1] == 1'b1)? 1'b1:
                    (ctrl == 3'b101 && comp_res[1] != 1'b1)? 1'b1:
                    (ctrl == 3'b110 && comp_res[1] == 1'b1)? 1'b1:
                    (ctrl == 3'b111 && comp_res[1] != 1'b1)? 1'b1:
                                                            1'b0;
endmodule
