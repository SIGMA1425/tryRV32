`timescale 1ps/1ps
module tb_selector();
    reg[31:0] input_a, input_b;
    reg ctrl;

    wire[31:0] out;

    selector sel(
        .input_a(input_a),
        .input_b(input_b),
        .ctrl(ctrl),
        .out(out)
    );

    initial begin
        $dumpfile("tb_selector.vcd");
        $dumpvars(0, sel);
        $monitor("input_a = %x, input_b = %x, crtl = %d, out = %x", input_a, input_b, ctrl, out);
    end

    initial begin
        #0  input_a = 32'h0000ffff;
            input_b = 32'hffff0000;
            ctrl = 0;
        #10
            ctrl = 1;
        #10 input_a = 32'h00ffff00;
        #10 ctrl = 0;
        #10 ctrl = 1;
    end

endmodule