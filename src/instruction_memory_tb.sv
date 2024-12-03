// instruction_memory_tb.sv
// James Platt 30130627

`timescale 1ns/1ps
module instruction_memory_tb();

    //test signals 
    localparam period = 10;
    localparam number_of_instrs = 71;
    logic [31:0] errors, vectornum;
    logic [31:0] testvectors [10000:0];
    logic [31:0] expected_instruction;

    //uut signals
    logic clk = 0;
    
    logic [31:0] addr;
    logic [31:0] rd_instr;

    instruction_memory uut(
        .addr(addr),
        .rd_instr(rd_instr)
    );

    always begin
        clk = ~clk; #(period / 2);
    end

initial begin

    //wait 100 ms for 
    //holds to come down
    #100;
    
    //test setup
    $readmemh("final_instruction_set.mem", testvectors);
    vectornum = 0; errors = 0;
    
    //there are 71 total instructions in the final instruction set file,
    //so go through all of them and make sure the instruction mem properly
    //reads them.
    for(int i =0; i < number_of_instrs; i++) begin
        //set the address and expected_instruction 
        addr = i * 4;
        expected_instruction = testvectors[i];
        vectornum += 1;
        #(period / 2);
        //now check the data was read correctly 
        if(rd_instr != expected_instruction) begin
            $display("Failed to read data for %d", i);
            errors += 1;
        end
    end
    
     $display("%d tests competed with %d errors", vectornum, errors);
     $stop;
end
endmodule
