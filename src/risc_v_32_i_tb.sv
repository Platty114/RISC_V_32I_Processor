// risc_v_32_i_tb.sv
// James Platt 30130627
// based on Harrison and Harrison testbench

`timescale 1ns/1ps
module risc_v_32_i_tb();


    logic clk_40;
    logic clk; 
    logic clk_enable, clk_enable_n;
    logic reset; 
    logic [31:0] WriteData, DataAdr; 
    logic MemWrite; // instantiate device to be tested 
    risc_v_32_i dut(
        .clk(clk), 
        .clk_enable(clk_enable),
        .clk_enable_n(clk_enable_n),
        .reset(reset), 
        .value_from_alu(DataAdr), 
        .data_to_write(WriteData), 
        .writting_to_mem(MemWrite)
    ); // initialize test 

    initial begin 
        #100;
        reset <= 1; #40; reset <= 0; 
    end // generate clock to sequence tests 

    always begin 
        clk <= 1; #5; clk <= 0; #5; 
    end // check results 
    
    always begin
        clk_enable <= 1; #10; clk_enable <= 0; #30;
    end
    
    always begin
        clk_enable_n <= 0; #20; clk_enable_n <= 1; #10; clk_enable_n <= 0; #10;
    end
    
    always begin
        clk_40 <= 1; #20; clk_40 <=0; #20;
    end
    

    always @(negedge clk_40) begin 
        if(MemWrite) begin 
            if(DataAdr === 100 & WriteData === 25) begin 
                $display("Simulation succeeded"); 
                $stop;
            end 
            else if (DataAdr !== 96) begin 
                $display("Simulation failed"); 
                $stop; 
            end 
        end 
    end 
endmodule
