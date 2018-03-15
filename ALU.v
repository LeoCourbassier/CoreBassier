module ALU(opCode, dataA, dataB, zero, overflow, error, dataC);

	// Inputs
	input [31:0] dataA;
	input [31:0] dataB;
	input [4:0] opCode;

	// Outputs
	output reg zero, overflow;
	output reg error;
	output reg[31:0] dataC;

	always @ (opCode or dataA or dataB)
	begin
		 case(opCode[4:0])
			  // Add, Addi
			  5'b00000, 5'b00001:
			  begin
					dataC = dataA + dataB;
					overflow = (dataA + dataB < 8'hFFFFFFFF) ? 0 : 1;
			  end
			  
			  // Sub, Subi
			  // TODO: underflow
			  5'b00010, 5'b00011: dataC = dataA - dataB;

			  // Mult, Multi
			  5'b00100, 5'b00101:
			  begin
					dataC = dataA * dataB;
					overflow = (dataA * dataB < 8'hFFFFFFFF) ? 0 : 1;
					// Discard greater value
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

			  // Slt, Slti
			  5'b01001, 5'b01010: dataC = (dataA < dataB) ? 1 : 0;

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
		 endcase
		 zero = (dataC == 0);
	end
endmodule
