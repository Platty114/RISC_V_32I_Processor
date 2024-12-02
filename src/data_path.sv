// data_path.sv
// James Platt 30130627
//

module data_path(
    input logic clk,
    input logic reset,
    input logic pc_src,
    input logic u_imm_src,
    input logic pc_target_src,
    input logic [1:0] result_src,
    input logic mem_write, 
    input logic [2:0] mem_width,
    input logic [3:0] alu_control,
    input logic alu_src,
    input logic [2:0] immediate_control,
    input logic reg_write,
    output logic [31:0] instruction,
    output logic equal,
    output logic less_than,
    output logic less_than_unsigned,
    output logic [31:0] value_from_alu,
    output logic [31:0] data_to_write
);
    //pc, pc_plus_4 and  
    //target adress for jump / branch
    logic [31:0] pc; 
    logic [31:0] pc_plus_4;
    logic [31:0] pc_target;

    //decoded instruction at memory location pc
    logic [31:0] decoded_instruction;

    assign instruction = decoded_instruction;

    //data going into register
    logic [4:0] rd_1, rd_2, wd_1;
    //data coming out of register
    logic [31:0] rs_1, rs_2;
    //data thats written back to reg
    logic [31:0] write_back_data;

    assign rd_1 = decoded_instruction[19:15];
    assign rd_2 = decoded_instruction[24:20];
    assign wd_1 = decoded_instruction[11:7];

    //immediate value to be extended
    logic [24:0] extend_src;
    //extended immediate
    logic [31:0] imm_ext;

    //upper immediate data to write back
    logic [31:0] upper_immediate;
    //pc + imm
    logic [31:0] pc_imm_added;

    assign extend_src = decoded_instruction[31:7];

    //ALU SrcB and ALU Result
    logic [31:0] alu_src_B;
    logic [31:0] alu_result;

    //loaded_data from memory
    logic [31:0] loaded_data;

    //assign data out for testing
    assign value_from_alu = alu_result;
    assign data_to_write = rs_2;

    //program counter
    program_counter PROGRAM_COUNTER(
        .pc_target(pc_target),
        .pc_src(pc_src),
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .pc_plus_4(pc_plus_4)
    );

    //instruction memory 
    instruction_memory INSTRUCT_MEM(
        .addr(pc),
        .rd_instr(decoded_instruction)
    );


    //register file
    reg_file REGISTER_FILE(
        .clk(clk),
        .write_enable(reg_write),
        .addr_1(rd_1),
        .addr_2(rd_2),
        .addr_3(wd_1),
        .write_data(write_back_data),
        .read_data_1(rs_1),
        .read_data_2(rs_2)
    ); 


    //extend unit and pc target
    extend_unit EXTEND(
        .src(extend_src),
        .control(immediate_control),
        .extended_src(imm_ext)
    ); 
    
    //add imm to pc
    assign pc_imm_added = pc + imm_ext;

    //select pc target from either pc + imm (jal) or
    //rs + imm (jalr)
    assign pc_target = (pc_target_src == 1'b0) 
        ? pc_imm_added 
        : alu_result; 

    //select upper immediate data as either imm or imm + pc
    //(lui) vs (auipc)
    assign upper_immediate = (u_imm_src == 1'b0)
        ? imm_ext
        : pc_imm_added;

    //alu unit and alu multiplexer 
    assign alu_src_B = (alu_src == 1'b1) ? imm_ext : rs_2;  

    alu ALU(
        .alu_control(alu_control),
        .alu_src(alu_src),
        .A(rs_1),
        .B(alu_src_B),
        .result(alu_result),
        .equal(equal),
        .less_than(less_than),
        .less_than_unsigned(less_than_unsigned)
    );


    //data_memory unit
    data_memory DATA_MEM(
        .clk(clk),
        .write_enable(mem_write),
        .mem_width(mem_width),
        .addr(alu_result),
        .write_data(rs_2),
        .read_data(loaded_data)
    ); 


    //Result selection
    always_comb begin

        case(result_src) 

            2'b00:  write_back_data = alu_result;
            2'b01:  write_back_data = loaded_data;
            2'b10:  write_back_data = pc_plus_4;
            2'b11:  write_back_data = upper_immediate;
            default: write_back_data = 32'hxxxx_xxxx;

        endcase
        
    end

endmodule
