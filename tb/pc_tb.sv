module pc_tb;
    logic clk;
    logic reset;
    logic [31:0] next_pc;
    logic [31:0] pc;

    pc dut(.clk(clk),.reset(reset),.next_pc(next_pc),.pc(pc));

    task check(input reset_t, input [31:0] next_pc_t, input [31:0] pc_e);
    begin
        @(negedge clk);
        reset = reset_t;
        next_pc = next_pc_t;
        @(posedge clk);
        #1;
        if(pc==pc_e) $display("PASS!");
        else $display("LOL FAIL");
    end
    endtask

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("pc.vcd");
        $dumpvars(0, pc_tb);

        // check reset
        check(1,32'h0000_0004,32'h0000_0000);

        // check load
        check(0,32'h0000_0004,32'h0000_0004);
        check(0,32'h0000_0008,32'h0000_0008);

        // arbitrary load
        check(0,32'h0000_2000,32'h0000_2000);

        // check reset again
        check(1,32'h2000_0000,32'h0000_0000);

        $finish;

    end




endmodule