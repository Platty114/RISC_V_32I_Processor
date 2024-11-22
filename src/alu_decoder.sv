// alu_decoder.sv
// James Platt 30130627
// partially based on patterson and patterson implementation
//

module alu_decoder(
    input logic [1:0] alu_op,
    input logic [2:0] funct3,
    input logic op5,
    input logic funct7,
    output logic [3:0] alu_control
);

    localparam 
        ADD = 2'b00, 
        SUB = 2'b01, 
        ALU = 2'b10;

    localparam 
        ALU_ADD_SUB = 3'b000,
        ALU_SLL     = 3'b001,
        ALU_SLT     = 3'b010,
        ALU_SLTU    = 3'b011,
        ALU_XOR     = 3'b100,
        ALU_SRL_SRA = 3'b101,
        ALU_OR      = 3'b110,
        ALU_AND     = 3'b111;

    logic [1:0] op5_funct7 = {op5, funct7};

    always_comb begin

        case(alu_op)

            ADD: alu_control = 4'b0000;
            SUB: alu_control = 4'b0001;
            ALU: begin
                
                case(funct3)

                    ALU_ADD_SUB:  alu_control = (op5_funct7 === 2'b11) 
                        ?                       4'b0001 
                        :                       4'b0000;
                    ALU_SLL:      alu_control = 4'b0101;
                    ALU_SLT:      alu_control = 4'b1000;
                    ALU_SLTU:     alu_control = 4'b1001;
                    ALU_XOR:      alu_control = 4'b0010;
                    ALU_SRL_SRA:  alu_control = (funct7 === 1'b0) 
                        ?                       4'b0110
                        :                       4'b0111;
                    ALU_OR:       alu_control = 4'b0011;
                    ALU_AND:      alu_control = 4'b0100;
                    default:      alu_control = 4'bxxxx;

                endcase

            end
            default: alu_control = 4'bxxxx;

        endcase
        
    end


endmodule
