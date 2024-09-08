module processor(CLK, RST, rs1, rs2, rd, alu_ctrl);
    input CLK, RST;
    output[4:0] rs1, rs2, rd;
    output[3:0] alu_ctrl;

    wire[31:0] inst, pc_inc, iaddr;
    wire[31:0] adder_in1, adder_in2;

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
        .alu_ctrl(alu_ctrl)
    );

endmodule