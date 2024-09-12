module register(CLK, WRITE, inaddr_a, inaddr_b, inaddr_w, indata_w, outdata_a, outdata_b);
    input[4:0] inaddr_a, inaddr_b, inaddr_w;
    input[31:0] indata_w;
    input CLK, WRITE;

    output[31:0] outdata_a, outdata_b;
    reg[31:0] outdata_a, outdata_b;

    reg[31:0] reg_data[0:31];

    integer i;

    always @ (posedge CLK) begin
        if(WRITE == 1) begin
            if (inaddr_w != 5'b00000) begin
                reg_data[inaddr_w] = indata_w;
            end
        end      
    end

    always@ * begin
        if(inaddr_a == 5'b00000) begin
            outdata_a = 32'h00000000;
        end
        else begin
            outdata_a = reg_data[inaddr_a];
        end

        if(inaddr_b == 5'b00000) begin
            outdata_b = 32'h00000000;
        end
        else begin
            outdata_b = reg_data[inaddr_b];
        end
    end

endmodule