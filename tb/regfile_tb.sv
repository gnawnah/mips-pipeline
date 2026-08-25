module regfile_tb;
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
        input RegWrite_t,
        input [31:0] expected
    ); 
    begin
        @(negedge clk);
        // drive write inputs from task arguments
        RegWrite = RegWrite_t;
        write_reg = write_reg_t;
        write_data = write_data_t;

        @(posedge clk); #1
        read_reg1 = write_reg_t;

        if(read_data1 == expected)
        $display("Pass!");
        else
        $display("Failed!");

    end
    endtask

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("regfile.vcd");
        $dumpvars(0, regfile_tb);

        

        check(5,42,1,42);

        check(0,99,1,0);

        check(5,77,0,42);

        $finish;



    end







endmodule