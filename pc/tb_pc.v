`timescale 1ns/1ns

module tb_pc();
    reg CLK, RST;
    reg[31:0] D;

    wire[31:0] Q;

    parameter RATE = 100;

    pc pc(
        .CLK(CLK),
        .RST(RST),
        .D(D),
        .Q(Q)
    );

    always #(RATE/2) CLK = ~CLK;

    initial begin
        $dumpfile("tb_pc.vcd");
        $dumpvars(0, pc);
        $monitor($stime, " CLK = %d, RST = %d, D = %x, Q = %x", CLK, RST, D, pc.Q);
    end

    initial begin
        #0      CLK = 0;
                RST = 0;
                D   = 32'h00000000;

        #(RATE) D = 32'h00000004;
        #(RATE) D = 32'h00000008;
        #(RATE) D = 32'h0000000C;
        #(RATE) D = 32'h00000400;
        #(RATE) D = 32'h00000200;
                RST = 1;
        #10     D = 32'h00000004;
                RST = 0;
        #(RATE - 10) D = 32'h00000008;
        #(RATE) $finish;
    end
    
endmodule
