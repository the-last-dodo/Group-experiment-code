module datapath(
	input clk,
	input rst,
	output reg[31:0] pc,
	input reg[31:0] instr,
	input[2:0] op,
	input regwrite,
	output[31:0] aluout,
	output wire[31:0] reg_t1,reg_t2,reg_t3,reg_t4,reg_t5
);
	/*always @(negedge clk, posedge rst) begin
		if(rst)begin
			pc <=32'h0000_0000;
			end
		else begin
			if(pc == 32'h0000_0010) begin
				pc <=32'h0000_0000;
			end
			else begin
				pc <= pc + 32'h0000_0004;
			end
		end
	end*/
	wire[31:0] pcplus4;
	wire[31:0] srca,srcb;
	
	flopr #(32) pcreg(
		.clk(clk),
		.rst(rst),
		.d(pcplus4),
		.q(pc)
	);
	
	adder pcadd1(
		.a(pc),
		.b(32'h000_0004),
		.y(pcplus4)
	);
	
	alu _alu(
		.a(srca),
		.b(srcb),
		.op(op),
		.y(aluout),
		.overflow(),
		.zero()
	);
	
	regfile _rf(
		.clk(clk),
		.we3(regwrite),
		.ra1(instr[25:21]),
		.ra2(instr[20:16]),
		.wa3(instr[15:11]),
		.wd3(aluout),
		.rd1(srca),
		.rd2(srcb),
		.reg_t1(reg_t1),
		.reg_t2(reg_t2),
		.reg_t3(reg_t3),
		.reg_t4(reg_t4),
		.reg_t5(reg_t5)
	);

endmodule