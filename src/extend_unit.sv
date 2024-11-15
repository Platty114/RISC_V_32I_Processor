// extend_unit.sv
// James Platt 30130627


module extend_unit(
    input logic [24:0] src,
    input logic [1:0] control,
    output logic [31:0] extended_src
);

  
  always_comb begin

      case(control)
          
          2'b00: extended_src = {{20{src[24]}}, src[24:13]}; // I type
          2'b01: extended_src = {{20{src[24]}}, src[24:18], src[4:0]}; // S type
          2'b10: extended_src = {{20{src[24]}}, src[0], src[23:18], src[4:1], 1'b0}; // B type
          2'b11: extended_src = {{12{src[24]}}, src[12:5], src[13], src[23:14], 1'b0}; // J type
          default: extended_src = 32'bx;

      endcase

  end



endmodule
