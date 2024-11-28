// decoder.sv
// James Platt 30130627
// Based on Patterson and Patterson implementation
//

module decoder(
    input logic [31:0] instruction,
    input logic equal,
    input logic less_than,
    input logic less_than_unsigned,
    output logic pc_src,
    output logic [1:0] result_src,
    output logic mem_write, 
    output logic [3:0] alu_control,
    output logic alu_src,
    output logic [1:0] immediate_control,
    output logic reg_write
);
    
    //use instructions op code, 3 bit funct 3 field, and bit
    //5 of funct 7 field to decode instruction
    logic [6:0] opcode;
    logic [2:0] funct3;
    logic funct7_5;

    //internal signals for decoding
    logic branch, jump, branch_correct;
    logic [1:0] alu_op;

    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7_5 = instruction[30];

    //main instruction decoding
    main_decoder MAIN_DECODER(
        .opcode(opcode), //in
        .branch(branch), //out
        .result_src(result_src), //out
        .mem_write(mem_write),  //out
        .alu_src(alu_src), //out 
        .immediate_control(immediate_control), //out
        .reg_write(reg_write), //out
        .alu_op(alu_op), //out 
        .jump(jump) //out
    ); 


    //alu decoder
    alu_decoder ALU_DECODER(
        .alu_op(alu_op), //input
        .funct3(funct3), //input
        .op5(opcode[5]), //input
        .funct7(funct7_5), //input
        .alu_control(alu_control) //output
    );

    branch_decoder BRANCH_DECODER(
        .equal(equal),
        .less_than(less_than),
        .less_than_unsigned(less_than_unsigned),
        .funct3(funct3),
        .branch_correct(branch_correct)
    );

    //pc selection logic
    //need to jump either when jump is asserted, or branch and 
    //the branch value (equal, not equal, etc) is correct.
    assign pc_src = (branch & branch_correct) | jump;

endmodule
