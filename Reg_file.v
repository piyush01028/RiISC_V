module Reg_file (
    input clk, reg_write_en, rst,
    input [4:0] adrA, adrB, adrD,
    input [31:0] result,
    output [31:0] busA, busB
);

    reg [31:0] regs [0:31];
    integer i;
    always @(posedge clk, negedge rst) begin
        if(~rst) begin
            for(i = 0; i < 32; i = i+1)
                regs[i] = 32'b0;
        end
        else if(reg_write_en)  
            regs[adrD] <= result;
    end
    
    assign busA = regs[adrA];
    assign busB = regs[adrB];

endmodule

