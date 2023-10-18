module datamem (
    input clk, en, 
    input [31:0] adr, dataW,
    output [31:0] dataR
);
    reg [31:0] dmem [0:511] ;

    always @(posedge clk) begin
        if(en)
            dmem[adr] = dataW;
    end

    assign  dataR = dmem[adr];

endmodule
