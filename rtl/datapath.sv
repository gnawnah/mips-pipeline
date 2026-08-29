module datapath(
    input logic clk, 
    input logic reset,
    output logic [31:0] pc, // for observing only, need to delete later
    output logic [31:0] instruction // same with this
);

    logic [31:0] pc_plus4; //adder's output
    logic RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump;
    logic [1:0] ALUOp;
    logic [31:0] read_data1, read_data2;
    logic [31:0] se_out;
    logic [2:0] ALU_Control;
    logic [31:0] b;
    logic [31:0] result;
    logic zero;
    logic [31:0] mem_read_data;
    logic [31:0] write_back_data;
    logic [4:0] write_reg;
    logic [31:0] branch_target;
    logic [31:0] branch_result;
    logic PCSrc;
    logic [31:0] next_pc;
    logic [31:0] jump_target;

    assign PCSrc = Branch & zero;

    assign jump_target = {pc_plus4[31:28], instruction[25:0], 2'b00}; // top bits of pc+4, 26 bit address field, 2 zero bits
    
    pc u_pc (.clk(clk),.reset(reset),.next_pc(next_pc),.pc(pc));

    adder plus4_adder (.a(pc),.b(32'd4),.sum(pc_plus4));

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
        .Jump(Jump),
        .ALUOp(ALUOp)
    );

    regfile u_regfile(
        .read_reg1(instruction[25:21]),
        .read_reg2(instruction[20:16]),
        .write_reg(write_reg), 
        .write_data(write_back_data),
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

    dmem u_dmem(
        .addr(result), // the alu result is the memory address
        .write_data(read_data2), // for sw
        .MemWrite(MemWrite), // from control
        .MemRead(MemRead), // from control
        .clk(clk),
        .read_data(mem_read_data) // feads write bck
    );

    mux MemtoReg_mux(
        // from alu or from memory data
        .in0(result), // the alu result, for r-type addi
        .in1(mem_read_data),
        .sel(MemtoReg),
        .out(write_back_data) // goes to regfile write_data
    );

    mux #(.WIDTH(5)) RegDst_mux (
        // selects which register to write
        .in0(instruction[20:16]), // rt (for I-type eg addi and lw)
        .in1(instruction[15:11]), // rd (R-type)
        .sel(RegDst),
        .out(write_reg) // goes to regfile write_reg
    );

    adder branch_target_adder(
        .a(pc_plus4),
        .b(se_out<<2),
        .sum(branch_target)
    );

    mux #(.WIDTH(32)) PCSrc_mux (
        .in0(pc_plus4),
        .in1(branch_target),
        .sel(PCSrc),
        .out(branch_result)
    );

    mux #(.WIDTH(32)) Jump_mux(
        .in0(branch_result),
        .in1(jump_target),
        .sel(Jump),
        .out(next_pc)
    );

endmodule