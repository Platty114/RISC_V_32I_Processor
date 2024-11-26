// clk_divider.sv
// James Platt
// 30130627
//
//


//this module will produce both a clk enable signal and 
//a negative clk enable. These will correspond to a 25Mhz clock,
//where clk_enable = 1 on rising edge, and clk_enable_n = 1 on falling 
//edge
module clk_divider(
    input logic clk,
    input logic reset,
    output logic clk_enable,
    output logic clk_enable_n
);

    logic [1:0] count;

    always_ff @(posedge clk) begin

        if(reset) begin
            count <= 2'b11; 
        end
        else begin
            count <= count + 1;
        end
        
    end


    assign clk_enable = (count == 0) ? 1'b1 : 1'b0;
    assign clk_enable_n = (count == 2) ? 1'b1 : 1'b0;

endmodule
