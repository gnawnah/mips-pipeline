module mux_tb #(parameter WIDTH = 32);
    logic [WIDTH-1:0] in0;
    logic [WIDTH-1:0] in1;
    logic sel;
    logic [WIDTH-1:0] out;

    mux #(.WIDTH(WIDTH)) dut(.in0(in0),.in1(in1),.sel(sel),.out(out));

    task check(input [WIDTH-1:0] in0_t, input [WIDTH-1:0] in1_t, input sel_t, input [WIDTH-1:0] expected);
    begin
        in0 = in0_t;
        in1 = in1_t;
        sel = sel_t;
        #1;
        if(out==expected) $display("YES");
        else $display("NO");
    end
    endtask

    initial begin
        $dumpfile("mux.vcd");
        $dumpvars(0,mux_tb);

        // check sel=0
        check(32'h0000_1000,32'h0000_2000,1'b0,32'h0000_1000);

        check(32'h0000_3000,32'h0000_3008,1'b1,32'h0000_3008);

        $finish;
    end


endmodule