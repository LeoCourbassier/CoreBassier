module FrequencyDivider(
    clock,
    clockOut
);

    // Input
    input clock;

	reg [3:0] i;
	 
    // Output
    output reg clockOut;

    always @ ( posedge clock )
    begin
		  if (i == 4'b1111)
		  begin 
				clockOut = ~clockOut;
				i = 4'b00;
		  end
		  i = i + 1'b1;
    end
endmodule