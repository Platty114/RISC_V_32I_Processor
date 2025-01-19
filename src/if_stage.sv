// if_stage.sv
// James Platt 30130627
//

/*
*
* this module contains all the modules for a typical 
* 'instruction fetch' stage in a 5 stage pipeline.
* ie, a program counter and instruction memory
*/
module if_stage(
    input logic pc_src,
    input logic stall_if,
    input logic clk,
    input logic reset,
    input logic [31:0] pc_target,
    output logic [31:0] pc,
    output logic [31:0] pc_plus_4,
    output logic [31:0] rd_instr
);

    program_counter pc_inst(
	.pc_target(pc_target),
	.pc_src(pc_src),
	.clk(clk),
	.reset(reset),
	.enable_n(stall_if),
	.pc(pc),
	.pc_plus_4(pc_plus_4),
    );

    instruction_mem im_inst(
	.addr(pc),
	.rd_instr(rd_instr)
    );

endmodule
