// data_memory_tb.sv
// James Platt 30130627

`timescale 1ns/1ps
module data_memory_tb();

    //test signals 
    localparam period = 10;
    logic error;

    //uut signals
    logic clk = 1;
    logic write_enable;
    logic [31:0] addr;
    logic [31:0] write_data;
    logic [31:0] read_data;

    data_memory uut(
        .clk(clk),
        .write_enable(write_enable),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    always begin
        clk = ~clk; #(period / 2);
    end

initial begin

    //wait 100 ms for 
    //holds to come down
    //#100;
    
    for(int i =0; i < 32; i++) begin
        
        //write F0F0_F0F0 into address 0000_0000
        write_enable = 1; 
        addr = i;
        write_data = 32'hF0F0_F0F0;
        #(period);

        //now check the data was written correctly 
        if(read_data != 32'hF0F0_F0F0) begin
            $display("Failed to write data for %d", i);
            error = 1;
            #(period);
            error = 0;
        end


        //read from address 0000_0000 
        write_enable = 0; 
        addr = i;
        write_data = 32'h0F0F_0F0F;
        #(period);

        //now check the data was written correctly 
        if(read_data != 32'hF0F0_F0F0) begin
            $display("Failed to write data for %d", i);
            error = 1;
            #(period);
            error = 0;
        end
        
        //write 0F0F_0F0F into address 0000_0000
        write_enable = 1; 
        addr = i;
        write_data = 32'h0F0F_0F0F;
        #(period);

        //now check the data was written correctly 
        if(read_data != 32'h0F0F_0F0F) begin
            $display("Failed to write data second time for %d", i);
            error = 1;
            #(period);
            error = 0;
        end
    end
end
endmodule
