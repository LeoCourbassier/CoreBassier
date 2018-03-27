module ALU(opCode, dataA, dataB, zero, overflow, error, dataC);

	// Inputs
	input [31:0] dataA;
	input [31:0] dataB;
	input [4:0] opCode;

	// Temporary
	reg [63:0] _temp;
	
	// Outputs
	output reg zero, overflow;
	output reg error;
	output reg [31:0] dataC;

	always @ (opCode or dataA or dataB)
	begin
		 error = 0;
		 case(opCode[4:0])
			  // Add, Addi
			  5'b00000, 5'b00001:
			  begin
					_temp = {8'h00000000,dataA} + {8'h00000000,dataB};
					overflow = (dataC < 8'hFFFFFFFF) ? 0 : 1;
					dataC = _temp;
			  end
			  
			  // Sub, Subi
			  5'b00010, 5'b00011:
			  begin
					dataC = dataA - dataB;
			  end

			  // Mult, Multi
			  5'b00100, 5'b00101:
			  begin
					_temp = {8'h00000000,dataA} * {8'h00000000,dataB};
					overflow = (_temp < 8'hFFFFFFFF) ? 0 : 1;
					dataC = _temp;
			  end

			  // Div, divi
			  5'b00110, 5'b00111:
			  begin
					// Div by zero error
					error = (dataB == 0) ? 1 : 0;        
					if (error == 0) dataC = dataA / dataB;
					else dataC = 0;
			  end

			  // Mod
			  5'b01000: dataC = dataA % dataB;

			  // SetLessThan, SetLessThanImediate
			  5'b01001, 5'b01010: dataC = (dataA < dataB);

			  // And, Andi
			  5'b01011, 5'b01100: dataC = dataA & dataB;

			  // Or, Ori
			  5'b01101, 5'b01110: dataC = dataA | dataB;

			  // Not
			  5'b01111: dataC = ~dataA;

			  // Shift Right
			  5'b10000: dataC = dataA >> dataB;

			  // Shift Left
			  5'b10001: dataC = dataA << dataB;
			  
			  // SetGreaterThan, SetGreaterThanImediate
			  5'b10010, 5'b10011: dataC = (dataA > dataB);
			  
			  // SetEQuals
			  5'b10100: dataC = (dataA == dataB);
		 endcase
		 zero = (dataC == 0);
		 error = (overflow == 1) ? 1 : 0;
	end
endmodule
