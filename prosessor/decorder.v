module decorder(inst, rs1, rs2, rd, alu_ctrl, w_en, imm, op1_sel, branch_ctrl, jump_offset, jump_en);
    input[31:0] inst;
    output[4:0] rs1, rs2, rd;
    output[3:0] alu_ctrl;
    output[2:0] branch_ctrl;
    output w_en, op1_sel, jump_en;
    output[31:0] imm;
    output[31:0] jump_offset;

    parameter R_OPCODE     = 7'b0110011;
    parameter I_ALU_OPCODE = 7'b0010011;
    parameter B_OPCODE     = 7'b1100011;
    parameter D_OPCODE     = 7'b0001011;


    assign rs1 = (inst[6:0] == R_OPCODE)?     inst[19:15]:
                 (inst[6:0] == I_ALU_OPCODE)? inst[19:15]:
                 (inst[6:0] == B_OPCODE)?     inst[19:15]:
                 (inst[6:0] == D_OPCODE)?     inst[19:15]:
                                              5'bZZZZZ;

    assign rs2 = (inst[6:0] == R_OPCODE)? inst[24:20]:
                 (inst[6:0] == B_OPCODE)? inst[24:20]:
                                          5'b00000;


    assign rd  = (inst[6:0] == R_OPCODE)?       inst[11:7]:
                 (inst[6:0] == I_ALU_OPCODE)?   inst[11:7]:
                                                5'b00000;

    assign imm = (inst[6:0] == R_OPCODE)?       32'h00000000:
                 (inst[6:0] == I_ALU_OPCODE)?   {{20{inst[31]}}, inst[31:20]}:
                                                32'h00000000;

    assign alu_ctrl = (inst[6:0] == R_OPCODE)?      {inst[30], inst[14:12]}:
                      (inst[6:0] == I_ALU_OPCODE)?  {1'b0, inst[14:12]}:
                                                    4'b0000;

    assign w_en = (inst[6:0] == R_OPCODE || inst[6:0] == I_ALU_OPCODE)? 1'b1: 1'b0;

    assign op1_sel = (inst[6:0] == I_ALU_OPCODE)? 1'b1: 1'b0;

    assign branch_ctrl = (inst[6:0] == B_OPCODE)? inst[14:12]: 3'b000;
    assign jump_offset = (inst[6:0] == B_OPCODE)? {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0}:
                                                    32'h00000000;

    assign jump_en = (inst[6:0] == B_OPCODE)? 1'b1: 1'b0;

endmodule
