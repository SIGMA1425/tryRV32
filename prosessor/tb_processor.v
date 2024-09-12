`timescale 1ns/1ns

module tb_processor();
    reg CLK, RST;
    wire[4:0] rs1, rs2, rd;
    wire[3:0] alu_ctrl;

    parameter RATE = 100;
    integer i, file;

    processor processor(
        .CLK(CLK),
        .RST(RST),
        .rd(rd),
        .alu_ctrl(alu_ctrl)
    );

    always #(RATE / 2) CLK = ~CLK;

    initial begin
        $dumpfile("tb_processor.vcd");
        $dumpvars(0, processor);
        $monitor("CLK = %d, RST = %d, pc = %x, inst = %x\n\trd = %b, alu_ctrl = %b\n\trs1 = %b, rs2 = %b\n\talu_out = %x, reg_wdata = %x\n\tmw_en = %b, dmem_wdata = %x, w_en = %b, imm = %x",
                    CLK, RST, processor.iaddr, processor.inst, rd, alu_ctrl, processor.decorder.rs1, processor.decorder.rs2, processor.ALU.out, processor.reg_wdata, processor.mw_en, processor.outdata_b, processor.w_en, processor.imm);
    end

    initial begin
        #0 CLK = 0;
           RST = 0;

        #10 RST = 1;
        #10 RST = 0;
        #(RATE * 10)
        file = $fopen("register.result", "w");
        for(i = 0; i < 32; i++)begin
            $fwrite(file, "%x\n", processor.register.reg_data[i]);
        end
        $fclose(file);
        file = $fopen("memory.result", "w");
        for(i = 0; i < 4096; i++) begin
            $fwrite(file, "%x\n", processor.dmem.data[i]);
        end
        $finish;
    end
endmodule
