module pipeline_reg_tb;
    localparam WIDTH=32;
    logic clk;
    logic stall;
    logic flush;
    logic [WIDTH-1:0] in;
    logic [WIDTH-1:0] out;
    
    pipeline_reg #(.WIDTH(WIDTH)) dut(
        .clk(clk), .stall(stall), .flush(flush), .in(in), .out(out)
    );

    task check(input stall_t, input flush_t, input [WIDTH-1:0] in_t, input [WIDTH-1:0] exp);
    begin
        @(negedge clk);
        stall = stall_t;
        flush = flush_t;
        in = in_t;

        @(posedge clk);
        #1;
        if(out===exp) $display("PASS");
        else $display("FAIL, expected: %h, got: %h", exp, out);
    end
    endtask

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        $dumpfile("pipeline_reg.vcd");
        $dumpvars(0, pipeline_reg_tb);

        check(0,1,32'h0000_0004,32'h0000_0000);
        check(0,0,32'h0000_1000,32'h0000_1000);
        check(1,0,32'h00ff_ffff,32'h0000_1000);

        $finish;
    end



endmodule