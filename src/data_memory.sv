// data_memory.sv
// James Platt
// module for data memory 
// in RISC-V32I implementation
// (32 x 4 B) = 128 B of data memory
//

module data_memory(
    input   logic clk,
    input   logic write_enable,
    input   logic [31:0] addr,
    input   logic [31:0] write_data,
    output  logic [31:0] read_data
);
    //create a memory cell that is 32 bits x 32 registers
    logic [31:0] data [31:0];

    //read data is combinational based on addr
    //data is read no matter what, even on write
    assign read_data = data[addr];
    
    //write logic
    always_ff @(posedge clk) begin 
        if(write_enable) begin
            data[addr] = write_data;
        end  
    end
endmodule;
