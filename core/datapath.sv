module datapath(
	input clk,
	input rst,
	output reg[31:0] pc,
	input reg[31:0] instr,
	input[2:0] op,
	input regwrite,
	output[31:0] aluout,
	input regdst, 
	input alusrc,
	output wire[31:0] reg_t1,reg_t2,reg_t3,reg_t4,reg_t5
);
	wire[31:0] pcplus4;
	wire[31:0] srca,srcb;
	wire[4:0] writereg;
	wire[31:0] signimm;
	wire[31:0] selb;
	
	
	//PC控制---------------------------
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
	
	//alu（算数逻辑单元）---------------
	alu _alu(
		.a(srca),
		.b(srcb),
		.op(op),
		.y(aluout),
		.overflow(),
		.zero()
	);
	
	//寄存器组-----------------------
	regfile _rf(
		.clk(clk),
		.we3(regwrite),
		.ra1(instr[25:21]),
		.ra2(instr[20:16]),
		.wa3(writereg),
		.wd3(aluout),
		.rd1(srca),
		.rd2(selb),
		.reg_t1(reg_t1),
		.reg_t2(reg_t2),
		.reg_t3(reg_t3),
		.reg_t4(reg_t4),
		.reg_t5(reg_t5)
	);
	
	
	//寄存器写入位置选择
	mux2 #(5) wrmux(
		.d0(instr[20:16]),
		.d1(instr[15:11]),
		.s(regdst),
		.y(writereg)
	);
	
	signext se(
		.a(instr[15:0]),
		.y(signimm)
	);
	
	//srcb数据选择
	mux2 #(32) srcbmux(
		.d0(selb),
		.d1(signimm),
		.s(alusrc),
		.y(srcb)
	);
endmodule