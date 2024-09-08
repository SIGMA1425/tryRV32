`timescale 1ns/1ns

module tb_imem_pc();
    reg CLK, RST;
    wire[31:0] inst;

    parameter RATE = 100;

    imem_pc ip(
        .CLK(CLK),
        .RST(RST),
        .inst(inst)
    );

    always #(RATE / 2) CLK = ~CLK;

    initial begin
        $dumpfile("tb_imem_pc.vcd");
        $dumpvars(0, tb_imem_pc);
        $monitor("CLK = %d, RST = %d, inst = %x", CLK, RST, inst);
    end

    initial begin
        #0 CLK = 0;
           RST = 0;
        
        #10 RST = 1;
        #10 RST = 0;
        #(RATE * 6) $finish;
    end

endmodule