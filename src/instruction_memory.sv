//James Platt 30130627
//Generic memory module used 
//instruction memory
//adapted from patterson and patterson
//textbook


module instruction_memory
#(
  //number of words
  parameter rows = 64, 
  //size of words in b
  parameter word_size = 32 
)
(
  input logic [word_size-1:0] addr,
  output logic [word_size-1:0] rd_instr
);

  //create a memory cell that is rows x word_size
  logic [word_size-1:0] RAM [rows-1:0];
  
  //initialize memory based on file
  initial begin
    $readmemh("instruction_mem.txt", RAM); 
  end

  //output word alligned instruction
  assign rd_instr = RAM[addr[word_size-1:2]];

endmodule
