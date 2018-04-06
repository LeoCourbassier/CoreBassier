module InstructionsMemory
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=10)
(
	input [(ADDR_WIDTH-1):0] read_addr,
	input clk,
	output reg [(DATA_WIDTH-1):0] q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	always @ (posedge clk)
	begin
		q <= ram[read_addr];
	end
endmodule
