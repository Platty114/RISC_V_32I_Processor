// data_memory_tb.sv
// James Platt 30130627

`timescale 1ns/1ps
module data_memory_tb();

    //test signals 
    localparam period =10;
    logic error;

    //uut signals
    logic clk = 0;
    logic write_enable;
    logic [31:0] addr;
    logic [31:0] write_data;
    logic [31:0] read_data;
    logic [2:0] mem_width;

    data_memory uut(
        .clk(clk),
        .write_enable(write_enable),
        .mem_width(mem_width),
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
    
    for(int i =0; i < 200 ; i = i + 4) begin
        
        //write F0F0_F0F0 into address 0000_0000
        write_enable = 1; 
        mem_width = 3'b010;
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

        //read word, byte, halfword, and unisgned byte / halfword from address  
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

        //set mem_width to signed byte
        mem_width = 3'b000;
        #(period);

        //now check the data loaded correctly 
        if(read_data != 32'hFFFF_FFF0) begin
            $display("Failed to read byte for %d", i);
            error = 1;
            #(period);
            error = 0;
        end

        //set mem_width to signed halfword
        mem_width = 3'b001;
        #(period);

        //now check the data loaded correctly 
        if(read_data != 32'hFFFF_F0F0) begin
            $display("Failed to read halfword for %d", i);
            error = 1;
            #(period);
            error = 0;
        end

        //set mem_width to unsigned byte 
        mem_width = 3'b100;
        #(period);

        //now check the data loaded correctly 
        if(read_data != 32'h0000_00F0) begin
            $display("Failed to read u byte for %d", i);
            error = 1;
            #(period);
            error = 0;
        end

        //set mem_width to unsigned halfword
        mem_width = 3'b101;
        #(period);

        //now check the data loaded correctly 
        if(read_data != 32'h0000_F0F0) begin
            $display("Failed to read u halfword for %d", i);
            error = 1;
            #(period);
            error = 0;
        end
        
        //write 0F0F_0F0F into address 0000_0000
        write_enable = 1;
        mem_width = 3'b010;
        addr = i;
        write_data = 32'h0F0F_0F0F;
        #(period);
        write_enable = 0;

        //now check the data was written correctly 
        if(read_data != 32'h0F0F_0F0F) begin
            $display("Failed to write data second time for %d", i);
            error = 1;
            #(period);
            error = 0;
        end

        //set mem_width to signed byte
        mem_width = 3'b000;
        #(period);

        //now check the data loaded correctly 
        if(read_data != 32'h0000_000F) begin
            $display("Failed to read byte for %d", i);
            error = 1;
            #(period);
            error = 0;
        end

        //set mem_width to signed halfword
        mem_width = 3'b001;
        #(period);

        //now check the data loaded correctly 
        if(read_data != 32'h0000_0F0F) begin
            $display("Failed to read halfword for %d", i);
            error = 1;
            #(period);
            error = 0;
        end

        //set mem_width to unsigned byte 
        mem_width = 3'b100;
        #(period);

        //now check the data loaded correctly 
        if(read_data != 32'h0000_000F) begin
            $display("Failed to read u byte for %d", i);
            error = 1;
            #(period);
            error = 0;
        end

        //set mem_width to unsigned halfword
        mem_width = 3'b101;
        #(period);

        //now check the data loaded correctly 
        if(read_data != 32'h0000_0F0F) begin
            $display("Failed to read u halfword for %d", i);
            error = 1;
            #(period);
            error = 0;
        end
        
        //TESTING BYTE AND HAFWORD WRITES
        
        //write 0x0000_0000 into address 
        write_enable = 1;
        mem_width = 3'b010;
        addr = i;
        write_data = 32'h0000_0000;
        #(period);

        //now check the data was written correctly 
        if(read_data != 32'h0000_0000) begin
            $display("Failed to all 0 to address %d", i);
            error = 1;
            #(period);
            error = 0;
        end

        //write 0x89 into address at [0]
        write_enable = 1;
        mem_width = 3'b000;
        addr = i;
        write_data = 32'h0000_0089;
        #(period);

        //write 0x76 into address at [1]
        write_enable = 1;
        mem_width = 3'b000;
        addr = i + 1;
        write_data = 32'h0000_0067;
        #(period);

        //write 0x56 into address at [2]
        write_enable = 1;
        mem_width = 3'b000;
        addr = i + 2;
        write_data = 32'h0000_0045;
        #(period);

        //write 0x56 into address at [2]
        write_enable = 1;
        mem_width = 3'b000;
        addr = i + 3;
        write_data = 32'h0000_0023;
        #(period);

        //now check if word is correct
        write_enable = 0;
        mem_width = 3'b010;
        addr = i;
        #(period);

        //now check the data was written correctly 
        if(read_data != 32'h2345_6789) begin
            $display("Failed to write bytes to address %d", i);
            error = 1;
            #(period);
            error = 0;
        end
        
        
    end
    
    $stop;
end
endmodule
