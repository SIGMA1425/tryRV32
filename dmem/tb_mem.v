`timescale 1ps/1ps
module tb_dmem();
    reg[31:0] addr, w_data;
    reg[2:0] ctrl;
    reg w_en, CLK;
    wire[31:0] outdata;

    parameter RATE = 100;
    dmem dmem(
        .CLK(CLK),
        .addr(addr),
        .w_data(w_data),
        .ctrl(ctrl),
        .w_en(w_en),
        .outdata(outdata)
    );

    always #(RATE/2) CLK = ~CLK;

    initial begin
        $dumpfile("tb_dmem.vcd");
        $dumpvars(0, dmem);
        $monitor("CLK = %d, w_en = %d, addr = %x, w_data = %x, ctrl = %b, outdata = %x", CLK, w_en, addr, w_data, dmem.ctrl, outdata);
    end

    initial begin
        #0  addr = 32'h00000000;
            w_data = 32'h00000000;
            ctrl = 3'b010;
            w_en = 1'b0;
            CLK = 1'b0;
        
        #10 w_en = 1'b1;
            w_data = 32'h12345678;
            ctrl = 3'b010;

        #RATE w_en = 1'b0;
              ctrl = 3'b000;
        
        #RATE ctrl = 3'b001;

        #RATE ctrl = 3'b010;
        #RATE ctrl = 3'b100;
        #RATE ctrl = 3'b101;

        #10 w_en = 1'b1;
            w_data = 32'hf123f6f8;
            ctrl = 3'b001;

        #RATE w_en = 1'b0;
              ctrl = 3'b000;
        
        #RATE ctrl = 3'b001;

        #RATE ctrl = 3'b010;
        #RATE ctrl = 3'b100;
        #RATE ctrl = 3'b101;

        #(RATE * 10) $finish;
    end
endmodule