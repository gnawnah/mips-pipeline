module alu_tb;
    logic signed [31:0] a;
    logic signed [31:0] b;
    logic [3:0] ctr;
    logic [31:0] result;
    logic zero;

    alu u0 (.(a), .b(b), .ctr(ctr), .result(result), .zero(zero));

    initial begin
        #1;
        a <= 5;
        b <= 7;
        ctr <= 4'b0010;

        if(result==(a+b))
            //display "true"
        else
            //display "false"

        $finish;

    end


endmodule