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

    task check_reg(input [4:0] r, input [31:0] expected, input string name);
        begin
            if(dut.u_regfile.regs[r] === exp) begin
                passes++;
                $display("PASS, %s", nm);
            end
            else begin
                fails++;
                $display("FAIL, %s", nm);
            end
        end
    endtask

    task check_mem(input int index, input [31:0] expected, input string name);
        begin


        end
    endtask

    initial begin
        $dumpfile("datapath.vcd");
        $dumpvars(0,data_tb);

        reset = 1;
        @(posedge clk);

        #1; // settle
        reset = 0;
        repeat(16) @(posedge clk);

        #1;

        $finish;


    end



endmodule