/*
 * A note to the reader: UNLESS you're using 'out' targeting the ldc display, 
 * use the 'out' instruction only for numbers of ONE digit.
 * If you'd like to show a number with more digits, use one 'out' per digit.
 */
module IO(
        address,
        data,
				opcode,
				sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, sw11, sw12, sw13, sw14, sw15, sw16, sw17,
				key0, key1, key2, key3,
				lcdOut,
				hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7,
				outL
         );
    // Inputs
    input [4:0] address;
	  input [31:0] data;
    input [5:0] opcode;
    input sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, sw11, sw12, sw13, sw14, sw15, sw16, sw17;
    input key0, key1, key2, key3;

    // Temporary
    reg [31:0] _temp;

    // Outputs
    output [31:0] lcdOut;
    output reg [6:0] hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7;
    output [31:0] outL;
	 
    always @ (address or opcode)
    begin
      case (opcode)
          // In
          6'b011011:
          begin
            case (address)
              5'b00000: _temp = sw0;
              5'b00001: _temp = sw1;
              5'b00010: _temp = sw2;
              5'b00011: _temp = sw3;
              5'b00100: _temp = sw4;
              5'b00101: _temp = sw5;
              5'b00110: _temp = sw6;
              5'b00111: _temp = sw7;
              5'b01000: _temp = sw8;
              5'b01001: _temp = sw9;
              5'b01010: _temp = sw10;
              5'b01011: _temp = sw11;
              5'b01100: _temp = sw12;
              5'b01101: _temp = sw13;
              5'b01110: _temp = sw14;
              5'b01111: _temp = sw15;
              5'b10000: _temp = sw16;
              5'b10001: _temp = sw17;
              5'b10010: _temp = key0;
              5'b10011: _temp = key1;
              5'b10100: _temp = key2;
              5'b10101: _temp = key3;
            endcase
          end
          // Out
          6'b011100:
          begin
              if (address != 5'b01000)
              begin
                  // Convert numbers to BCD before using
                  case (data)
                      4'b0000: _temp = 7'b0000001;
                      4'b0001: _temp = 7'b1001111;
                      4'b0010: _temp = 7'b0010010;
                      4'b0011: _temp = 7'b0000110;
                      4'b0100: _temp = 7'b1001100;
                      4'b0101: _temp = 7'b0100100;
                      4'b0110: _temp = 7'b0100000;
                      4'b0111: _temp = 7'b0001111;
                      4'b1000: _temp = 7'b0000000;
                      4'b1001: _temp = 7'b0001100;
                      default: _temp = 7'b1111111;
                  endcase
              end
              case (address)
                // Targeting seven segments display
                5'b00000: hex0 = _temp;
                5'b00001: hex1 = _temp;
                5'b00010: hex2 = _temp;
                5'b00011: hex3 = _temp;
                5'b00100: hex4 = _temp;
                5'b00101: hex5 = _temp;
                5'b00110: hex6 = _temp;
                5'b00111: hex7 = _temp;

                /* Targeting lcd display */
                /* First line */
                5'b01000: 
                begin
                  // LCD logic goes here
                  //lcdOut = data;
                end
                /* Second line */
                5'b01001:
                begin
                  //lcdOut = data;
                end
              endcase          
          end
      endcase
	end
  assign outL = _temp;

endmodule