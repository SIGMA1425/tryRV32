module imem(addr, data);
    input[31:0] addr;
    output[31:0] data;

    reg[7:0] memory[0:256];

    initial begin
        $readmemh("memory.txt", memory);
    end

    assign data = {memory[addr + 3], memory[addr + 2], memory[addr + 1], memory[addr]};

endmodule