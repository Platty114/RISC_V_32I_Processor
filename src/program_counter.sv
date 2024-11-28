// program_counter.sv
// James Platt 30130627


module program_counter(
    input logic [31:0] pc_target,
    input logic pc_src,
    input logic clk,
    input logic reset,
    output logic [31:0] pc,
    output logic [31:0] pc_plus_4
);

    logic [31:0] pc_next;

    //assign next pc based on pc_src control
    assign pc_next = (pc_src != 1'b1) ? pc_plus_4 : pc_target;

    assign pc_plus_4 = pc + 32'h0000_0004;

    always_ff @(posedge clk) begin
        if(reset) begin
            pc <= 32'h0000_0000;
        end
        else begin
            if(pc != 32'h0000_004C) begin
                pc <= pc_next;
            end
        end
    end


endmodule
