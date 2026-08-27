module dmem_tb;
    logic [31:0] addr;
    logic [31:0] write_data;
    logic MemWrite;
    logic clk;
    logic [31:0] read_data;

    dmem dut (
        .addr(addr),
        .write_data(write_data),
        .MemWrite(MemWrite),
        .clk(clk),
        .read_data(read_data)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    task check(
        input [31:0] addr_t,
        input [31:0] write_data_t,
        input MemWrite_t,
        input [31:0] expected
    );
    begin
        @(negedge clk);
        addr = addr_t;
        write_data = write_data_t;
        MemWrite = MemWrite_t;
        @(posedge clk); // update values
        #1;
        if(read_data==expected) $display("PASS!");
        else $display("NAH!");
    end
    endtask

    initial begin
        $dumpfile("dmem.vcd");
        $dumpvars(0,dmem_tb);

        // check write and read
        check(32'h0000_0000,32'h1234_5678,1,32'h1234_5678);

        // check gating
        check(32'h0000_0004,32'h8765_4321,1,32'h8765_4321); // first write a value
        check(32'h0000_0004,32'h8888_9999,0,32'h8765_4321); // check if that value is kept with MemWrite = 0

        // check word addressing, address 0x00000008 should be unaffected
        check(32'h0000_0008,32'h0000_1000,0,32'h0000_0000);

        $finish;

    end



endmodule