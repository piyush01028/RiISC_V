module MUX_3_in (
    input in0, in1, in2,
    input [1:0] sel,
    output reg out
);
    always @(*) begin
        case(sel)
        2'b00: out = in0;
        2'b01: out = in1;
        2'b10: out = in2;
        default: out = 1'b0;
        endcase
    end
endmodule