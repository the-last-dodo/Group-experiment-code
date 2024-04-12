module alu(
	input[31:0] a,b,
	input[2:0] op,
	output reg[31:0] y,
	output reg overflow,
	output zero
	);
	
	always @ (*) begin
		case(op)
			3'b000: begin 
					y = a + b;
				end
			3'b011: begin
					y = a - b;
				end
			3'b100: begin 
					y = a & b;
				end
			3'b010: begin 
					y = a | b;
				end
			3'b111: begin 
					if (a < b) 
					y = 1; 
					else
					y = 0; 
				end
			//3'b000: 
			default: begin y<=32'b0; overflow <= 1'b0; end
		endcase
	end
	
	assign zero = (y == 32'b0);
	
endmodule