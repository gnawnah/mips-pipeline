module regfile(
    input logic [4:0] read_reg1,
    input logic [4:0] read_reg2,
    input logic [4:0] write_reg,
    input logic [31:0] write_data,
    input logic RegWrite,
    input logic clk,
    output logic [31:0] read_data1,
    output logic [31:0] read_data2
);

    logic [31:0] regs [0:31]; // registers

    integer i;
    initial begin
        for (i=0; i<32; i=i+1) begin
            regs[i] = 32'h00000000;
        end
    end

    always_ff @(posedge clk) begin
        if(RegWrite && write_reg !=0) begin // register 0 must not be written
            regs[write_reg] <= write_data;
        end


    end

    always_comb begin
        // if read reg0, give 0
        read_data1 = (read_reg1 == 0) ? 0 : regs[read_reg1];
        read_data2 = (read_reg2 == 0) ? 0 : regs[read_reg2];
    end





endmodule