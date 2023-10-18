module alu_decoder (
    input [1:0] alu_op,
    input [2:0] f3,
    input f7b5,
    output reg [3:0] alu_con
);
    always @(*)
begin
case (alu_op)
    2'b00 : alu_con <= 4'b0010;
    2'b01 : alu_con <= 4'b0110;
    2'b10 : case({f7b5,f3})
        4'b0000 : alu_con <= 4'b0010; // add
        4'b1000 : alu_con <= 4'b0110; // sub
        4'b0111 : alu_con <= 4'b0000; // and
        4'b0110 : alu_con <= 4'b0001; // or
        4'b0001 : alu_con <= 4'b0011; // sll
        4'b0010 : alu_con <= 4'b0100; // slt
        4'b0011 : alu_con <= 4'b0101; // sltu
        4'b0100 : alu_con <= 4'b0111; // xor
        4'b0101 : alu_con <= 4'b1000; // srl
        4'b1101 : alu_con <= 4'b1010; // sra
        default : alu_con <= 4'bxxxx;
        endcase
    2'b11 : case({f7b5,f3})
        4'b0000 : alu_con <= 4'b0010; // addi
        4'b0010 : alu_con <= 4'b0100; // slti
        4'b0011 : alu_con <= 4'b0101; // sltui
        4'b0100 : alu_con <= 4'b0111; // xori
        4'b0110 : alu_con <= 4'b0001; // ori
        4'b0111 : alu_con <= 4'b0000; // andi
        4'b0001 : alu_con <= 4'b0011; // slli
        4'b0101 : alu_con <= 4'b1000; // srli
        4'b1101 : alu_con <= 4'b1010; // srai
        default : alu_con <= 4'bxxxx;
        endcase
endcase
end
endmodule
