`timescale 1ns / 1ps

module EX_MEM(clk,Reset,Enable,MemoryAddress,WriteAddress,DataIn, MemRD, MemWD, RegWrite,
											MEMORYADDRESS,WRITEADDRESS,DATAIN,MEMRD, MEMWD,REGWRITE);
	input  clk, Reset, Enable;
	input [4:0] WriteAddress;
	input [0:0] MemWD,MemRD;
	input [31:0] DataIn;
	input [31:0] MemoryAddress;
	input [0:0] RegWrite;
	output reg [31:0] MEMORYADDRESS;
	output reg [4:0] WRITEADDRESS;
	output reg [31:0] DATAIN;
	output reg [0:0] REGWRITE,MEMWD,MEMRD;



	initial begin
		WRITEADDRESS=5'd0;
		MEMORYADDRESS=31'd0;
		DATAIN=31'd0;
		MEMRD=1'd0;
		MEMWD=1'd0;
		REGWRITE=1'd0;

	end

	always @ (negedge clk) begin
		if(Reset)begin
			WRITEADDRESS=5'd0;
			MEMORYADDRESS=31'd0;
			DATAIN=31'd0;
			MEMRD=1'd0;
			MEMWD=1'd0;
			REGWRITE=1'd0;

		end 
		else if (Enable)begin
			WRITEADDRESS = WriteAddress;
			MEMORYADDRESS = MemoryAddress;
			DATAIN = DataIn;
			MEMRD = MemRD;
			MEMWD = MemWD;
			REGWRITE = RegWrite;

		end 
	end	


endmodule