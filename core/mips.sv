module mips(
	input clk,
	input rst,
	output[31:0] pc,
	input[31:0] instr,
	output[2:0] aluop,
	output regwrite,
	output[31:0] aluout,
	output regdst,
	output alusrc,
	output[31:0] writedata,
	output mem2reg,
	output memwrite,
	input[31:0] readdata,
	output branch,
	output jump,
	output wire[31:0] srca,srcb,
	output wire[31:0] reg_t1,reg_t2,reg_t3,reg_t4,reg_t5
);
		
	//wire branch;
	//wire jump;
	
	contorller c(
		.instr(instr),
		.op(aluop),
		.regwrite(regwrite),
		.regdst(regdst),
		.alusrc(alusrc),
		.mem2reg(mem2reg),
		.memwrite(memwrite),
		.branch(branch),
		.jump(jump),
	);
	
	datapath dp(
		.clk(clk),
		.rst(rst),
		.pc(pc),
		.instr(instr),
		.op(aluop),
		.regwrite(regwrite),
		.aluout(aluout),
		.regdst(regdst),
		.alusrc(alusrc),
		.writedata(writedata),
		.memwrite(memwrite),
		.mem2reg(mem2reg),
		.readdata(readdata),
		.branch(branch),
		.jump(jump),
		.srca(srca),
		.srcb(srcb),
		.reg_t1(reg_t1),
		.reg_t2(reg_t2),
		.reg_t3(reg_t3),
		.reg_t4(reg_t4),
		.reg_t5(reg_t5)
	);

endmodule