// alu_tb.sv
// James Platt 30130627
//


`timescale 1ns/1ps
module alu_tb();

    //test signals 
    localparam period = 10;
    logic [31:0] vectornum, errors;
    logic [99:0] testvectors [10000:0];
    logic [31:0] expected_result;
    logic clk = 1;
    logic reset;

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
        
        //test setup
        $readmemh("alu_tb_cases.mem", testvectors);
        vectornum = 0; errors = 0;
        reset = 1; #period; reset = 0;
        

    end


    always @(posedge clk) begin
        #1; {A, B, alu_control, expected_result} = testvectors[vectornum];
        if(testvectors[vectornum] === 100'bx) begin
            $display("%d tests competed with %d errors", vectornum, errors);
            $stop;
        end
    end

    always @(negedge clk) begin
        if(~reset) begin
            if(result !== expected_result) begin
                $display(
                   "Incorrect alu result, A = %d, B = %d, alu_control = %d",
                   A,
                   B,
                   alu_control
                );
                $display(
                    "Expected: %d, got %d",
                    expected_result,
                    result
                );
                errors = errors + 1;
            end



            vectornum = vectornum + 1;
        end 
    end
endmodule
















