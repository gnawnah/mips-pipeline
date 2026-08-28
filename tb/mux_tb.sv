module mux_tb;
    logic sel;
    // 32 bit
    logic [31:0] in0, in1, out;
    // 5 bit for RegDst
    logic [4:0] a5,b5,c5;

    mux #(.WIDTH(32)) dut32 (.in0(in0),.in1(in1),.sel(sel),.out(out));

    mux #(.WIDTH(5)) dut5 (.in0(a5),.in1(b5),.sel(sel),.out(c5));

    task check32(input [31:0] x, input [31:0] y, input sel_t, input [31:0] expected);
    begin
        in0 = x;
        in1 = y;
        sel = sel_t;
        #1;
        if(out==expected) $display("YES");
        else $display("NO, out=%h,exp=%h",out,expected);
    end
    endtask

    task check5(input [4:0] a, input [4:0] b, input sel_t, input [4:0] expected);
    begin
        a5 = a;
        b5 = b;
        sel = sel_t;
        #1;
        if(c5==expected) $display("YES");
        else $display("NO, out=%h,exp=%h",c5,expected);
    end
    endtask

    initial begin
        $dumpfile("mux.vcd");
        $dumpvars(0,mux_tb);

        // 32 bits: check sel=0
        check32(32'h0000_1000,32'h0000_2000,1'b0,32'h0000_1000);
        // 32 bits:check sel=1
        check32(32'h0000_3000,32'h0000_3008,1'b1,32'h0000_3008);

        // 5 bits: check sel=0
        check5(5'b00010,5'b00011,1'b0,5'b00010);
        // 5 bits: check sel=1
        check5(5'b10001,5'b11100,1'b1,5'b11100);
        $finish;
    end


endmodule