// data_memory_tb.sv
// James Platt 30130627

`timescale 1ns/1ps
module instruction_memory_tb();

    //test signals 
    localparam period = 10;
    logic error;

    //uut signals
    logic clk = 1;
    
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
    //#100;
    
    for(int i =0; i < 32; i++) begin
        addr = i;
        #(period);
        //now check the data was written correctly 
        if(rd_instr != 32'hFFFF_FFFF) begin
            $display("Failed to read data for %d", i);
            error = 1;
            #(period);
            error = 0;
        end
    end
end
endmodule
