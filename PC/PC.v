module PC(  clock,
            halt,
            immediate,
            branchSignal,
            programCounter,
				jump,
				reset
            );

    // Inputs
    input clock, halt;
	 input [31:0] immediate;
	 input branchSignal, jump, reset;

    // Temporary
    reg [31:0] _temp;
	 reg [31:0] i;
	 reg [31:0] _programCounter;
     reg _halt;

    // Outputs
    output[31:0] programCounter;

    initial 
    begin
      _programCounter = 0;
      _halt = 0;
    end

    always @ (posedge clock)
    begin
        if (reset == 0)
        begin
            _programCounter = 0;
            _halt = 0;
        end

        if (halt == 1 || _halt == 1)
        begin
            _programCounter = _programCounter;
            _halt = 1;
        end
        else
        begin
            _temp = _programCounter + 1'b1;
            i = immediate;
            if (branchSignal == 1 || jump == 1) _programCounter = i;
            else _programCounter = _temp;
        end
    end

    assign programCounter = _programCounter;

endmodule