module regfile(
	input wire clk,
	input wire we3,
	input wire[4:0] ra1,ra2,wa3,
	input wire[31:0] wd3,
	output wire[31:0] rd1,rd2,
	output wire[31:0] reg_t1,reg_t2,reg_t3,reg_t4,reg_t5
	);
	
	reg [31:0] rf[31:0];
	
	assign reg_t1=rf[2];
	assign reg_t2=rf[3];
	assign reg_t3=rf[4];
	assign reg_t4=rf[5];
	assign reg_t5=rf[7];
	
	always @(posedge clk) begin
		if(we3) begin
			rf[wa3] <=wd3;
		end else begin
			rf[2] <=32'h0000_0005;
			rf[3] <=32'h0000_0003;
		end
	end
	
	assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
	assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule
	