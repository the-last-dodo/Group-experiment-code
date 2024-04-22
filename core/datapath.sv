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
	output[31:0] writedata,
	input memwrite,
	input mem2reg,
	input[31:0] readdata,
	input branch,
	input jump,
	output wire[31:0] srca,srcb,
	output wire[31:0] reg_t1,reg_t2,reg_t3,reg_t4,reg_t5
);
	wire[31:0] pcplus4;
	wire[4:0] writereg;
	wire[31:0] signimm;
	wire[31:0] selb;
	wire[31:0] result;
	wire pcsrc;
	wire[31:0] signmmsh;
	wire[31:0] pcnext;
	wire[31:0] pcnextbr;
	wire[31:0] pcbranch;
	
	assign writedata = selb;
	assign pcsrc = branch & zero;
	assign signmmsh = signimm << 2;
	
	//PC控制---------------------------
	flopr #(32) pcreg(
		.clk(clk),
		.rst(rst),
		.d(pcnext),
		.q(pc)
	);
	
	adder pcadd1(
		.a(pc),
		.b(32'h000_0004),
		.y(pcplus4)
	);
	
	adder pcaddbrach(
		.a(pcplus4),
		.b(signmmsh),
		.y(pcbranch)
	);
	//alu（算数逻辑单元）---------------
	alu _alu(
		.a(srca),
		.b(srcb),
		.op(op),
		.y(aluout),
		.overflow(),
		.zero(zero)
	);
	
	//寄存器组-----------------------
	regfile _rf(
		.clk(clk),
		.we3(regwrite),
		.ra1(instr[25:21]),
		.ra2(instr[20:16]),
		.wa3(writereg),
		.wd3(result),
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
	
	mux2 #(32) resultmux(
		.d0(aluout),
		.d1(readdata),
		.s(mem2reg),
		.y(result)
	);
	
	//pc选择器
	mux2 #(32) pcnumx(
		.d0(pcplus4),
		.d1(pcbranch),
		.s(pcsrc),
		.y(pcnextbr)
	);
	
	
	mux2 #(32) pnextcnumx(
		.d0(pcnextbr),
		.d1({pcplus4[31:28],instr[25:0],2'b00}),
		.s(jump),
		.y(pcnext)
	);
endmodule