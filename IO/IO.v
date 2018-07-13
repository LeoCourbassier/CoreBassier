/*
 * A note to the reader: UNLESS you're using 'out' targeting the ldc display, 
 * you must know that targeting:
 * - 0x0: prints a 4 bit (signed) integer, using the adjacents displays;
 * - 0x4: prints a 2 (unsigned) integer;
 * - 0x6: prints a 2 (unsigned) integer;
 * BUT, if you target:
 * - 0x1, 0x2, 0x3, 0x5, 0x6: prints an 1 bit (unsigned) integer;
 */
module IO(
				address,
				data,
				opcode,
				hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7,
				reset,
				sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, sw11, sw12, sw13, sw14, sw15, sw16, sw17,
				key1, key2, key3,
				outL,
				makeIO
         );
    // Inputs
    input [4:0] address;
	input [31:0] data;
    input [5:0] opcode;
	input sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9, sw10, sw11, sw12, sw13, sw14, sw15, sw16, sw17;
    input key1, key2, key3;
	input reset;
	input makeIO;

    // Temporary
    reg [31:0] _temp;
    reg negative;
    reg [3:0] hundred, ten, unit;
    reg [7:0] outHundreds, outTens, outUnits;
    integer i;

    // Outputs
	reg [6:0] _hex0, _hex1, _hex2, _hex3, _hex4, _hex5, _hex6, _hex7;
    output reg [6:0] hex0;
	output [6:0] hex1, hex2, hex3, hex4, hex5, hex6, hex7;
	output [31:0] outL;
	 
    always @ ( makeIO or reset )
    begin
	   if (reset == 0)
		begin
			_hex0 = 7'b0000001;
			_hex1 = 7'b0000001;
			_hex2 = 7'b0000001;
			_hex3 = 7'b0000001;
			_hex4 = 7'b0000001;
			_hex5 = 7'b0000001;
			_hex6 = 7'b0000001;
			_hex7 = 7'b0000001;
		end
		else
		begin
		
		case (opcode)
			 // Out
          6'b011100:
          begin
				i = 7;
				// Convert numbers to BCD before using
				/* Max 8 bits */
				if (data[12]) 
				begin
				  negative = 1;
				  _temp = ~data + 1;
				end
				else 
				begin
				  negative = 0;
				  _temp = data;
				end
				hundred = 0;
				ten = 0;
				unit = 0;

				for (i = 12; i >= 0; i = i - 1) 
				begin
				  if (hundred > 4)
					 hundred = hundred + 3;
				  if (ten > 4)
					 ten = ten + 3;
				  if (unit > 4)
					 unit = unit + 3;

				  hundred = hundred << 1;
				  hundred[0] = ten[3];
				  ten = ten << 1;
				  ten[0] = unit[3];
				  unit = unit << 1;
				  unit[0] = _temp[i];
				end

				case (hundred)
					 4'b0000: outHundreds = 7'b0000001;
					 4'b0001: outHundreds = 7'b1001111;
					 4'b0010: outHundreds = 7'b0010010;
					 4'b0011: outHundreds = 7'b0000110;
					 4'b0100: outHundreds = 7'b1001100;
					 4'b0101: outHundreds = 7'b0100100;
					 4'b0110: outHundreds = 7'b0100000;
					 4'b0111: outHundreds = 7'b0001111;
					 4'b1000: outHundreds = 7'b0000000;
					 4'b1001: outHundreds = 7'b0001100;
					 default: outHundreds = 7'b1111111;
				endcase

				case (ten)
					 4'b0000: outTens = 7'b0000001;
					 4'b0001: outTens = 7'b1001111;
					 4'b0010: outTens = 7'b0010010;
					 4'b0011: outTens = 7'b0000110;
					 4'b0100: outTens = 7'b1001100;
					 4'b0101: outTens = 7'b0100100;
					 4'b0110: outTens = 7'b0100000;
					 4'b0111: outTens = 7'b0001111;
					 4'b1000: outTens = 7'b0000000;
					 4'b1001: outTens = 7'b0001100;
					 default: outTens = 7'b1111111;
				endcase

				case (unit)
					 4'b0000: outUnits = 7'b0000001;
					 4'b0001: outUnits = 7'b1001111;
					 4'b0010: outUnits = 7'b0010010;
					 4'b0011: outUnits = 7'b0000110;
					 4'b0100: outUnits = 7'b1001100;
					 4'b0101: outUnits = 7'b0100100;
					 4'b0110: outUnits = 7'b0100000;
					 4'b0111: outUnits = 7'b0001111;
					 4'b1000: outUnits = 7'b0000000;
					 4'b1001: outUnits = 7'b0001100;
					 default: outUnits = 7'b1111111;
				endcase
				
				case (address)
				 // Targeting seven segments display
				 5'b00000: 
				 begin
					hex0 = outUnits;
					_hex1 = outTens;
					_hex2 = outHundreds;
				 end
				 5'b00001: _hex1 = outUnits;
				 5'b00010: _hex2 = outUnits;
				 5'b00011: _hex3 = outUnits;
				 5'b00100:
				 begin
					_hex4 = outUnits;
					_hex5 = outTens;
				 end
				 5'b00101: _hex5 = outUnits;
				 5'b00110:
				 begin
					_hex6 = outUnits;
					_hex7 = outTens;
				 end
				 5'b00111: _hex7 = outUnits;
			  endcase  
			end
			 // In
          6'b011011:
          begin
            case (address)
              5'b00000, 
              5'b00001, 
              5'b00010, 
              5'b00011, 
              5'b00100, 
              5'b00101, 
              5'b00110, 
              5'b00111, 
              5'b01000, 
              5'b01001, 
              5'b01010, 
              5'b01011, 
              5'b01100, 
              5'b01101, 
              5'b01110, 
              5'b01111, 
              5'b10000, 
              5'b10001: 
              begin
                _temp[31:0] = { {15{sw17}}, sw16, sw15, sw14, sw13, sw12, sw11, sw10, sw9, sw8, sw7, sw6, sw5, sw4, sw3, sw2, sw1, sw0 };
              end
              5'b10011: _temp = key1;
              5'b10100: _temp = key2;
              5'b10101: _temp = key3;
            endcase
          end
		endcase
		end	
end
assign outL = _temp;
//assign hex0 = _hex0;
assign hex1 = _hex1;
assign hex2 = _hex2;
assign hex3 = _hex3;
assign hex4 = _hex4;
assign hex5 = _hex5;
assign hex6 = _hex6;
assign hex7 = _hex7;

endmodule