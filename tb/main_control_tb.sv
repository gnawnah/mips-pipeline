module main_control_tb;
    logic [5:0] opcode;
    logic RegDst;
    logic ALUSrc;
    logic MemtoReg;
    logic RegWrite;
    logic MemRead;
    logic MemWrite;
    logic Branch;
    logic [1:0] ALUOp;

    logic [8:0] bus;
    assign bus = {RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp};

    main_control dut(
        .opcode(opcode),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    task check(input[5:0] opcode_t, input [8:0] expected_bus);
        begin
            opcode = opcode_t;
            #1; // need this delay for update
            if(bus==expected_bus) $display("PASS!");
            else $display("FAIL! LOL!");
        end
    endtask


    initial begin
        $dumpfile("main_control.vcd");
        $dumpvars(0, main_control_tb);

        // check R-type
        check(6'b000000,9'b100100010);
        // check lw
        check(6'b100011,9'b011110000);
        // check sw
        check(6'b101011,9'b010001000);
        // check beq
        check(6'b000100,9'b000000101);

        $finish;




    end

endmodule