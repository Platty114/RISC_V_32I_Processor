// load_store_decoder.sv
// James Platt
// 30130627
//
// 

//using the funct7 field, 
//decodes wether a word, halfword
//or byte should be loaded / stored
module load_store_decoder(
    input logic [2:0] funct3,
    output logic [2:0] mem_width 
);

    localparam 
        SIGNED_B  = 3'b000,
        SIGNED_H  = 3'b001,
        SIGNED_W  = 3'b010,
        USIGNED_B = 3'b100,
        USIGNED_H = 3'b101;


    always_comb begin

        case(funct3)

            SIGNED_B:   mem_width = 3'b000; 
            SIGNED_H:   mem_width = 3'b001; 
            SIGNED_W:   mem_width = 3'b010; 
            USIGNED_B:  mem_width = 3'b100; 
            USIGNED_H:  mem_width = 3'b101; 
            default:    mem_width = 3'b010; // default to 010 as it is the most
                                            // effcient op.
        endcase
        
    end



endmodule
