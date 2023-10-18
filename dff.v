module dff (
    input clk, d, rst,
    output reg q
);
    always @(posedge clk, negedge rst) begin
        if(~rst)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule