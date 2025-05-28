// if_stage_tb.sv
// James Platt 30130627
//

module if_stage_tb();

    //test signals
    localparam period = 10;
    localparam number_of_instrs = 71;
    logic [31:0] errors, vectornum;
    logic [31:0] testvectors [10000:0];
    logic [31:0] expected_instruction;

    //uut signals
    logic clk = 0;
    logic reset, pc_src, stall_if;
    logic [31:0] pc_target;
    logic [31:0] pc;
    logic [31:0] pc_plus_4;
    logic [31:0] rd_instr;

    if_stage uut(
	.clk(clk),
	.reset(reset),
	.pc_src(pc_src),
	.stall_if(stall_if),
	.pc_target(pc_target),
	.pc(pc),
	.pc_plus_4(pc_plus_4),
	.rd_instr(rd_instr)
    );

    always begin
	clk = ~clk; #(period /2);
    end

    initial begin

	//wait 100 ms for holds to come down
	#100;

	//test setup
	$readmemh("final_instruction_set.mem", testvectors);
	vectornum = 0; errors = 0;

	//setup uut
	reset = 1'b1;
	pc_src = 1'b0;
	stall_if = 1'b0;
	#(period / 2);

	//there are 71 total instructions in the final instruction set file,
	//so go through all of them and make sure the instruction mem properly
	//reads them.
	for(int i =0; i < number_of_instrs; i++) begin
	    //set the address and expected_instruction 
	    expected_instruction = testvectors[i];
	    vectornum += 1;
	    #(period / 2);
	    //now check the data was read correctly 
	    if(rd_instr != expected_instruction) begin
		$display("Failed to read data for %d", i);
		errors += 1;
	    end

	    //now check if stalling the register works
	    //by stalling for 3 periods
	    stall_if = 1'b1;
	    #(3 * period/2);

	    //check if the same instruction is still being fetched
	    if(rd_instr != expected_instruction) begin
		$display("Failed to read data for %d", i);
		errors += 1;
	    end
	end
	
	 $display("%d tests competed with %d errors", vectornum, errors);
	 $stop;


    end
endmodule
