// extend_unit_tb.sv
// James Platt 30130627
//

`timescale 1ns/1ps
module extend_unit_tb();

    //test signals 
    localparam period = 10;
    logic error;
    logic clk = 1;

    //uut signals
    logic [31:0] instruction;
    logic [1:0] control;
    logic [31:0] immediate;
     
    extend_unit uut(
        .src(instruction[31:7]),
        .control(control),
        .extend_src(immediate)
    );

    always begin
        clk = ~clk; #(period/2);
    end

    initial begin

         



    end 
endmodule
