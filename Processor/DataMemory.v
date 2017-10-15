`timescale 1ns / 1ps

module DataMemory(clk,Reset,MemoryAddress,memWD,memRD,DataOut,DataIn);
	output reg [31:0] DataOut;
	input [31:0] MemoryAddress,DataIn;
   input memRD, memWD,Reset,clk;
	
	initial begin
		DataOut=32'd0;
 	end
	
	
	wire [6:0] data;
	mem mem1(
		.address(MemoryAddress),
		.clock(clk),
		.q(data)
	);
	
	
	always @ (data or memWD or memRD or DataIn or MemoryAddress)begin
		if (memRD)begin
			DataOut[31:7]=25'd0;
			DataOut[6:0]=data;
		end
		else if (memWD)begin
			DataOut=32'd0;
		end
		else  DataOut=MemoryAddress;

	end
endmodule