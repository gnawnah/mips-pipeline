module datapath(
    input logic clk, 
    input logic reset,
    output logic [31:0] pc, // for observing only, need to delete later
    output logic [31:0] instruction // same with this
);
    logic [31:0] pc_plus4; //adder's output
    
    pc u_pc (.clk(clk),.reset(reset),.next_pc(pc_plus4),.pc(pc));

    adder u_adder (.a(pc),.b(32'd4),.sum(pc_plus4));

    imem u_imem (.addr(pc),.instruction(instruction));





endmodule