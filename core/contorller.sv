module contorller(
	input[31:0] instr,
	output[2:0] op,
	output regwrite,
	output regdst,
	output alusrc,
	output mem2reg,
	output memwrite,
	output branch,
	output jump
	);
	
	reg[9:0] controls;
	
	assign {op,regwrite,regdst,alusrc,memwrite,mem2reg,branch,jump} = controls;
	
	always @(*) begin
		case(instr[31:26])
			6'b000000:begin //R型指令
					case(instr[5:0])
						6'b100000: begin controls <= 10'b000_1_1_0_0_0_0_0; end //add
						6'b100100: begin controls <= 10'b100_1_1_0_0_0_0_0; end //and
						6'b100101: begin controls <= 10'b010_1_1_0_0_0_0_0; end //or
						6'b100010: begin controls <= 10'b011_1_1_0_0_0_0_0; end //sub
						6'b101010: begin controls <= 10'b111_1_1_0_0_0_0_0; end //slt
						default: begin controls <= 10'b000_0_0_0_0_0_0; end
					endcase 
				end
			6'b001000:begin controls <= 10'b000_1_0_1_0_0_0_0; end		//addi
			6'b100011:begin controls <= 10'b000_1_0_1_0_1_0_0; end		//lw
			6'b101011:begin controls <= 10'b000_0_0_1_1_0_0_0; end		//sw
			6'b000100:begin controls <= 10'b011_0_0_0_0_0_1_0; end		//beq
			6'b000010:begin controls <= 10'b000_0_0_0_1_0_0_1; end		//jump

			
			default: begin controls <= 10'b000_0_0_0_0_0_0_0; end
		endcase
	end
	
endmodule