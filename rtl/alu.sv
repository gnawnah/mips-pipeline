module alu(
    input logic signed [31:0] a,
    input logic signed [31:0] b,
    input logic [3:0] ctrl,
    output logic [31:0] result,
    output logic zero = 0
);  
    always_comb begin
        case (ctrl)
            4'b0000: result = a & b;
            4'b0001: result = a | b;
            4'b0010: result = a + b;
            4'b0110: result = a - b;
            4'b0111: result = a < b;
            default: result = 0;
        endcase
        if(result==0) zero = 1;
        else zero = 0;
    end

    





endmodule