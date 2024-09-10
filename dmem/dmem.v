module dmem(CLK, addr, w_data, ctrl, w_en, outdata);
    input[31:0] addr, w_data;
    input[2:0] ctrl;
    input w_en, CLK;
    reg[7:0] data[0:4096];
    output[31:0] outdata;

    always @(posedge CLK) begin
        if (w_en == 1'b1) begin
            if (ctrl == 3'b000) begin
                data[addr] <= w_data[7:0];
            end
            else if(ctrl == 3'b001) begin
                data[addr] <= w_data[7:0];
                data[addr + 1] <= w_data[15:8];
            end
            else if(ctrl == 3'b010) begin
                $display("OK");
                data[addr] <= w_data[7:0];
                data[addr + 1] <= w_data[15:8];
                data[addr + 2] <= w_data[23:16];
                data[addr + 3] <= w_data[31:24];
            end
        end
    end

    assign outdata = (w_en == 1'b1)?   32'h00000000:
                     (ctrl == 3'b000)? {{24{data[addr][7]}}, data[addr]}:
                     (ctrl == 3'b001)? {{16{data[addr][7]}}, data[addr + 1], data[addr]}:
                     (ctrl == 3'b010)? {data[addr + 3], data[addr + 2], data[addr + 1], data[addr]}:
                     (ctrl == 3'b100)? {24'h000000, data[addr]}:
                     (ctrl == 3'b101)? {16'h0000, data[addr + 1], data[addr]}:
                                       32'h00000000;
    
endmodule