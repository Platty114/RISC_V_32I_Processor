// top_tb.sv
// James Platt
// 30130627


//This test bench is just used to run the final_instruction_set.mem assembly file
//So that the waveform can be viewed easily. A proper testbench for how the processor
//exectutes that program is available in risc_v_32_i_tb.sv
module top_tb();

    logic clk_100;
    logic reset;
    logic CA, CB, CC, CD, CE, CF, CG, DP;
    logic [7:0] AN;

    top uut(
      .clk_100(clk_100),
      .reset(reset),
      .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG), .DP(DP),
      .AN(AN)
    );



    always begin
        clk_100 <= 1'b1; #5; clk_100 <= 1'b0; #5;
    end


    initial begin
        //reset
        reset = 1'b1; #2000;
        //allow program to run long enough to show every instruction until the infinite loop
        reset = 1'b0; #3000;
        //done
        $stop; 
    end




endmodule
