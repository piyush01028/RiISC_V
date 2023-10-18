module inst_mem (
    input [31:0] adr,
    output [31:0] out
);
    reg [31:0] imem [0:255];
    
    initial begin
        $readmemh("memory.mem", imem);
    end

    assign out = imem[adr];

endmodule
