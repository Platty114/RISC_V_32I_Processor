//reg_file.sv 
//James Platt 30130627
//module containing 32 32bit
//registers for RISC-V32I implementation
//Writes occur on rising edge
//

module reg_file(
    input   logic clk,
    input   logic write_enable,
    input   logic [4:0] addr_1,
    input   logic [4:0] addr_2,
    input   logic [4:0] addr_3,
    input   logic [31:0] write_data,
    output  logic [31:0] read_data_1,
    output  logic [31:0] read_data_2
);
    //create a memory cell that is 32 bits x 32 registers
    logic [31:0] registers [31:0];

    //read data is combinational based on addr
    //in the case x0 is read, output should be 0
    assign read_data_1 = (addr_1 != 5'b0000) 
        ? registers[addr_1]
        : 32'h0000_0000;

    assign read_data_2 = (addr_2 != 5'b0000) 
        ? registers[addr_2]
        : 32'h0000_0000;
    

    //write logic
    always_ff @(posedge clk) begin 
        if(write_enable) begin
            registers[addr_3] = write_data;
        end  
    end


endmodule
