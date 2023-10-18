module Imm_gen (
    input [31:7] in,
    input [2:0] sel,
    output reg [31:0] out
);
    always @(*) begin
        case (sel)
            3'b000: out = {{20{in[31]}}, in[31:20]};                          //I-type
            3'b001: out = {{20{in[31]}}, in[31:25], in[11:8], in[7]};         //S-type
            3'b010: out = {{19{in[31]}}, in[7], in[30:25], in[11:8], 1'b0};   //B-type
            3'b011: out = {in[31:12], {12{1'b0}}};                            //U-type
            3'b100: out = {{12{in[31]}}, in[19:12], in[20], in[30:21], 1'b0}; //J-type
            default: out = 31'b0;
        endcase
    end
    
endmodule