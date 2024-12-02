// reset_buffer.sv
// James Platt
// 30130627
//
//


module reset_buffer(
    input logic clk,
    input logic reset,
    output logic system_reset 
);
    
    logic reset_buffer;

    always_ff @(posedge clk)begin
        reset_buffer <= reset;
        system_reset <= reset_buffer;
    end

endmodule
