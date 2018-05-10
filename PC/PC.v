module PC(  clock,
            halt,
            intermediate,
            branchSignal,
            programCounter
            );

    // Inputs
    input clock, halt, intermediate, branchSignal;

    // Temporary
    reg [9:0]_temp, i, _programCounter;

    // Outputs
    output[9:0] programCounter;

    initial begin
      _programCounter = 0;
    end

    always @ (posedge clock)
    begin
        if (halt) _programCounter = _programCounter;
        else
        begin
            _temp = _programCounter + 1'b1;
            i = _temp + intermediate;
            if (branchSignal == 0) _programCounter = _temp;
            else _programCounter = i;
        end
    end

    assign programCounter = _programCounter;

endmodule