module imem_pc(CLK, RST, inst);
    input CLK, RST;
    output[31:0] inst;

    wire[31:0] pc;

    pc_adder pa(
        .CLK(CLK),
        .RST(RST),
        .Q(pc)
    );

    imem imem(
        .addr(pc),
        .data(inst)
    );

endmodule