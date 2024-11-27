// risc_v_32_i.sv
// A risc 5 32 bit single cycle implementation
// James Platt 30130627
//

module risc_v_32_i(
    input logic clk, //100Mhz clk
    input logic clk_enable, //clk enable used to divide the clk
    input logic clk_enable_n, //clk enable_n used to divide the clk for negedge
    input logic reset,
    output logic [31:0] value_from_alu,
    output logic [31:0] data_to_write,
    output logic writting_to_mem
);
    
    //connection logic between control unit
    //and data path
    //CONTROL
    logic [31:0] instruction;
    logic pc_src;
    logic [1:0] result_src;
    logic mem_write;
    logic [3:0] alu_control;
    logic alu_src;
    logic [1:0] immediate_control;
    logic reg_write;
    //DATA
    logic equal;
    logic less_than;
    logic less_than_unsigned;

    //for testing purposes
    assign writting_to_mem = mem_write;

    decoder CONTROL_UNIT(
        .instruction(instruction),
        .equal(equal),
        .less_than(less_than),
        .less_than_unsigned(less_than_unsigned),
        .pc_src(pc_src),
        .result_src(result_src),
        .mem_write(mem_write), 
        .alu_control(alu_control),
        .alu_src(alu_src),
        .immediate_control(immediate_control),
        .reg_write(reg_write)
    );


    data_path DATA_PATH(
        .clk(clk),
        .clk_enable(clk_enable),
        .clk_enable_n(clk_enable_n),
        .reset(reset),
        .pc_src(pc_src),
        .result_src(result_src),
        .mem_write(mem_write), 
        .alu_control(alu_control),
        .alu_src(alu_src),
        .immediate_control(immediate_control),
        .reg_write(reg_write),
        .instruction(instruction),
        .equal(equal),
        .less_than(less_than),
        .less_than_unsigned(less_than_unsigned),
        .value_from_alu(value_from_alu),
        .data_to_write(data_to_write)
    );

endmodule
