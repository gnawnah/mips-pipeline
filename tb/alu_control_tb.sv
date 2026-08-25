module alu_control_tb;
    logic [1:0] ALUOp;
    logic [5:0] funct;
    logic [2:0] ALU_Control;

    alu dut(
        .ALUOp(ALUOp), .funct(funct), .ALU_Control(ALU_Control)
    );

    task check(input [1:0] ALUOp_t, input [5:0] funct_t, input [2:0] ALU_Control_e);
    begin
        ALUOP = ALUOp_t;
        funct = funct_t;

        if(ALU_Control==ALU_Control_e)
        $display("PASS!");
        else
        $display("FAIL! LOL!");
    end
    endtask

    initial begin
        $dumpfile("alu_control.vcd");
        $dumpvars(0,alu_control_tb);

        check(2'b00, 6'b000000, 3'b010);
        check(2'b01, 6'b000000, 3'b110);

        check(2'b10, 6'b100000, 3'b010);
        check(2'b10, 6'b100010, 3'b110);
        check(2'b10, 6'b100100, 3'b000);
        check(2'b10, 6'b100101, 3'b001);
        check(2'b10, 6'b101010, 3'b111);
        check(2'b11, 6'b010101, 3'bxxx);

        $finish


    end

endmodule