module alu_tb;
    logic signed [31:0] a;
    logic signed [31:0] b;
    logic [3:0] ctrl;
    logic [31:0] result;
    logic zero;

    alu u0 (.a(a), .b(b), .ctrl(ctrl), .result(result), .zero(zero));

    task check(input [31:0] a_t, b_t, input [3:0] ctrl_t, input [31:0] expected_result, input expected_zero);
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
        // check add
        check(5,7,4'b0010,12,0);
        // check and
        check(1,1,4'b0000,1,0);
        // check or
        check(1,0,4'b0001,1,0);
        // check slt
        check(1,2,4'b0111,1,0);
        // check add for zero
        check(0,0,4'b0010,0,1);

        $finish;

    end


endmodule