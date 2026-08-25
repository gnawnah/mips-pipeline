module alu_tb;
    logic signed [31:0] a;
    logic signed [31:0] b;
    logic [2:0] ctrl;
    logic [31:0] result;
    logic zero;

    alu u0 (.a(a), .b(b), .ctrl(ctrl), .result(result), .zero(zero));

    task check(input [31:0] a_t, b_t, input [2:0] ctrl_t, input [31:0] expected_result, input expected_zero);
        begin
            a = a_t;
            b = b_t;
            ctrl = ctrl_t;

            #1; // delay

            if((result==expected_result)&&(zero==expected_zero))
            $display("you just passed!");
            else
            $display("you failed!!!");


        end
    endtask

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        // check and
        check(1,1,3'b000,1,0);
        // check or
        check(1,0,3'b001,1,0);
        // check slt
        check(1,2,3'b111,1,0);
        // check add for zero
        check(0,0,3'b010,0,1);
        // check add again, zero should drop back to 0
        check(5,7,3'b010,12,0);

        $finish;

    end


endmodule