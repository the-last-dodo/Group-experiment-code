module project2(
	input clk,
	input rst,
	input  wren,
	output[31:0] pc,
	output[31:0] instr,
	output[2:0] aluop,
	output regwrite,
	output[31:0] aluout,
	output regdst,
	output alusrc,
	output[31:0] writedata,
	output memwrite,
	output mem2reg,
	output[31:0] readdata,
	output[11:0] q,
	output branch,
	output jump,
	output wire[31:0] srca,srcb,
	output[31:0] reg_t1,reg_t2,reg_t3,reg_t4,reg_t5
);
	
	mips _mips(
		.clk(clk),
		.rst(rst),
		.pc(pc),
		.instr(instr),
		.aluop(aluop),
		.regwrite(regwrite),
		.aluout(aluout),
		.regdst(regdst),
		.alusrc(alusrc),
		.writedata(writedata),
		.mem2reg(mem2reg),
		.memwrite(memwrite),
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

	irom_4096_32 (
	.address(pc[13:2]),
	.clock(clk),
	.q(instr));

	assign q=aluout[11:0];
    iram_4096_32 ram (
        .address(aluout[11:0]),
        .clock(!clk),
        .data(writedata),
        .wren(memwrite),
        .q(readdata)
    );
	
	



endmodule