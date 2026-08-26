module dmem(
    input logic [31:0] addr,
    input logic [31:0] write_data,
    input logic MemWrite,
    input logic MemRead,
    input logic clk,
    output logic [31:0] read_data
);
    logic [31:0] mem [0:255];

    always_ff @(posedge clk) begin
        if(MemWrite) mem[addr[9:2]] <= write_data;
    end

    assign read_data = mem[addr[9:2]];

endmodule