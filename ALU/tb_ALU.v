`timescale 1ps/1ps

module tb_ALU();
    reg[31:0] input_a, input_b;
    reg[3:0] ctrl;

    wire[31:0] out;
    wire is_zero;

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
            ctrl = 4'b0000;
        
        #10 input_a = 32'h00000004;
            input_b = 32'h00000008;
            ctrl = 4'b1000;

        #10 input_a = 32'h0000ffff;
            input_b = 32'h00000001;
            ctrl = 4'b1000;

        #10 input_a = 32'hffffffff;
            input_b = 32'h00000001;
            ctrl = 4'b1000;
        
    end
endmodule