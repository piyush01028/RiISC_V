
module controller (
    input [31:0] instr,
    input Br_eq, Br_lt,

    output  reg_write_en, Br_un, mem_write_en, alu_src_A, alu_src_B,
    output reg [1:0] PC_sel, 
    output  [2:0] imm_src, 
    output  [1:0] result_src,
    output  [3:0] alu_control
);
    wire [6:0]opcode = instr[6:0];
    wire [2:0]funct3 = instr[14:12];
    wire funct7b5 = instr[30];
    wire j; 
    wire [1:0] alu_op;
    main_decoder md(.opcode(opcode), .f3(funct3), .branch(br), .imm_src(imm_src), .reg_w_en(reg_write_en), .br_un(Br_un), .B_sel(alu_src_B), .A_sel(alu_src_A), .mem_write_en(mem_write_en), .result_src(result_src), .alu_op(alu_op), .jmp(j));
    alu_decoder ad(.alu_op(alu_op), .f3(funct3), .f7b5(funct7b5), .alu_con(alu_control));
    
    always @(*) begin
        if(opcode == 7'b1100011)
            case (funct3)
                3'b000: if(Br_eq)
                            PC_sel = 1'b1;
                3'b001: if(~Br_eq)
                            PC_sel = 1'b1;
                3'b010: if(Br_lt)
                            PC_sel = 1'b1;
                3'b011: if(~Br_lt)
                            PC_sel = 1'b1;
                3'b100: if(Br_lt)
                            PC_sel = 1'b1;
                3'b101: if(~Br_lt)
                            PC_sel = 1'b1;
                default: PC_sel = 1'b0;
            endcase
    end

endmodule
