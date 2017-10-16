`timescale 1ns / 1ps

module DataMemory(clk,Reset,MemoryAddress,memWD,memRD,DataOut,DataIn);
	output reg [31:0] DataOut;
	input [31:0] MemoryAddress,DataIn;
   input memRD, memWD,Reset,clk;
	
	
	
	reg [6:0] Memory [0:60348];
	
	
	
	initial begin
		DataOut=32'd0;
		$readmemb("text.txt",Memory);

 	end
	
	
	always @ (posedge clk)begin
		if (memRD)begin
			DataOut=Memory[MemoryAddress];
		end
		else if (memWD)begin
			Memory[MemoryAddress]=DataIn;
		end
		else  DataOut=MemoryAddress;

	end
endmodule