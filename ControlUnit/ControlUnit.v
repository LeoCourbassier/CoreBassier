module ControlUnit(clock,
                   opcode,
                   aluCode,
                   targetRegister,
                   aluSource,
                   writeRegister,
                   memoryWrite,
                   memoryRead,
                   memoryToRegister,
                   branch,
                   halt);
    
    // Inputs
    input clock;
    input [5:0] opcode;
    // Wait for in | out
	 
    // Temporary
    reg _halt;

    // Outputs
    output reg[5:0] aluCode;
    output reg targetRegister, aluSource, writeRegister, memoryWrite, memoryRead;
    output reg[2:0] memoryToRegister;
    output reg branch;
	 output halt;
	 
	 initial begin
		_halt = 0;
	 end

    always @ (negedge clock)
    begin
        if (!_halt)
        begin
            case (opcode)
                // Add
                6'b000000,
                // Sub
                6'b000010,
                // Mult
                6'b000100,
                // Div
                6'b000110,
                // Mod
                6'b001000,
                // SetLesserThan
                6'b001001,
                // And
                6'b001011,
                // Or
                6'b001101,
                // Not
                6'b001111,
                // Shift Right
                6'b010000,
                // Shift Left
                6'b010001,
                // SetGreaterThan
                6'b010010:
                begin
                    aluCode = opcode;
                    targetRegister = 1;
                    aluSource = 0;
                    writeRegister = 1;
                    memoryWrite = 0;
                    memoryRead = 0;
                    memoryToRegister = 0;
                    branch = 0;
                    _halt = 0;
                end

                // Addi
                6'b000001,
                // Subi
                6'b000011,
                // Multi
                6'b000101,
                // Divi
                6'b000111,
                // SetLesserThanImediate
                6'b001010,
                // Andi
                6'b001100,
                // Ori
                6'b001110,
                // SetGreaterThanImediate
                6'b010011:
                begin
                    aluCode = opcode;
                    targetRegister = 1;
                    aluSource = 1;
                    writeRegister = 1;
                    memoryWrite = 0;
                    memoryRead = 0;
                    memoryToRegister = 0;
                    branch = 0;
                    _halt = 0;
                end

                // Load, Store
                6'b010100, 6'b010101:
                begin
                    aluCode = 6'b000000;
                    targetRegister = 0;
                    aluSource = 1;
                    writeRegister = opcode == 6'b010100 ? 1 : 0;
                    memoryWrite = opcode == 6'b010100 ? 0 : 1;
                    memoryRead = opcode == 6'b010100 ? 1 : 0;
                    memoryToRegister = 1;
                    branch = 0;
                    _halt = 0;
                end

                // Jump
                6'b010110:
                begin
                    aluCode = opcode;
                    targetRegister = 0;
                    aluSource = 0;
                    writeRegister = 0;
                    memoryWrite = 0;
                    memoryRead = 0;
                    memoryToRegister = 0;
                    branch = 1;
                    _halt = 0;
                end

                // Branch on (NOT) Equal
                6'b010111, 6'b011000:
                begin
                    aluCode = opcode;
                    targetRegister = 0;
                    aluSource = 0;
                    writeRegister = 0;
                    memoryWrite = 0;
                    memoryRead = 0;
                    memoryToRegister = 0;
                    branch = 1;
                    _halt = 0;
                end

                // Nop
                6'b011001:
                begin
                    aluCode = opcode;
                    targetRegister = 0;
                    aluSource = 0;
                    writeRegister = 0;
                    memoryWrite = 0;
                    memoryRead = 0;
                    memoryToRegister = 0;
                    _halt = 0;
                    branch = 0;
                end

                // _halt
                6'b011010:
                begin
                    aluCode = opcode;
                    targetRegister = 0;
                    aluSource = 0;
                    writeRegister = 0;
                    memoryWrite = 0;
                    memoryRead = 0;
                    memoryToRegister = 0;
                    _halt = 1;
                    branch = 0;
                end

                // In
                6'b011011:
                begin 
                    aluCode = opcode;
                    targetRegister = 0;
                    aluSource = 0;
                    writeRegister = 1;
                    memoryWrite = 0;
                    memoryRead = 0;
                    memoryToRegister = 2'b10;
                    _halt = 0;
                    branch = 0;
                end

                // Out
                6'b011100:
                begin
                    aluCode = opcode;
                    targetRegister = 0;
                    aluSource = 0;
                    writeRegister = 0;
                    memoryWrite = 0;
                    memoryRead = 0;
                    memoryToRegister = 0;
                    _halt = 0;
                    branch = 0;
                end

                // Mov
                6'b011101:
                begin
                    aluCode = opcode;
                    targetRegister = 0;
                    aluSource = 0;
                    writeRegister = 1;
                    memoryWrite = 0;
                    memoryRead = 0;
                    memoryToRegister = 0;
                    _halt = 0;
                    branch = 0;
                end
            endcase
        end
    end

    assign halt = _halt;
    // Wrong case or beq
endmodule