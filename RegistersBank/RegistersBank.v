module RegistersBank(regA, 
               regB, 
               regC, 
               dataWrite, 
               writeFlag, 
               clock, 
               dataA, 
               dataB);

  input [31:0] dataWrite;
  input [4:0] regC, regA, regB;
  input writeFlag, clock;
  output [31:0] dataA, dataB;

  reg [31:0] registers[31:0];

  initial begin
    registers[0] = 32'b0;
  end

  always @ ( posedge clock ) 
  begin
		if(writeFlag) 
      registers[regC] = dataWrite;
  end
  
  assign dataA = registers[regA];
  assign dataB = registers[regB];
endmodule
