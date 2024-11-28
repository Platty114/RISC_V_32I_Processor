// branch_decoder.sv
// James Platt 
// 30130627
//

//takes equality signals from the alu, 
//and determines if it is correct to branch
//based on funct3
module branch_decoder(
    input logic equal,
    input logic less_than,
    input logic less_than_unsigned,
    input logic [2:0] funct3,
    output logic branch_correct
);

    localparam 
        BEQ = 3'b000,
        BNE = 3'b001,
        BLT = 3'b100,
        BGE = 3'b101,
        BLTU = 3'b110,
        BGEU = 3'b111;

    always_comb begin

        case(funct3) 

            BEQ: branch_correct = (equal == 1'b1) 
                ? 1'b1 
                : 1'b0;
            BNE: branch_correct = (equal == 1'b0) 
                ? 1'b1 
                : 1'b0;
            BLT: branch_correct = (less_than == 1'b1) 
                ? 1'b1 
                : 1'b0; 
            BGE: branch_correct = (less_than == 1'b0) 
                ? 1'b1 
                : 1'b0; 
            BLTU: branch_correct = (less_than_unsigned == 1'b1) 
                ? 1'b1 
                : 1'b0; 
            BGEU: branch_correct = (less_than_unsigned == 1'b0) 
                ? 1'b1 
                : 1'b0; 

            default: branch_correct = 1'b0;

        endcase
        
    end 

endmodule
