module controlUnit(clock,
                   opcode,
                   aluCode,
                   targetRegister,
                   aluSource,
                   writeRegister,
                   memoryWrite,
                   memoryRead,
                   memoryToRegister,
                   branch,
                   halt)
    
    // Inputs
    input clock;
    input reg[5:0] opcode;
    // Wait for in | out

    // Outputs
    output reg[5:0] aluCode;
    output targetRegister, aluSource, writeRegister, memoryWrite, memoryRead, 
    memoryToRegister, branch, halt;

    always @ (clock)
    begin
        case (opcode[5:0])
            // Add, Addi
            6'b000000, 6'b000001,
            // Sub, Subi
            6'b000010, 6'b000011,
            // Mult, Multi
            6'b000100, 6'b000101,
            // Div, divi
            6'b000110, 6'b000111,
            // Mod
            6'b001000,
            // SetLesserThan, SetLesserThanImediate
            6'b001001, 6'b001010,
            // And, Andi
            6'b001011, 6'b001100,
            // Or, Ori
            6'b001101, 6'b001110,
            // Not
            6'b001111,
            // Shift Right
            6'b010000,
            // Shift Left
            6'b010001,
            // SetGreaterThan, SetGreaterThanImediate
            6'b010010, 6'b010011
            :
            begin
                aluCode = opcode;
                targetRegister = 1;
                aluSource = 0;
                writeRegister = 1;
                memoryWrite = 0;
                memoryRead = 0;
                memoryToRegister = 0;
                branch = 0;
                halt = 0;
            end

            // Load, Store
            6'b010100, 6'b010101:
            begin
                aluCode = 6'b000000;
                targetRegister = 0;
                aluSource = 1;
                writeRegister = opcode[5:0] == 6'b010100 ? 1 : 0;
                memoryWrite = opcode[5:0] == 6'b010100 ? 0 : 1;
                memoryRead = opcode[5:0] == 6'b010100 ? 1 : 0;
                memoryToRegister = 1;
                branch = 0;
                halt = 0;
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
                halt = 0;
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
                halt = 0;
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
                halt = 0;
                branch = 0;
            end

            // Halt
            6'b011010:
            begin
                aluCode = opcode;
                targetRegister = 0;
                aluSource = 0;
                writeRegister = 0;
                memoryWrite = 0;
                memoryRead = 0;
                memoryToRegister = 0;
                halt = 1;
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
                memoryToRegister = 2;
                halt = 0;
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
                halt = 0;
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
                halt = 0;
                branch = 0;
            end
        endcase
    end
end module