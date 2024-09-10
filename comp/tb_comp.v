`timescale 1ps/1ps
module tb_comp();
    reg[31:0] input_a, input_b;
    reg signed_en;
    wire[1:0] res;

    comp comp(
        .input_a(input_a),
        .input_b(input_b),
        .signed_en(signed_en),
        .res(res)
    );

    initial begin
        $dumpfile("tb_comp.vcd");
        $dumpvars(0, comp);
        $monitor("input_a = %x, input_b = %x, signed_en = %d, res = %b", input_a, input_b, signed_en, res);
    end

    initial begin
        #0  input_a = 32'h00000000;
            input_b = 32'h00000000;
            signed_en = 1'b0;

        #10 input_a = 32'hffffffff;
            input_b = 32'h00000004;
            signed_en = 1'b0;

        #10 signed_en = 1'b1;

        #10 input_b = 32'hffffffff;
            input_a = 32'h00000004;
            signed_en = 1'b0;

        #10 signed_en = 1'b1;

        #10 $finish;
    end

endmodule
