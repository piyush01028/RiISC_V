module MUX_2_in (
    input in0, in1, sel,
    output reg out
);
    always @(*) begin
        case (sel)
            1'b0: out = in0;
            1'b1: out = in1;
            default: out = 1'b0;
        endcase
    end
endmodule

