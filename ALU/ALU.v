module ALU(opCode, dataA, dataB, branchSignal, overflow, error, dataC);

	// Inputs
	input [31:0] dataA;
	input [31:0] dataB;
	input [4:0] opCode;

	// Temporary
	reg [63:0] _temp;
	
	// Outputs
	output reg branchSignal, overflow;
	output reg error;
	output reg [31:0] dataC;

	always @ (opCode or dataA or dataB)
	begin
		 error = 0;
		 branchSignal = 1;
		 case(opCode[5:0])
			  // Add, Addi
			  6'b000000, 6'b000001:
			  begin
					_temp = {8'h00000000,dataA} + {8'h00000000,dataB};
					overflow = (_temp < 8'hFFFFFFFF) ? 0 : 1;
					dataC = _temp;
			  end
			  
			  // Sub, Subi
			  6'b000010, 6'b000011:
			  begin
					dataC = dataA - dataB;
			  end

			  // Mult, Multi
			  6'b000100, 6'b000101:
			  begin
					_temp = {8'h00000000,dataA} * {8'h00000000,dataB};
					overflow = (_temp < 8'hFFFFFFFF) ? 0 : 1;
					dataC = _temp;
			  end

			  // Div, divi
			  6'b000110, 6'b000111:
			  begin
					// Div by zero error
					error = (dataB == 0) ? 1 : 0;        
					if (error == 0) dataC = dataA / dataB;
					else dataC = 0;
			  end

			  // Mod
			  6'b001000: dataC = dataA % dataB;

			  // SetLesserThan, SetLesserThanImediate
			  6'b001001, 6'b001010: dataC = (dataA < dataB);

			  // And, Andi
			  6'b001011, 6'b001100: dataC = dataA & dataB;

			  // Or, Ori
			  6'b001101, 6'b001110: dataC = dataA | dataB;

			  // Not
			  6'b001111: dataC = ~dataA;

			  // Shift Right
			  6'b010000: dataC = dataA >> dataB;

			  // Shift Left
			  6'b010001: dataC = dataA << dataB;
			  
			  // SetGreaterThan, SetGreaterThanImediate
			  6'b010010, 6'b010011: dataC = (dataA > dataB);

			  // Branch on Equal
			  6'b010111: branchSignal = (dataB == dataA);

			  // Branch on Not Equal
			  6'b011000: branchSignal = (dataB != dataA);

			  // Out
              6'b01110: dataC = dataA;

			  default: 
			  begin
					branchSignal = 1;
				  	dataC = dataB;
			  end
		 endcase
		 //branchSignal = (dataC == 0);
		 error = (overflow == 1) ? 1 : 0;
	end
endmodule
