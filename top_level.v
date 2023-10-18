module top_level(
    input clk, rst
);
    wire [31:0] instr;
    wire Br_eq, Br_lt;
    wire reg_write_en, Br_un, mem_write_en, alu_src_A, alu_src_B;
    wire [1:0] PC_sel;
    wire [2:0] imm_src; 
    wire [1:0] result_src;
    wire [3:0] alu_control;
    
    datapath d( .clk(clk), .rst(rst), .instr(instr), .Br_eq(Br_eq), .Br_lt(Br_lt), 
    .reg_write_en(reg_write_en), .Br_un(Br_un), .mem_write_en(mem_write_en), 
    .alu_src_A(alu_src_A), .alu_src_B(alu_src_B), .PC_sel(PC_sel), .imm_src(imm_src), 
    .result_src(result_src), .alu_control(alu_contorl));
    
    controller c(.instr(instr), .Br_eq(Br_eq), .Br_lt(Br_lt), 
    .reg_write_en(reg_write_en), .Br_un(Br_un), .mem_write_en(mem_write_en), 
    .alu_src_A(alu_src_A), .alu_src_B(alu_src_B), .PC_sel(PC_sel), .imm_src(imm_src), 
    .result_src(result_src), .alu_control(alu_contorl));
    
endmodule