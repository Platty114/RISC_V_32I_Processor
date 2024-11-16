// extend_unit.sv
// James Platt 30130627


module extend_unit(
    input logic [31:7] src,
    input logic [1:0] control,
    output logic [31:0] extended_src
);

  
  always_comb begin

      case(control)
           
          2'b00: extended_src = {{21{src[31]}}, src[30:20]}; // I type
          2'b01: extended_src = {{21{src[31]}}, src[30:25], src[11:7]}; // S type
          2'b10: extended_src = {{20{src[31]}}, src[7], src[30:25], src[11:8], 1'b0}; // B type
          2'b11: extended_src = {{12{src[31]}}, src[19:12], src[20], src[30:21], 1'b0}; // J type 
          default: extended_src = 32'bx;
      endcase

  end



endmodule
