`timescale 1ns/1ns
module tb_pc_adder();
    reg CLK, RST;
    wire[31:0] Q;

    parameter RATE = 100;

    pc_adder pa(
        .CLK(CLK),
        .RST(RST),
        .Q(Q)
    );

    always #(RATE / 2) CLK = ~CLK;

    initial begin
        $dumpfile("tb_pc_adder.vcd");
        $dumpvars(0, tb_pc_adder);
        $monitor("CLK = %d, RST = %d, Q = %x", CLK, RST, Q);
    end

    initial begin
        #0  CLK = 0;
            RST = 0;
        #10 RST = 1;
        #(RATE + 10)    RST = 0;
        #(RATE * 100) $finish;
    end
endmodule
