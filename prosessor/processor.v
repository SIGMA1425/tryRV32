module processor(CLK, RST, rd, alu_ctrl, outdata_a, outdata_b);
    input CLK, RST;

    output[4:0] rd;
    output[3:0] alu_ctrl;
    output[31:0] outdata_a, outdata_b;

    wire[31:0] inst, pc_inc, iaddr;
    wire[31:0] adder_in1, adder_in2;
    wire[4:0] rs1, rs2;
    wire w_en;
    wire[31:0] imm;

    pc pc(
        .CLK(CLK),
        .RST(RST),
        .D(pc_inc),
        .Q(iaddr)
    );

    adder32 adder(
        .a(iaddr),
        .b(32'h00000004),
        .s(pc_inc),
        .c()
    );

    imem imem(
        .addr(iaddr),
        .data(inst)
    );

    decorder decorder(
        .inst(inst),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .alu_ctrl(alu_ctrl),
        .w_en(w_en),
        .imm(imm)
    );

    register register(
        .CLK(CLK),
        .WRITE(w_en),
        .inaddr_a(rs1),
        .inaddr_b(rs2),
        .inaddr_w(rd),
        .indata_w(imm),
        .outdata_a(outdata_a),
        .outdata_b(outdata_b)
    );

endmodule