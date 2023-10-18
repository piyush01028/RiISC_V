module main_decoder (
    input [6:0] opcode,
    input [2:0] f3,
    output reg branch, reg_w_en, jmp, mem_write_en, A_sel, B_sel, br_un,
    output reg [1:0] alu_op, result_src,
    output reg [2:0] imm_src
);
    always @(*) 
        case (opcode)
                7'b0110011: begin                       //R-type
                branch = 1'b0;
                imm_src = 3'bxxx;
                reg_w_en = 1'b1;
                br_un = 1'bx;
                B_sel = 1'b0;
                A_sel = 1'b0;
                mem_write_en = 1'b0;
                result_src = 2'b01;
                alu_op = 2'b10;
                jmp = 1'b0;
             end

            7'b0010011: begin                       // I type addi..
                branch = 1'b0;
                imm_src = 3'b000;
                reg_w_en = 1'b1;
                br_un = 1'bx;
                B_sel = 1'b1;
                A_sel = 1'b0;
                mem_write_en = 1'b0;
                result_src = 2'b01;
                alu_op = 2'b11;
                jmp = 1'b0;
            end

            7'b0000011: begin                       // lw
                branch = 1'b0;
                imm_src = 3'b000;
                reg_w_en = 1'b1;
                br_un = 1'bx;
                B_sel = 1'b0;
                A_sel = 1'b0;
                mem_write_en = 1'b0;
                result_src = 2'b01;
                alu_op = 2'b00;
                jmp = 1'b0;
            end

            7'b1100111: begin                       // JALR
                branch = 1'b0;
                imm_src = 3'b000;
                reg_w_en = 1'b1;
                br_un = 1'bx;
                B_sel = 1'b0;
                A_sel = 1'b0;
                mem_write_en = 1'b0;
                result_src = 2'b10;
                alu_op = 2'b10;
                jmp = 1'b1;
            end

            7'b0100011: begin                       //S-type
                branch = 1'b0;
                imm_src = 3'b001;
                reg_w_en = 1'b0;
                br_un = 1'bx;
                B_sel = 1'b1;
                A_sel = 1'b0;
                mem_write_en = 1'b1;
                result_src = 2'bxx;
                alu_op = 2'b00;
                jmp = 1'b0;
            end

            7'b1100011: begin                       //B-type
                branch = 1'b1;
                imm_src = 3'b010;
                reg_w_en = 1'b0;
                B_sel = 1'b1;
                A_sel = 1'b1;
                mem_write_en = 1'b0;
                result_src = 2'bxx;
                alu_op = 2'b00;
                jmp = 1'b0;
                case (f3)
                    3'b110: br_un = 1'b1;
                    3'b111: br_un = 1'b1;
                    default: br_un = 1'b0;
                endcase
            end

            7'b0110111: begin                       //U type lui 
                branch = 1'b0;
                imm_src = 3'b011;
                reg_w_en = 1'b1;
                br_un = 1'bx;
                B_sel = 1'b1;
                A_sel = 1'bx;
                mem_write_en = 1'b0;
                result_src = 2'b01;
                alu_op = 2'b00;
                jmp = 1'b0;
            end

            7'b0010111: begin                       // auipc
                branch = 1'b0;      
                imm_src = 3'b011;
                reg_w_en = 1'b1;
                br_un = 1'bx;
                B_sel = 1'b1;
                A_sel = 1'b1;
                mem_write_en = 1'b0;
                result_src = 2'b01;
                alu_op = 2'b00;
                jmp = 1'b0;
            end

            7'b1101111:begin                            //JAL
                branch = 1'b0;
                imm_src = 3'b100;
                reg_w_en = 1'b1;
                br_un = 1'bx;
                B_sel = 1'b1;
                A_sel = 1'b1;
                mem_write_en = 1'b0;
                result_src = 2'b10;
                alu_op = 2'b00;
                jmp = 1'b1;
            end
            default:begin
                    branch = 1'bx;
                    imm_src = 3'bxxx;
                    reg_w_en = 1'bx;
                    br_un = 1'bx;
                    B_sel = 1'bx;
                    A_sel = 1'bx;
                    mem_write_en = 1'bx;
                    result_src = 2'bxx;
                    alu_op = 2'bxx;
                    jmp = 1'bx;
            end
        endcase
            

endmodule


