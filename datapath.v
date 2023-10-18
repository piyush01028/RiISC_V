module datapath #(
    parameter PC_width = 32
    )(  
    //inputs
    input clk, rst,
    input PC_sel,               //to program counter mux
    input reg_write_en,         //write to reg file
    input [2:0] imm_src,        //to immediate generator
    input Br_un,                //to branch comparator signed = 0, unsigned = 1
    input alu_src_A, alu_src_B,  //to alu source muxes
    input [3:0] alu_control,    //alu control signal
    input mem_write_en,         //write_en for data mem
    input [1:0] result_src,     //to mux for result from alu or mem or pc+4

    // outputs  
    output [31:0] instr,        // 32 bit instruction
    output Br_eq, Br_lt,        // outputs from branch comparator
    output [31:0] out
);

    wire [PC_width-1:0] P_C, PC_next, ALU_out, PC_plus_4;
    
    MUX_2_in PC_mux(.in0(ALU_out), .in1(PC_plus_4), .sel(PC_sel), .out(PC_next));   //mux to select pc input
    dff PC(.clk(clk), .rst(rst), .d(PC_next), .q(P_C));                              //PC register

    assign PC_plus_4 = P_C + 32'b1;                                                  //increment pc by 32 bits (width of memory is 32 so 1 element = 32 bits)

    inst_mem imem(.adr(P_C), .out(instr));                                           //instruction memory


    wire [31:0] busA, busB, result, imm;                                            //register file below
    Reg_file r(.clk(clk), .rst(rst), .adrA(instr[19:15]), .adrB(instr[24:20]), .adrD(instr[11:7]), .reg_write_en(reg_write_en), .busA(busA), .busB(busB), .result(result));
                                                                                    
    Imm_gen i(.in(instr[31:7]), .sel(imm_src), .out(imm));                          //immediate generator

    Branch_comp bc(.in0(busA), .in1(busB), .un(Br_un), .eq(Br_eq), .lt(Br_lt));     //branch comparator

    wire [31:0] alu_in_A, alu_in_B;
    MUX_2_in alu_mux_A(.in0(busA), .in1(P_C), .sel(alu_src_A), .out(alu_in_A));      //mux alu in a
    MUX_2_in alu_mux_B(.in0(busB), .in1(imm), .sel(alu_src_B), .out(alu_in_B));     //mux alu in b

    ALU a(.in0(alu_in_A), .in1(alu_in_B), .alu_con(alu_control), .out(ALU_out));    //ALU

    wire [31:0] data;
    datamem d(.clk(clk), .en(mem_write_en), .adr(ALU_out), .dataW(busB), .dataR(data));                //Data memory

    MUX_3_in res_mux(.in0(data), .in1(ALU_out), .in2(PC_plus_4), .sel(result_src), .out(dataD)); //result mux
    assign out = ALU_out;
    
endmodule