module RegBank(readAddress1, 
               readAddress2, 
               writeAddress, 
               dataWrite, 
               writeMark, 
               clk, 
               data1, 
               data2, 
               hlt, 
               displayAddress, 
               valueAddress);

  input [31:0] dataWrite;
  input [4:0] writeAddress, readAddress1, readAddress2;
  input writeMark, clk, hlt;
  output [31:0] data1, data2;
  output reg[31:0] displayAddress;
  output reg [7:0] valueAddress;

  reg [31:0] RB[31:0];

  always @ (posedge clk) 
  begin
		RB[0] = 32'b0;
		if(writeMark) 
      RB[writeAddress] = dataWrite;

		if(hlt) 
    begin
			valueAddress = RB[readAddress1];
			displayAddress= readAddress1;
		end
		else 
    begin
			valueAddress = 8'b0;
			displayAddress = 32'b0; 
		end
  end
  
  assign data1 = RB[readAddress1];
  assign data2 = RB[readAddress2];
endmodule
