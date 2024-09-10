`timescale 1ps/1ps
module tb_branch();
    reg[31:0] pc, rsdata_a, rsdata_b;
    reg[31:0] imm;
    reg[2:0] ctrl;
    reg jump_en;

    wire[31:0] next_pc;

    branch branch(
        .rsdata_a(rsdata_a),
        .rsdata_b(rsdata_b),
        .pc(pc),
        .ctrl(ctrl),
        .next_pc(next_pc),
        .imm(imm),
        .jump_en(jump_en)
    );

    initial begin
        $dumpfile("tb_branch.vcd");
        $dumpvars(0, branch);
        $monitor("pc = %x, imm = %x, a = %x, b = %x, next_pc = %x, ctrl = %b, comp = %b, s = %b", pc, imm, rsdata_a, rsdata_b, next_pc, ctrl, branch.comp_res, branch.signed_en);
    end

    initial begin
        #0  pc = 32'h00000000;
            imm = 32'h00000008;
            ctrl = 3'b000;
            rsdata_a = 32'h00000004;
            rsdata_b = 32'hffffffff;
            jump_en = 0;

        #10 ctrl = 3'b000;
        #10 ctrl = 3'b001;
        #10 ctrl = 3'b100;
        #10 ctrl = 3'b101;
        #10 ctrl = 3'b110;
        #10 ctrl = 3'b111;
        #10 $finish;
    end
endmodule
