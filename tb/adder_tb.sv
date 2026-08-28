module adder_tb;
    logic [31:0] a;
    logic [31:0] b;
    logic [31:0] sum;

    adder dut (.a(a),.b(b),.sum(sum));

    task check(input [31:0] a_t, input [31:0] b_t, input[31:0] sum_e);
    begin
        a = a_t;
        b = b_t;
        #1;
        if(sum==sum_e) $display("PASS");
        else $display("FAIL");
    end
    endtask

    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0,adder_tb);

        // check basic add
        check(32'h0000_1000,32'd4,32'h1004);

        // check negative 
        check(32'h0000_1000,32'hffff_fffc,32'h0000_0ffc);

        // check wrap
        check(32'hffff_ffff,32'd1,32'h0000_0000);

        $finish;


    end




endmodule