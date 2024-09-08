module decorder(inst, rs1, rs2, rd, alu_ctrl);
    input[31:0] inst;
    output[4:0] rs1, rs2, rd;
    output[3:0] alu_ctrl;

    parameter R_OPCODE = 7'b0110011;

    assign rs1 = (inst[6:0] == R_OPCODE)? inst[19:15]:  5'bZZZZZ;
    assign rs2 = (inst[6:0] == R_OPCODE)? inst[24:20]: 5'bZZZZZ;
    assign rd  = (inst[6:0] == R_OPCODE)? inst[11:7]:  5'bZZZZZ;
    assign alu_ctrl = (inst[8:0 == R_OPCODE])? {inst[30], inst[14:12]}: 4'bZZZZ;

endmodule