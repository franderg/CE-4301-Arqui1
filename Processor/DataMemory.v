`timescale 1ns / 1ps

module DataMemory(clk,Reset,MemoryAddress,memWD,memRD,DataOut,DataIn);
	output reg [31:0] DataOut;
	input [31:0] MemoryAddress,DataIn;
   input memRD, memWD,Reset,clk;
	
	initial begin
		DataOut=32'd0;

 	end
	
	
	always @ (MemoryAddress or memWD or memRD or DataIn)begin
		if (memRD)begin
			DataOut=32'd0;
			//DataOut=Memory[MemoryAddress];
		end
		else if (memWD)begin
			//Memory[MemoryAddress]=DataIn;
			DataOut=32'd0;
		end
		else  DataOut=MemoryAddress;

	end
endmodule