module sign_extend_tb;
    logic signed [15:0] in;
    logic signed [31:0] out;

    sign_extend dut (
        .in(in),
        .out(out)
    );

    task check(input [15:0] in_t, input [31:0] expected);
    begin
        in = in_t; #1;

        if(out==expected) $display("PASS!!!");
        else $display("HELL NAH");
    end
    endtask

    initial begin
        $dumpfile("sign_extend.vcd");
        $dumpvars(0,sign_extend_tb);

        check(16'h0005,32'h00000005); // positive, zero paddings

        check(16'hffff,32'hffffffff); // negative, one pads

        check(16'h8000,32'hffff8000);

        check(16'h7fff,32'h00007fff);

        check(16'h0000,32'h00000000); // zeros

        $finish;

    end





endmodule