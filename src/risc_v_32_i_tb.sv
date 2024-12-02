// risc_v_32_i_tb.sv
// James Platt 30130627
// based on Harrison and Harrison testbench

`timescale 1ns/1ps
module risc_v_32_i_tb();
    logic clk; 
    logic reset; 
    logic [31:0] WriteData, DataAdr; 
    logic [31:0] address_100; // unused in test
    logic MemWrite; // instantiate device to be tested 
    risc_v_32_i dut(
        .clk(clk), 
        .reset(reset), 
        .value_from_alu(DataAdr), 
        .data_to_write(WriteData), 
        .writting_to_mem(MemWrite),
        .address_100(address_100)
    ); // initialize test 

    initial begin 
        #100;
        reset <= 1; #30; reset <= 0; 
    end // generate clock to sequence tests 

    always begin 
        clk <= 1; #20; clk <= 0; #20; 
    end // check results 
    

    always @(negedge clk) begin 
        if(MemWrite) begin 
            if(DataAdr === 100 & WriteData === 25) begin 
                $display("Simulation succeeded"); 
                $stop;
            end 
        end 
    end 
endmodule
