// top.sv
// James Platt 30130627

module top(
    input logic clk_100,
    input logic reset,
    output logic CA, CB, CC, CD, CE, CF, CG, DP,
    output logic [7:0] AN
);

    logic [31:0] value_from_alu;
    logic [31:0] data_to_write;
    logic [31:0] value_to_display;
    logic writting_to_mem;
    logic reset_in;
    logic clk;
    logic locked;
    
    reset_buffer RESET_BUFFER(
        .clk(clk),
        .reset(reset),
        .system_reset(reset_in)
    ); 
    
    //used to divide the 100Mhz clock into a 25Mhz clock
    //on the nexus 4
    clk_wiz_0 CLK_GENERATOR(
        .clk_100(clk_100),
        .reset(1'b0),
        .locked(locked),
        .clk(clk)
    );
     

    //risc-v processer
    risc_v_32_i PROCESSOR(
        .clk(clk),
        .reset(reset_in),
        .value_from_alu(value_from_alu),
        .data_to_write(data_to_write),
        .writting_to_mem(writting_to_mem),
        .address_100(value_to_display)
    );

    //display 1, modified for nexsys 4 board
    seven_segment_display_subsystem DISPLAY_1(
        .clk(clk),
        .reset(reset_in),
        .number(value_to_display),
        .CA(CA),
        .CB(CB),
        .CC(CC),
        .CD(CD),
        .CE(CE),
        .CF(CF),
        .CG(CG),
        .DP(DP),
        .AN1(AN[0]),
        .AN2(AN[1]),
        .AN3(AN[2]),
        .AN4(AN[3]),
        .AN5(AN[4]),
        .AN6(AN[5]),
        .AN7(AN[6]),
        .AN8(AN[7])
    );

endmodule
