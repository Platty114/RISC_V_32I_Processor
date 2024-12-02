// top_tb.sv
// James Platt
// 30130627

module top_tb();

    logic clk_100;
    logic reset;
    logic display_switch;
    logic CA, CB, CC, CD, CE, CF, CG, DP;
    logic [7:0] AN;
    logic [15:0] LED;

    top uut(
      .clk_100(clk_100),
      .reset(reset),
      .display_switch(display_switch),
      .CA(CA), .CB(CB), .CC(CC), .CD(CD), .CE(CE), .CF(CF), .CG(CG), .DP(DP),
      .AN(AN),
      .LED(LED)
    );



    always begin
        clk_100 <= 1'b1; #5; clk_100 <= 1'b0; #5;
    end


    initial begin
        reset = 1'b1; display_switch = 1'b0; #2000;
        
        

        reset = 1'b0; #3000;
        $stop; 
    end




endmodule
