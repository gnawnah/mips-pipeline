module dmem(
    input logic [31:0] addr,
    input logic [31:0] write_data,
    input logic MemWrite,
    input logic MemRead,
    input logic clk,
    output logic [31:0] read_data
);
    logic [31:0] mem [0:255]; // no pre load needed for this

    // zero memory at sim start
    integer i;
    initial for (i=0; i<256; i=i+1) mem[i] = 32'h0;

    always_ff @(posedge clk) begin
        if(MemWrite) mem[addr[9:2]] <= write_data;
    end

    assign read_data = mem[addr[9:2]];

endmodule