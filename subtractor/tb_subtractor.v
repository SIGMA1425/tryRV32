`timescale 1ns/1ns

module tb_subtractor();
    reg[31:0] a, b;
    wire[31:0] s;
    wire c;

    subtractor sub(
        .input_a(a), .input_b(b), .sub(s)
    );

    initial begin
        $dumpfile("tb_adder.vcd");
        $dumpvars(0, sub);
        $monitor("Result: %x", s);
    end

    initial begin
        #0  a = 32'h00000000;
            b = 32'h00004000;
        #10 a = 32'hffffffff;
            b = 32'h00000001;
        #10 $finish;
    end
endmodule