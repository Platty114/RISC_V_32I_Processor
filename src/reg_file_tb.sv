// reg_file_tb.sv 
// James Platt 30130627
//
//

`timescale 1ns/1ps
module reg_file_tb();

    //test signals 
    localparam period = 10;
    logic error;

    //uut signals
    logic clk = 1;
    logic write_enable;
    logic [4:0] addr_1;
    logic [4:0] addr_2;
    logic [4:0] addr_3;
    logic [31:0] write_data;
    logic [31:0] read_data_1;
    logic [31:0] read_data_2;
    
    reg_file uut(
        .clk(clk),
        .write_enable(write_enable),
        .addr_1(addr_1),
        .addr_2(addr_2),
        .addr_3(addr_3),
        .write_data(write_data),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    ); 

    always begin
        clk = ~clk; #(period / 2);
    end

  initial begin
    
  end
endmodule
