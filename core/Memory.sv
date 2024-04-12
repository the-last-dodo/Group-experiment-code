module Memory (
    input clock,          
    input [11:0] address, 
    output reg [31:0] q
);

    reg [31:0] memory [0:4095];
    initial begin
        memory[12'd1] = 32'd1;
        memory[12'd2] = 32'd2;
        memory[12'd3] = 32'd3;
        // 其他初始化操作...
    end
    always @* begin
        // 根据地址信号读取数据
        q = memory[address];
    end

endmodule
