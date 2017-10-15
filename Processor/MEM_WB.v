`timescale 1ns / 1ps

module MEM_WB(clk,Reset,Enable, RegWrite, WriteAddress,WriteData, REGWRITE,WRITEADDRESS,WRITEDATA);
	input wire clk, Reset, Enable;
	input[0:0] RegWrite;
	input [4:0] WriteAddress;
	input [31:0] WriteData;
	output reg[0:0] REGWRITE;
	output reg[4:0] WRITEADDRESS;
	output reg[31:0] WRITEDATA;
	
	initial begin
		REGWRITE=1'd0;
		WRITEADDRESS=5'd0;
		WRITEDATA=32'd0;
	end

	always @ (negedge clk) begin
		if(Reset)begin
			REGWRITE=1'd0;
			WRITEADDRESS=5'd0;
			WRITEDATA=32'd0;

		end 
		else if (Enable)begin
			REGWRITE= RegWrite;
			WRITEADDRESS = WriteAddress;
			WRITEDATA = WriteData;
		end 
	end	

endmodule