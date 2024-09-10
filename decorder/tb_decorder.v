`timescale 1ps/1ps
module tb_decorder();
    reg[31:0] inst;
    wire[4:0] rs1, rs2, rd;
    wire[3:0] alu_ctrl;
    wire[2:0] branch_ctrl;
    wire w_en, op1_sel;
    wire[31:0] imm;
    wire[31:0] jump_offset;
    wire jump_en;

    reg[31:0] memory[0:256];

    decorder decorder(
        .inst(inst),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .alu_ctrl(alu_ctrl),
        .w_en(w_en),
        .imm(imm),
        .op1_sel(op1_sel),
        .branch_ctrl(branch_ctrl),
        .jump_offset(jump_offset),
        .jump_en(jump_en)
    );

    initial begin
        $readmemh("memory.txt", memory);
    end

    initial begin
        $dumpfile("tb_decorder.vcd");
        $dumpvars(0, decorder);
        $monitor($stime, " inst = %b\n, rs1 = %b, rs2 = %b, rd = %b, alu_ctrl = %b, w_en = %d, imm = %x, op1_sel = %d\n\tbranch_ctrl = %b, jump_imm = %x, jump_en = %d",
                    inst, rs1, rs2, rd, alu_ctrl, w_en, imm, op1_sel, branch_ctrl, jump_offset, jump_en);
    end

    initial begin
        #0  inst = memory[0];
        #1  inst = memory[1];
        #1  inst = memory[2];
        #1  inst = memory[3];
        #1  inst = memory[4];
        #1  inst = memory[5];
        #1  inst = memory[6];
        #1  inst = memory[7];
    end
endmodule
