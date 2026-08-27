module pc(
    input logic clk,
    input logic reset,
    input logic [31:0] next_pc,
    output logic [31:0] pc
);

    always_ff @(posedge clk) begin
        if(reset) pc <= 0;
        else pc <= next_pc;
    end


endmodule