module contorller(
	input[31:0] instr,
	output[2:0] op,
	output regwrite
	);
	
	reg[3:0] controls;
	
	assign {op,regwrite} = controls;
	
	always @(*) begin
		case(instr[31:26])
			6'b000000:begin //R型指令
					case(instr[5:0])
						6'b100000: begin controls <= 4'b000_1; end
						6'b100100: begin controls <= 4'b100_1; end //and
						6'b100101: begin controls <= 4'b010_1; end //or
						6'b100010: begin controls <= 4'b011_1; end //sub
						6'b101010: begin controls <= 4'b111_1; end //slt
						default: begin controls <= 4'b000_0; end
					endcase 
				end
			
			default: begin controls <= 4'b000_0; end
		endcase
	end
	
endmodule