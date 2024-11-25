

module top(
    input logic clk,
    input logic reset,
    output logic CA, CB, CC, CD, CE, CF, CG, DP,
    output logic [7:0] AN,
    output logic [15:0] LED
);

    logic [31:0] value_from_alu;
    logic [31:0] data_to_write;
    logic writting_to_mem;
    logic reset_buffer, reset_in;
    
    always_ff @(posedge clk)begin
        reset_buffer <= reset;
        reset_in <= reset_buffer;
    end

    //risc-v processer
    risc_v_32_i PROCESSOR(
        .clk(clk),
        .reset(reset_in),
        .value_from_alu(value_from_alu),
        .data_to_write(data_to_write),
        .writting_to_mem(writting_to_mem)
    );
    
    assign LED = value_from_alu[15:0];

    //display 1
    seven_segment_display_subsystem DISPLAY_1(
        .clk(clk),
        .reset(reset_in),
        .sec_dig1(value_from_alu[3:0]),
        .sec_dig2(value_from_alu[7:4]),
        .min_dig1(value_from_alu[11:8]),
        .min_dig2(value_from_alu[15:12]),
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
        .AN4(AN[3])
    );

endmodule
