module pc(CLK, RST, D, Q);
    input CLK, RST;
    input[31:0] D;

    output[31:0] Q;
    reg[31:0]    Q;

    always @ (posedge CLK or posedge RST) begin
        if(RST == 1'b1)
            Q <= 32'h00000000;
        else
            Q <= D;
    end
endmodule