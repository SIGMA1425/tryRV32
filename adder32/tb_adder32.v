`timescale 1ns/1ns

module tb_adder32();
    reg[31:0] a, b;
    wire[31:0] s;
    wire c;

    adder32 a3(
        .a(a), .b(b), .s(s), .c(c)
    );

    initial begin
        $dumpfile("tb_adder.vcd");
        $dumpvars(0, a3);
        $monitor("Result: %x, C_out: %x", s, c);
    end

    initial begin
        #0  a = 32'h00000000;
            b = 32'h00004000;
        #10 a = 32'hffffffff;
            b = 32'h00000001;
        #10 $finish;
    end
endmodule
