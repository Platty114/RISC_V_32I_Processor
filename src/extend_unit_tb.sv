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
    logic [2:0] control;
    logic [31:0] immediate;
     
    extend_unit uut(
        .src(instruction[31:7]),
        .control(control),
        .extended_src(immediate)
    );

    always begin
        clk = ~clk; #(period/2);
    end

    initial begin

        #100;

        //initialize
        instruction = 32'h0000_0000;
        control = 3'b000;
        #(period);
         
        //addi x1, x0, 6, I Type
        //32'b00000000011000000000000010010011
        instruction = 32'b00000000011000000000000010010011;
        control = 3'b000;
        #(period);

        if(immediate != 6) begin
            $display("Incorrect immediate for I type, value 6");
            error = 1'b1;
            #(period);
            error = 1'b0;
        end 

        //addi x1, x0, -6, I Type
        //32'b11111111101000000000000010010011
        instruction = 32'b11111111101000000000000010010011;
        control = 3'b000;
        #(period);

        if(immediate != -6) begin
            $display("Incorrect immediate for I type, value -6");
            error = 1'b1;
            #(period);
            error = 1'b0;
        end 
         
        //sw x1, 6(x2), S Type
        //32'b00000000001000001010001100100011
        instruction = 32'b00000000001000001010001100100011;
        control = 3'b001;
        #(period);

        if(immediate != 6) begin
            $display("Incorrect immediate for S type, value 6");
            error = 1'b1;
            #(period);
            error = 1'b0;
        end

        //sw x1, -6(x2), S Type
        //32'b00001100001000001010001100100011
        instruction = 32'b11111110001000001010110100100011;
        control = 3'b001;
        #(period);

        if(immediate != -6) begin
            $display("Incorrect immediate for S type, value -6");
            error = 1'b1;
            #(period);
            error = 1'b0;
        end

        //beq x1, x2, 4, B Type
        //32'b00000000001000001000001001100011
        instruction = 32'b00000000001000001000001001100011;
        control = 3'b010;
        #(period);

        if(immediate != 4) begin
            $display("Incorrect immediate for B type, value 4");
            error = 1'b1;
            #(period);
            error = 1'b0;
        end

        //beq x1, x2, -4, B Type
        //32'b11111000001000001000001001100011
        instruction = 32'b11111110001000001000111011100011;
        control = 3'b010;
        #(period);

        if(immediate != -4) begin
            $display("Incorrect immediate for B type, value -4");
            error = 1'b1;
            #(period);
            error = 1'b0;
        end

        //jal x9, 26, J Type
        instruction = 32'b00000001101000000000010011101111;
        control = 3'b011;
        #(period);

        if(immediate != 26) begin
            $display("Incorrect immediate for J type, value 25");
            error = 1'b1;
            #(period);
            error = 1'b0;
        end

        //jal x9, -8, J Type
        instruction = 32'b11111111100111111111010011101111;
        control = 3'b011;
        #(period);

        if(immediate != -8) begin
            $display("Incorrect immediate for J type, value -8");
            error = 1'b1;
            #(period);
            error = 1'b0;
        end

        //lui x1, 26
        instruction = 32'b00000001101000000000010011101111;
        control = 3'b100;
        #(period);

        if(immediate != 32'b00000001101000000000000000000000) begin
            $display("Incorrect immediate for U type, value 3328");
            error = 1'b1;
            #(period);
            error = 1'b0;
        end
        $stop;

        //lui x1, 26
        instruction = 32'b11111111111111111000010011101111;
        control = 3'b100;
        #(period);

        if(immediate != 32'b11111111111111111000000000000000) begin
            $display("Incorrect immediate for U type, value 3328");
            error = 1'b1;
            #(period);
            error = 1'b0;
        end
        $stop;

    end 
endmodule
