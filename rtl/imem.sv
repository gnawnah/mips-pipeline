module imem(
    input logic [31:0] addr,
    output logic [31:0] instruction
);
    // this array stores 256 words instead of 1024 bytes
    logic [31:0] mem [0:255]; 

    initial $readmemh("program.hex", mem);

    // [9:2] since we're accessing words instead of bytes
    assign instruction = mem[addr[9:2]];


endmodule