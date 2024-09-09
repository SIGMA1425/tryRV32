`timescale 1ps/1ps
module tb_decorder();
    reg[31:0] inst;
    wire[4:0] rs1, rs2, rd;
    wire[3:0] alu_ctrl;
    wire w_en, op1_sel;
    wire[31:0] imm;

    reg[31:0] memory[0:256];

    decorder decorder(
        .inst(inst),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .alu_ctrl(alu_ctrl),
        .w_en(w_en),
        .imm(imm),
        .op1_sel(op1_sel)
    );

    initial begin
        $readmemh("memory.txt", memory);
    end

    initial begin
        $dumpfile("tb_decorder.vcd");
        $dumpvars(0, decorder);
        $monitor($stime, " inst = %b\n, rs1 = %b, rs2 = %b, rd = %b, alu_ctrl = %b, w_en = %d, imm = %x, op1_sel = %d", 
                    inst, rs1, rs2, rd, alu_ctrl, w_en, imm, op1_sel);
    end

    initial begin
        #0  inst = memory[0];
        #1  inst = memory[1];
        #1  inst = memory[2];
    end
endmodule