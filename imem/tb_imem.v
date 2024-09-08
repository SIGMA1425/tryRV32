`timescale 1ns/1ns
module tb_imem();
    reg[31:0] addr;
    wire[31:0] data;

    imem imem(
        .addr(addr),
        .data(data)
    );

    initial begin
        $dumpfile("tb_imem.vcd");
        $dumpvars(0, imem);
        $monitor("addr: %x, data: %x", addr, data);
    end

    initial begin
        #0 addr = 32'h00000000;
        #10 addr = 32'h00000004;
        #20 addr = 32'h00000008;
        #30 addr = 32'h0000000C;
    end
endmodule