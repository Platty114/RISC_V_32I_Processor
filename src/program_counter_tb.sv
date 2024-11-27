// program_counter_tb.sv
// James Platt 30130627
//

`timescale 1ns/1ps
module program_counter_tb();

    localparam period = 10;
    //tb signals
    logic clk = 1'b0, reset, pc_src;
    logic clk_enable;
    logic [31:0] pc, pc_target, pc_plus_4;

    assign clk_enable = clk;

    program_counter uut(
        .pc_target(pc_target),
        .pc_src(pc_src),
        .clk(clk),
        .clk_enable(clk_enable),
        .reset(reset),
        .pc(pc),
        .pc_plus_4(pc_plus_4)
    );

    always begin
        clk = ~clk; #(period / 2);
    end

    initial begin
        
        //GSR
        reset = 1'b1; pc_src = 1'b0;
        #100; 
        
        //check reset state
        if(pc != 32'h0000_0000)begin
            $display(
                "PC: %d, got %d",
                32'h0000_0000,
                pc 
            );
        end
        if(pc_plus_4 != 32'h0000_0004)begin
            $display(
                "PC_PLUS_4: %d, got %d",
                32'h0000_0004,
                pc 
            );
        end
        
        //pass 3 cycles
        reset = 1'b0; #(3*period);

        // check if pc counts correctly
        if(pc != 32'h0000_000C)begin
            $display(
                "PC: %d, got %d",
                32'h0000_000C,
                pc 
            );
        end
        if(pc_plus_4 != 32'h0000_0010)begin
            $display(
                "PC_PLUS_4: %d, got %d",
                32'h0000_0010,
                pc 
            );
        end

        //test pc_target
        pc_src = 1'b1; pc_target = 32'h0000_0170; #(period);

        // check if pc counts correctly
        if(pc != 32'h0000_0170)begin
            $display(
                "PC: %d, got %d",
                32'h0000_0170,
                pc 
            );
        end
        if(pc_plus_4 != 32'h0000_0174)begin
            $display(
                "PC_PLUS_4: %d, got %d",
                32'h0000_0174,
                pc 
            );
        end
        
        //now test if pc continues counting correctly
        pc_src = 1'b0; #(2*period);
        if(pc != 32'h0000_0178)begin
            $display(
                "PC: %d, got %d",
                32'h0000_0178,
                pc 
            );
        end
        if(pc_plus_4 != 32'h0000_017C)begin
            $display(
                "PC_PLUS_4: %d, got %d",
                32'h0000_017C,
                pc 
            );
        end
        
        $stop;

    end
endmodule
