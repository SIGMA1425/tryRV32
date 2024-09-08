`timescale 1ps/1ps

module tb_register();
    reg[31:0] indata_w;
    reg[4:0] inaddr_a, inaddr_b, inaddr_w;
    reg CLK, WRITE;

    wire[31:0] outdata_a, outdata_b;

    parameter RATE = 100;

    register register(
        .CLK(CLK),
        .WRITE(WRITE),
        .inaddr_a(inaddr_a),
        .inaddr_b(inaddr_b),
        .inaddr_w(inaddr_w),
        .indata_w(indata_w),
        .outdata_a(outdata_a),
        .outdata_b(outdata_b)
    );

    always #(RATE / 2) CLK = ~CLK;

    initial begin
        $dumpfile("tb_register.vcd");
        $dumpvars(0, register);
        $monitor("CLK = %d, WRITE = %d\n\t\tinaddr_a = %b, inaddr_b = %b, inaddr_w = %b\n\t\tindata_w = %x, outdata_a = %x, outdata_b = %x",
                CLK, WRITE, inaddr_a, inaddr_b, inaddr_w, indata_w, outdata_a, outdata_b);
    end

    initial begin
        #0  CLK = 0;
            WRITE = 0;
            inaddr_a = 5'b00000;
            inaddr_b = 5'b00000;
            inaddr_w = 5'b00000;
            indata_w = 32'h00000000;
        
        #(RATE - 10)    WRITE = 1;
                        inaddr_w = 5'b00001;
                        indata_w = 32'h0000ffff;
                        inaddr_a = 5'b00001;

        #(RATE * 10) $finish;
    end
endmodule