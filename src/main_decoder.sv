// main_decoder.sv
// James Platt 30130627
// Based on Patterson and Patterson implementation
//

//decodes most control signals based on the opcode 
module main_decoder(
    input logic [6:0] opcode,
    output logic branch,
    output logic [1:0] result_src,
    output logic mem_write, 
    output logic alu_src,
    output logic [2:0] immediate_control,
    output logic reg_write,
    output logic [1:0] alu_op,
    output logic jump,
    output logic pc_target_src,
    output logic u_imm_src
);
    //opcodes
    localparam 
        LW = 7'b0000011,
        SW = 7'b0100011,
        R_TYPE = 7'b0110011,
        I_TYPE_ALU = 7'b0010011,
        B_TYPE = 7'b1100011,
        JAL = 7'b1101111,
        JALR = 7'b1100111,
        LUI = 7'b0110111,
        AUIPC = 7'b0010111;

    logic [13:0] controls;

    //break down of signals from controls 
    assign { 
        branch, 
        jump, 
        result_src, 
        mem_write, 
        alu_src, 
        immediate_control, 
        reg_write, 
        alu_op,
        pc_target_src,
        u_imm_src
    } = controls;

    always_comb begin
        case (opcode)
            LW:         controls = 14'b0_0_01_0_1_000_1_00_x_x; 
            SW:         controls = 14'b0_0_xx_1_1_001_0_00_x_x;
            R_TYPE:     controls = 14'b0_0_00_0_0_xxx_1_10_x_x;
            I_TYPE_ALU: controls = 14'b0_0_00_0_1_000_1_10_x_x; 
            B_TYPE:     controls = 14'b1_0_xx_0_0_010_0_01_0_x;
            JAL:        controls = 14'b0_1_10_0_x_011_1_xx_0_x;
            JALR:       controls = 14'b0_1_10_0_1_000_1_00_1_x;
            LUI:        controls = 14'b0_0_11_0_x_100_1_xx_x_0;
            AUIPC:      controls = 14'b0_0_11_0_x_100_1_xx_x_1;
            default:    controls = 14'bx_x_xx_0_x_xxx_0_xx_x_x;
        endcase
    end
endmodule
