// reg_file_tb.sv 
// James Platt 30130627
//
//

`timescale 1ns/1ps
module reg_file_tb();

    //test signals 
    localparam period = 10;
    logic error;
    logic check_write_section;
    logic check_write_disable_section;

    //uut signals
    logic clk = 1;
    logic clk_enable_n;
    logic write_enable;
    logic [4:0] addr_1;
    logic [4:0] addr_2;
    logic [4:0] addr_3;
    logic [31:0] write_data;
    logic [31:0] read_data_1;
    logic [31:0] read_data_2;

    assign clk_enable_n = ~clk;
    
    reg_file uut(
        .clk(clk),
        .clk_enable_n(clk_enable_n),
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

        //initialize testbench
        error = 1'b0;

        //initialize state
        addr_1 = 32'h0000_0000;
        addr_2 = 32'h0000_0000;
        addr_3 = 32'h0000_0000;

        //now check if they all were written correctly
        begin : check_write
            
            //start test section
            check_write_section = 1'b1;
            
            //start write
            write_data = 32'hFFFF_FFFF;
            write_enable = 1'b1;

            //write all 1's to all 32 registers
            for(int i =0; i < 32; i++) begin
                addr_3 = i;
                #(period);
            end

            //disable writes
            write_enable = 1'b0;
            addr_1 = 32'h0000_0000;
            addr_2 = 32'h0000_0000;
            #(period)

            //check that r0 is always 0
            if(read_data_1 != 32'h0000_0000) begin
                $display("Data incorecctly read from r0!");
                error = 1;
                #(period);
                error = 0;
            end

            if(read_data_2 != 32'h0000_0000) begin
                $display("Data incorecctly read from r0!");
                error = 1;
                #(period);
                error = 0;
            end

            //check all other registers were writen to correctly
            for(int i =1; i < 32; i++) begin
                addr_1 = i;
                addr_2 = i;
                #(period);

                if(read_data_1 != 32'hFFFF_FFFF) begin
                    $display("Data incorecctly written to r%d on read_data_1!", i);
                    error = 1;
                    #(period);
                    error = 0;
                end

                if(read_data_2 != 32'hFFFF_FFFF) begin
                    $display("Data incorecctly written to r%d on read_data_2!", i);
                    error = 1;
                    #(period);
                    error = 0;
                end
            end

            //finsih
            check_write_section = 1'b0;
            
        end

        //check that write_enable = 0, means register can't be written to
        //but can still be read from
        begin : check_write_disable

            //start section
            check_write_disable_section = 1'b1;
            
            //start write
            write_data = 32'h0000_0000;
            write_enable = 1'b0;

            //write all 1's to all 32 registers
            for(int i =0; i < 32; i++) begin
                addr_3 = i;
                #(period);
            end

            //disable writes
            addr_1 = 32'h0000_0000;
            addr_2 = 32'h0000_0000;
            #(period)

            //check that r0 is always 0
            if(read_data_1 != 32'h0000_0000) begin
                $display("Data incorecctly read from r0! access 0");
                error = 1;
                #(period);
                error = 0;
            end

            if(read_data_2 != 32'h0000_0000) begin
                $display("Data incorecctly read from r0! access 1");
                error = 1;
                #(period);
                error = 0;
            end

            //check all other registers were not written to
            for(int i =1; i < 32; i++) begin
                addr_1 = i;
                addr_2 = i;
                #(period);

                if(read_data_1 != 32'hFFFF_FFFF) begin
                    $display("Data incorecctly written to r%d on read_data_1!", i);
                    error = 1;
                    #(period);
                    error = 0;
                end

                if(read_data_2 != 32'hFFFF_FFFF) begin
                    $display("Data incorecctly written to r%d on read_data_2!", i);
                    error = 1;
                    #(period);
                    error = 0;
                end
            end
            
            //finsih
            check_write_disable_section = 1'b0;
        end


        $stop;
        
    end
endmodule
