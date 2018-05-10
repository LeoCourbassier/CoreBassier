module InstructionsMemory
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=10)
(
	input [(ADDR_WIDTH-1):0] read_addr,
	input clk,
	output reg [(DATA_WIDTH-1):0] q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	initial begin
		// Addi reg[0x1], reg[0x0] + 0x5
		ram[0] = 32'b00000100001000000000000000000101;
		// Addi reg[0x1], reg[0x1] + 0x1
		ram[1] = 32'b00000100001000010000000000000001;
		// Addi reg[0x1], reg[0x1] + 0x1
		ram[2] = 32'b00000100001000010000000000000001;
		// Addi reg[0x1], reg[0x1] + 0x1
		ram[3] = 32'b00000100001000010000000000000001;
		// Out
		ram[4] = 32'b01110000000000000000000000000000;
		// Halt
		ram[5] = 32'b01101000000000000000000000000000;
	end

	always @ (posedge clk)
	begin
		q <= ram[read_addr];
	end
endmodule
