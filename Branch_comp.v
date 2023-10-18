module Branch_comp (
    input signed [31:0] in0, in1,
    input un,
    output reg lt, 
    output eq
);
    assign eq = (in0 == in1);

    always @(*) begin
        if(un)
            lt = ($unsigned(in0) < $unsigned(in1)) ;
        else    
            lt = (in0 < in1) ;
    end   
endmodule

