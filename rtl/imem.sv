module imem(
    input logic [31:0] addr,
    output logic [31:0] instruction
);
    // this array stores 256 words instead of 1024 bytes
    logic [31:0] mem [0:255]; 



endmodule