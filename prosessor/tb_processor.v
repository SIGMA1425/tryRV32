`timescale 1ns/1ns

module tb_processor();
    reg CLK, RST;
    wire[4:0] rs1, rs2, rd;
    wire[3:0] alu_ctrl;
    wire[31:0] outdata_a, outdata_b;

    parameter RATE = 100;

    processor processor(
        .CLK(CLK),
        .RST(RST),
        .rd(rd),
        .alu_ctrl(alu_ctrl),
        .outdata_a(outdata_a),
        .outdata_b(outdata_b)
    );

    always #(RATE / 2) CLK = ~CLK;

    initial begin
        $dumpfile("tb_processor.vcd");
        $dumpvars(0, processor);
        $monitor("CLK = %d, RST = %d, inst = %x\n\trd = %b, alu_ctrl = %b\n\trs1 = %b, rs2 = %b, outdata_a = %x, outdata_b = %x", 
                    CLK, RST, processor.inst, rd, alu_ctrl, processor.decorder.rs1, processor.decorder.rs2, outdata_a, outdata_b);
    end

    initial begin
        #0 CLK = 0;
           RST = 0;
        
        #10 RST = 1;
        #10 RST = 0;
        #(RATE * 6) $finish;
    end
endmodule