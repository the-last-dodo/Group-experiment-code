module mips(
	input clk,
	input rst,
	output[31:0] pc,
	input[31:0] instr,
	output[2:0] aluop,
	output regwrite,
	output[31:0] aluout,
	output wire[31:0] reg_t1,reg_t2,reg_t3,reg_t4,reg_t5
);
		
	contorller c(
		.instr(instr),
		.op(aluop),
		.regwrite(regwrite)
	);
	
	datapath dp(
		.clk(clk),
		.rst(rst),
		.pc(pc),
		.instr(instr),
		.op(aluop),
		.regwrite(regwrite),
		.aluout(aluout),
		.reg_t1(reg_t1),
		.reg_t2(reg_t2),
		.reg_t3(reg_t3),
		.reg_t4(reg_t4),
		.reg_t5(reg_t5)
	);

endmodule