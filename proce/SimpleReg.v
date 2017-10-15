`timescale 1ns / 1ps

module SimpleReg(clk,Reset,DataIn,DataOut);

	input [31:0] DataIn;
	input clk,Reset;
	output reg [31:0] DataOut;

	
	initial begin
		DataOut = 32'd0;
	end

	
	always @ (negedge clk)
	   begin
		  if(Reset)
			 DataOut <= 0;
		  else begin
		  	   DataOut <= DataIn;
		  end
	   end	
	
endmodule