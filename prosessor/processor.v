module processor(CLK, RST, rd, alu_ctrl);
    input CLK, RST;

    output[4:0] rd;
    output[3:0] alu_ctrl;

    wire[31:0] inst, pc_inc, iaddr;
    wire[31:0] adder_in1, adder_in2;
    wire[4:0] rs1, rs2;
    wire w_en, op1_sel;
    wire[31:0] imm;
    wire[31:0] alu_output;
    wire[31:0] outdata_a, outdata_b;
    wire[31:0] alu_input_a;

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
        .imm(imm),
        .op1_sel(op1_sel)
    );

    register register(
        .CLK(CLK),
        .WRITE(w_en),
        .inaddr_a(rs1),
        .inaddr_b(rs2),
        .inaddr_w(rd),
        .indata_w(alu_output),
        .outdata_a(outdata_a),
        .outdata_b(outdata_b)
    );

    ALU ALU(
        .input_a(alu_input_a),
        .input_b(outdata_b),
        .ctrl(alu_ctrl),
        .out(alu_output),
        .is_zero()
    );

    selector imm_selector(
        .input_a(outdata_a),
        .input_b(imm),
        .ctrl(op1_sel),
        .out(alu_input_a)
    );

endmodule