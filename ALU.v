module ALU (
    input [31:0] in0, in1,
    input [3:0] alu_con,
    output reg [31:0] out
);

    always@(*) begin

        case (alu_con)
            4'b0000: out = in0 & in1;       //and
            4'b0001: out = in0 | in1;       //or
            4'b0010: out = in0 + in1;
            4'b0011: out = in0 << in1;
            4'b0100: out = (in0 < in1);
            4'b0101: out = ($unsigned(in0) < $unsigned(in1));
            4'b0110: out = in0 - in1;
            4'b0111: out = in0 ^ in1;
            4'b1000: out = in0 >> in1;
            4'b1010: out = in1 >>> in1;
            default: out = 32'b0;
        endcase
    end
    
endmodule

