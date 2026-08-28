module alu_control(
    input logic [1:0] ALUOp,
    input logic [5:0] funct,
    output logic [2:0] ALU_Control
);
    always_comb begin
        case (ALUOp)
            2'b00: ALU_Control = 3'b010; // add (lw, sw, addi)
            2'b01: ALU_Control = 3'b110; // subtract (beq)
            2'b10: // this is an R-type
            begin
                case (funct)
                6'b100000: ALU_Control = 3'b010; // add
                6'b100010: ALU_Control = 3'b110; // sub
                6'b100100: ALU_Control = 3'b000; // and
                6'b100101: ALU_Control = 3'b001; // or
                6'b101010: ALU_Control = 3'b111; // slt
                default: ALU_Control = 3'bxxx;
                endcase
            end
            default: ALU_Control = 3'bxxx;

        endcase
    end

endmodule