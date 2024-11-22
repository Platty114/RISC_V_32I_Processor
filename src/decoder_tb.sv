// decoder_tb.sv
// James Platt 30130627
//

`timescale 1ns/1ps
module decoder_tb();

    //test signals 
    localparam period = 10;
    logic [31:0] vectornum, errors;
    logic [46:0] testvectors [10000:0];
    logic [11:0] expected_result;
    logic [11:0] result;
    logic clk = 1;
    logic reset;

    //uut signals
    logic [31:0] instruction;
    logic [1:0] result_src;
    logic [3:0] alu_control;
    logic [1:0] immediate_control;
    logic 
        equal, //input
        less_than, //input
        less_than_unsigned, //input
        pc_src,
        mem_write,
        alu_src,
        reg_write;

     
    decoder uut(
        .instruction(instruction),
        .equal(equal),
        .less_than(less_than),
        .less_than_unsigned(less_than_unsigned),
        .pc_src(pc_src),
        .result_src(result_src),
        .mem_write(mem_write), 
        .alu_control(alu_control),
        .alu_src(alu_src),
        .immediate_control(immediate_control),
        .reg_write(reg_write)
    );

    always begin
        clk = ~clk; #(period/2);
    end

    assign result = { 
        pc_src, 
        result_src, 
        mem_write, 
        alu_control,
        alu_src,
        immediate_control,
        reg_write
    };
     
    initial begin
        
        //test setup
        $readmemb("decoder_tb_cases.mem", testvectors);
        vectornum = 0; errors = 0;
        #100;
        reset = 1; #period; reset = 0;
        

    end


    always @(posedge clk) begin
        #1; {
            instruction, 
            equal, 
            less_than,
            less_than_unsigned,
            expected_result
        } = testvectors[vectornum];
        if(testvectors[vectornum] === 47'bx) begin
            $display("%d tests competed with %d errors", vectornum, errors);
            $stop;
        end
    end

    always @(negedge clk) begin
        if(~reset) begin
            if(result !== expected_result) begin
                $display(
                   "Incorrect decoder result"
                );
                $display(
                    "Expected: %b, got %b",
                    expected_result,
                    result
                );
                errors = errors + 1;
            end

            vectornum = vectornum + 1;
        end 
    end 
endmodule
