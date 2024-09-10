module branch(rsdata_a, rsdata_b, pc, ctrl, next_pc, imm, jump_en);
    input[31:0] rsdata_a, rsdata_b, pc;
    input[31:0] imm;
    input[2:0]  ctrl;
    output[31:0] next_pc;
    input jump_en;

    wire signed_en;
    wire[1:0] comp_res;
    wire[31:0] jump_offset;

    comp comp(
        .input_a(rsdata_a),
        .input_b(rsdata_b),
        .signed_en(signed_en),
        .res(comp_res)
    );

    adder32 m_adder1(
        .a(pc),
        .b(jump_offset),
        .s(next_pc),
        .c()
    );

    assign signed_en = (ctrl != 3'b110 && ctrl != 3'b111)? 1'b1: 1'b0;
    assign jump_offset = (jump_en == 1'b0)? 32'h00000004:
                         (ctrl == 3'b000 && comp_res[0] == 1'b1)? imm:
                         (ctrl == 3'b001 && comp_res[0] != 1'b1)? imm:
                         (ctrl == 3'b100 && comp_res[1] == 1'b1)? imm:
                         (ctrl == 3'b101 && comp_res[1] != 1'b1)? imm:
                         (ctrl == 3'b110 && comp_res[1] == 1'b1)? imm:
                         (ctrl == 3'b111 && comp_res[1] != 1'b1)? imm:
                                                                32'h00000004;

endmodule
