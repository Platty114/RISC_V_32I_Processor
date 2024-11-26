// clk_divider_tb.sv
// James Platt 30130627
//

`timescale 1ns/1ps
module clk_divider_tb();

    //test signals 
    localparam period = 10;
    logic error;
    logic clk = 0;
    logic reset;

    //uut signals
    logic clk_enable;
    logic clk_enable_n;
     
    clk_divider uut(
        .clk(clk),
        .reset(reset),
        .clk_enable(clk_enable),
        .clk_enable_n(clk_enable_n)
    );

    always begin
        clk = ~clk; #(period/2);
    end

    initial begin

        #100;

        //initialize
        
        //put clk divider into reset for a period
        reset = 1'b1; #(period);
        //now wait 4 periods (clk_enable should be high);
        reset = 1'b0; #(4 * period);

        //now wait another 4 periods (clk_enable should be low)
        reset = 1'b0; #(4 * period);

        //repeat
        //now wait 4 periods (clk_enable should be high);
        reset = 1'b0; #(4 * period);

        //now wait another 4 periods (clk_enable should be low)
        reset = 1'b0; #(4 * period);

        $stop;

    end 
endmodule
