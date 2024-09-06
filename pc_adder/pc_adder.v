module pc_adder(CLK, RST, Q);
    input CLK, RST;
    output[31:0] Q;

    wire[31:0] D, in_Q;
    wire[31:0] a, b;

    pc pc(
        .CLK(CLK),
        .RST(RST),
        .D(D),
        .Q(in_Q)
    );

    adder32 adder(
        .a(in_Q),
        .b(b),
        .s(D),
        .c()
    );

    assign b = 32'h00000004;
    assign Q = in_Q;

endmodule