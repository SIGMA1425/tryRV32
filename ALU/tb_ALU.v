`timescale 1ps/1ps

module tb_ALU();
    reg[31:0] input_a, input_b;
    reg[3:0] ctrl;

    wire[31:0] out;
    wire is_zero;

    parameter alu_ctrl = 4'b1101;

    ALU ALU(
        .input_a(input_a),
        .input_b(input_b),
        .ctrl(ctrl),
        .out(out),
        .is_zero(is_zero)
    );

    initial begin
        $dumpfile("ALU.vcd");
        $dumpvars(0, ALU);
        $monitor("input_a = %x, input_b = %x, ctrl = %b, out = %x, iz_zero = %d", input_a, input_b, ctrl, out, is_zero);
    end

    initial begin
        #0  input_a = 32'h00000000;
            input_b = 32'h00000000;
            ctrl = alu_ctrl;

        #10 input_a = 32'h00000004;
            input_b = 32'h00000008;
            ctrl = alu_ctrl;

        #10 input_a = 32'h0000ffff;
            input_b = 32'h00000001;
            ctrl = alu_ctrl;

        #10 input_a = 32'hffff0000;
            input_b = 32'h00000002;
            ctrl = alu_ctrl;

        #10 input_a = 32'h00600006;
            input_b = 32'h00000003;
            ctrl = alu_ctrl;

    end
endmodule
