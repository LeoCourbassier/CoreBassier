module main(
				clock, sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, sw11, sw12, sw13, sw14, sw15, sw16, sw17, 
				key0, key1, key2, key3,
				hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7);

    // Inputs
    input clock;
    input sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, sw11, sw12, sw13, sw14, sw15, sw16, sw17;
    input key0, key1, key2, key3;

    // Temporary
    wire halt;
    wire [9:0] _programCounter;
	wire [31:0] instructionOut;
	wire [5:0] aluCode;
    wire targetRegister, aluSource;
    wire writeRegister, memoryWrite, memoryRead, memoryToRegister, branch;
    reg[15:0] intermediate;
	reg branchSignal;
	wire aluBranchSignal;
    wire [31:0] dataA, dataB;
    reg [31:0] dataToWrite;
	reg [31:0] aluSource1, aluSource2;
    wire aluError;
    wire [31:0] aluOut;
    wire error, overflow;
    wire [31:0] memoryOut;

    // Outputs
    output [6:0] hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7;

    // Instances
    PC programCounter(.clock(clock), .halt(halt), .intermediate(intermediate), .branchSignal(branchSignal), .programCounter(_programCounter));
    InstructionsMemory instructionsMemory(.read_addr(_programCounter), .clk(clock), .q(instructionOut));
    ControlUnit controlUnit(.clock(clock), .opcode(instructionOut[31:26]), .aluCode(aluCode), .targetRegister(targetRegister), .aluSource(aluSource), 
        .writeRegister(writeRegister), .memoryWrite(memoryWrite), .memoryRead(memoryRead), .memoryToRegister(memoryToRegister), .branch(branch), .halt(halt));
    RegistersBank registersBank(.regC(instructionOut[25:21]), .regB(instructionOut[20:16]), .regA(instructionOut[15:11]), .writeFlag(writeRegister), .clock(clock), .dataA(dataA), .dataB(dataB), .dataWrite(dataToWrite));
    ALU alu(.dataA(aluSource1), .dataB(aluSource2), .opCode(instructionOut[31:26]), .branchSignal(aluBranchSignal), .overflow(overflow), .error(error), .dataC(aluOut));
    DataMemory dataMemory(.data(dataB), .read_addr(aluOut), .write_addr(aluOut), .we(memoryWrite), .clk(clock), .q(memoryOut));
    IO io(.opcode(instructionOut[31:26]), .address(aluOut), .sw0(sw0), .sw1(sw1), .sw2(sw2),
     .sw3(sw3), .sw4(sw4), .sw5(sw5), .sw6(sw6), .sw7(sw7), .sw8(sw8), .sw9(sw9),
      .sw10(sw10), .sw11(sw11), .sw12(sw12), .sw13(sw13), .sw14(sw14), .sw15(sw15), .sw16(sw16),
       .sw17(sw17), .key0(key0), .key1(key1), .key2(key2), .outL(inputOut), .hex0(hex0), 
        .hex1(hex1),  .hex2(hex2),  .hex3(hex3),  .hex4(hex4),  .hex5(hex5),  .hex6(hex6),
         .hex7(hex7));

    always @ (posedge clock)
    begin
        if (!halt)
        begin
            intermediate = instructionOut[15:0];
            branchSignal = aluBranchSignal & branch;

            aluSource1 = dataA;

            /* Mux for ALU input */
            case (aluSource)
                1'b0: aluSource2 = dataB;
                1'b1: aluSource2 = {8'h00000000, intermediate};
            endcase

            /* Mux for writing data to register */
            case (memoryToRegister)
                3'b000: dataToWrite = aluOut;
                3'b001: dataToWrite = memoryOut;
                3'b010: dataToWrite = inputOut;
            endcase
        end
    end
endmodule