module datapath_tb;
    logic clk;
    logic reset;

    // counters
    int passes = 0; int fails = 0;

    datapath cpu(
        .clk(clk),
        .reset(reset)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // for these two funnctions, pure read and compare, no driving signals, they already exist
    task check_reg(input [4:0] r, input [31:0] expected, input string name);
        begin
            if(cpu.u_regfile.regs[r] === expected) begin
                passes++;
                $display("PASS, %s", name);
            end
            else begin
                fails++;
                $display("FAIL, %s: got %0d exp %0d", name, cpu.u_regfile.regs[r], expected);
            end
        end
    endtask

    task check_mem(input int index, input [31:0] expected, input string name);
        begin
            if(cpu.u_dmem.mem[index] === expected) begin
                passes++;
                $display("PASS, %s", name);
            end
            else begin
                fails++;
                $display("FAIL, %s: got %0d exp %0d", name, cpu.u_dmem.regs[index], expected);
            end
        end
    endtask

    initial begin
        $dumpfile("datapath.vcd");
        $dumpvars(0,datapath_tb);

        reset = 1;
        @(posedge clk);

        #1; // settle
        reset = 0;
        repeat(16) @(posedge clk);

        #1;

        check_reg(8, 5, "$8 addi");
        check_reg(9, 3, "$9 addi");
        check_reg(10, 8, "$10 add (5+3)");
        check_reg(11, 2, "$11 sub (5-3)");
        check_reg(12, 1, "#12 and (5&3)");
        check_reg(13, 7, "$13 or (5|3)");
        check_reg(14, 1, "$14 slt (3<5)");
        check_reg(15, 8, "$15 lw reads what sw wrote");
        check_reg(16, 7, "$16 beq skipped");
        check_reg(17, 4, "j skipped");

        check_mem(0, 8, "mem [0] sw");

        $finish;


    end



endmodule