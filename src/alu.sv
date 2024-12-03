// alu.sv
// James Platt 30130627
// defines a standard 32 bit ALU with the following abilities
// add, sub, xor, or, and, sll, srl, sra, slt, sltu
// 
// provides flags for when A == B, A < B, and A < B unsigned

module alu(
    input logic [3:0]   alu_control,
    input logic         alu_src, // used to tell if B is an immediate for sll, srl
    input logic [31:0]  A,       // and sra
    input logic [31:0]  B,
    output logic [31:0] result,
    output logic        equal,
    output logic        less_than,
    output logic        less_than_unsigned
);

    //calculate all possible values, then chose correct one
    logic [31:0] 
        addition, 
        subtraction,
        logical_xor,
        logical_or,
        logical_and,
        logical_sll,
        logical_srl,
        arithmetic_sra,
        logical_slt,
        logical_sltu;

    assign addition = A + B;
    assign subtraction = A - B;
    assign logical_xor = A ^ B;
    assign logical_or = A | B;
    assign logical_and = A & B;
    assign logical_sll = (alu_src == 1'b0) 
        ? A << B 
        : A << B[4:0]; //handle edge case for slli as immediate is only 4 -> 0
    assign logical_srl = (alu_src == 1'b0) 
        ? A >> B
        : A >> B[4:0]; //handle edge case for srli as immediate is only 4 -> 0
    assign arithmetic_sra = (alu_src == 1'b0) 
        ? $signed(A) >>> B
        : $signed(A) >>> B[4:0]; //handle edge case for srai as immediate is only 4 -> 0
    assign logical_slt = $signed(A) < $signed(B) ? 32'h0000_0001 : 32'h0000_0000;
    assign logical_sltu = A < B ? 32'h0000_0001 : 32'h0000_0000;
    assign equal = subtraction == 0 ? 1'b1 : 1'b0;
    assign less_than = logical_slt == 0 ?  1'b0 : 1'b1;
    assign less_than_unsigned = logical_sltu == 0 ? 1'b0 : 1'b1;



    always_comb begin 
        case (alu_control)
            4'b0000: result = addition;
            4'b0001: result = subtraction;
            4'b0010: result = logical_xor;
            4'b0011: result = logical_or;
            4'b0100: result = logical_and;
            4'b0101: result = logical_sll;
            4'b0110: result = logical_srl;
            4'b0111: result = arithmetic_sra;
            4'b1000: result = logical_slt;
            4'b1001: result = logical_sltu;
            default: result = 32'h0000_0000;
        endcase
    end
    


endmodule
