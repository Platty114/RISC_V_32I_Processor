// main_decoder.sv
// James Platt 30130627
// Based on Patterson and Patterson implementation
//


module main_decoder(
    input logic [6:0] opcode,
    output logic branch,
    output logic [1:0] result_src,
    output logic mem_write, 
    output logic alu_src,
    output logic [1:0] immediate_control,
    output logic reg_write,
    output logic [1:0] alu_op,
    output logic jump
);
    localparam 
        LW = 7'b0000011,
        SW = 7'b0100011,
        R_TYPE = 7'b0110011,
        I_TYPE_ALU = 7'b0010011,
        BEQ = 7'b1100011,
        JAL = 7'b1101111;

    logic [10:0] controls;


    assign { 
        branch, 
        jump, 
        result_src, 
        mem_write, 
        alu_src, 
        immediate_control, 
        reg_write, 
        alu_op 
    } = controls;

    always_comb begin

        case (opcode)
            LW:         controls = 11'b0_0_01_0_1_00_1_00; 
            SW:         controls = 11'b0_0_xx_1_1_01_0_00;
            R_TYPE:     controls = 11'b0_0_00_0_0_xx_1_10;
            I_TYPE_ALU: controls = 11'b0_0_00_0_1_00_1_10; 
            BEQ:        controls = 11'b1_0_xx_0_0_10_0_01;
            JAL:        controls = 11'b0_1_10_0_x_11_1_xx;
            default:    controls = 11'bx_x_xx_x_x_xx_x_xx;
        endcase
        
    end



endmodule