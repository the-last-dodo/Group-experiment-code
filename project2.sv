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
		.reg_t1(reg_t1),
		.reg_t2(reg_t2),
		.reg_t3(reg_t3),
		.reg_t4(reg_t4),
		.reg_t5(reg_t5)	
	);
	/*Memory M(
	.clock(clk),
	.address(pc[13:2]),
	.q(rom_out));
	*/
	irom_4096_32 (
	.address(pc[13:2]),
	.clock(clk),
	.q(instr));

    /* 
    reg [11:0] addr;   
    reg [31:0] data_in; 

    iram_4096_32 ram (
        .address(pc[13:2]),
        .clock(clk),
        .data(32'h000000AA),
        .wren(wren),
        .q(rom_out)
    );*/
	



endmodule