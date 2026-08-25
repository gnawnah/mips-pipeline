module reg_file_tb;
    logic [4:0] read_reg1;
    logic [4:0] read_reg2;
    logic [4:0] write_reg;
    logic [31:0] write_data;
    logic RegWrite;
    logic clk;
    logic [31:0] read_data1;
    logic [31:0] read_data2;

    regfile dut (
        .read_reg1(read_reg1), 
        .read_reg2(read_reg2), 
        .write_reg(write_reg),
        .write_data(write_data),
        .RegWrite(RegWrite),
        .clk(clk),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    task check(
        input [4:0] write_reg_t,
        input [31:0] write_data_t,
        input RegWrite_t
    ); 
    begin
        write_reg = write_reg_t;
        write_data = write_data_t;

        if()


    end
    endtask

    initial begin
        $dumpfile("regfile.vcd");
        $dumpvars(0, regfile_tb);

        clk = 0;
        forever #5 clk = ~clk;



    end







endmodule