module datapath(
    input logic clk, 
    input logic reset,
    output logic [31:0] pc, // for observing only, need to delete later
    output logic [31:0] instruction // same with this
);
    logic [31:0] pc_plus4; //adder's output
    logic RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
    logic [1:0] ALUOp;
    logic [31:0] read_data1, read_data2;
    logic [31:0] se_out;
    logic [2:0] ALU_Control;
    logic signed [31:0] b;
    logic [31:0] result;
    logic zero;
    
    pc u_pc (.clk(clk),.reset(reset),.next_pc(pc_plus4),.pc(pc));

    adder u_adder (.a(pc),.b(32'd4),.sum(pc_plus4));

    imem u_imem (.addr(pc),.instruction(instruction));

    // instruction: opcode bits [31:26], rs bits [25:21], rt bits[20:16], 
    // rd bits[15:11] (R-Type), funct bits [5:0] (R-type), immediate bits [15:0] (I-type)
    main_control u_main_control (
        .opcode(instruction[31:26]),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    regfile u_regfile(
        .read_reg1(instruction[25:21]),
        .read_reg2(instruction[20:16]),
        .write_reg(5'd0), // place holder
        .write_data(32'd0), // place holder
        .RegWrite(RegWrite),
        .clk(clk),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // I-type (lw, sw, addi, beq)
    sign_extend u_sign_extend(
        .in(instruction[15:0]),
        .out(se_out)
    );

    alu_control u_alu_control(
        .ALUOp(ALUOp),
        .funct(instruction[5:0]),
        .ALU_Control(ALU_Control)
    );

    mux ALUSrc_mux(
        .in0(read_data2),
        .in1(se_out),
        .sel(ALUSrc),
        .out(b)
    );

    alu u_alu(
        .a(read_data1),
        .b(b),
        .ctrl(ALU_Control),
        .result(result),
        .zero(zero)
    );


endmodule