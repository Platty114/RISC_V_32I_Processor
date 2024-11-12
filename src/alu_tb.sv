// alu_tb.sv
// James Platt 30130627
//


`timescale 1ps/1ns
module alu_tb();

    //test signals 
    localparam period = 10;
    logic error;

    logic clk = 1;

    logic [3:0] alu_control;
    logic [31:0] A;
    logic [31:0] B;
    logic [31:0] result;
    logic equal;
    logic less_than;
    logic less_than_unsigned;

    alu uut(
        .alu_control(alu_control),
        .A(A),
        .B(B),
        .result(result),
        .equal(equal),
        .less_than(less_than),
        .less_than_unsigned(less_than_unsigned)
    );


    always begin
        clk = ~clk; #(period / 2);
    end

    initial begin
       
        

    end
endmodule
