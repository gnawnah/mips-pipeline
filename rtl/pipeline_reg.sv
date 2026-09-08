module pipeline_reg #(parameter WIDTH = 32)(
    input logic clk,
    input logic stall, // when high, register holds its current value, does not latch new input
    input logic flush, // when high, register clears to zero
    input logic [WIDTH-1:0] in,
    output logic [WIDTH-1:0] out
);

    always_ff @(posedge clk ) begin
        if(flush) out<=32'h0000_0000;
        else if (stall) out<=out;
        else out<=in;
    end

endmodule