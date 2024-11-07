//James Platt 30130627
//Generic memory module used 
//instruction memory
//adapted from patterson and patterson
//textbook


module instruction_memory
(
  input logic [31:0] addr,
  output logic [31:0] rd_instr
);

  //create a memory cell that is rows x word_size
  logic [31:0] RAM [63:0];
  
  //initialize memory based on file
  initial begin
    $readmemh("instruction_mem.mem", RAM); 
  end

  //output word alligned instruction
  assign rd_instr = RAM[addr[31:2]];

endmodule
