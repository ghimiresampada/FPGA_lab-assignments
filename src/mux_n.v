module mux_n
    #(
        parameter N = 8   // default = 8
    )
    (
        input  wire [N-1:0] a,   
        input  wire [N-1:0] b,     
        input  wire  sel,  
        output reg  [N-1:0] y     
    );

    always @(*) begin
        case (sel)
            1'b0 : y = a;
            1'b1 : y = b;
            default : y = {N{1'bx}};
        endcase
    end

endmodule