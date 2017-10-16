`timescale 1ns / 1ps

module IF_ID(clk,Reset,Enable,Rd,Rs,Rt,Imm,Jaddr,Opcode,Pc,RD,RS,RT,IMM,JADDR,OPCODE, PC);
	input wire clk, Reset, Enable;
	input [4:0] Rd,Rs,Rt;
	input [4:0] Opcode;
	input [31:0] Jaddr;
	input [16:0] Imm;
	input [31:0] Pc;
	output reg [4:0] RD,RS,RT;
	output reg [4:0] OPCODE;
	output reg [32:0] PC;
	output reg [31:0] JADDR;
	output reg [16:0] IMM;


	initial begin
		RS = 5'd0;
		RD = 5'd0;
		RT = 5'd0;
		OPCODE = 5'b11111;
		PC= 32'd0;
		IMM=17'd0;
		JADDR=32'd0;
	end

	always @ (posedge clk) begin
		if(Reset)begin
			RS<=5'd0;
			RD<=5'd0;
			RT<=5'd0;
			OPCODE<=5'b11111;
			PC<=32'd0;
			IMM<=17'd0;
			JADDR<=32'd0;
		end 
		else if (Enable)begin
			RS<=Rs;
			RD<=Rd;
			RT<=Rt;
			OPCODE<=Opcode;
			PC<=Pc;
			IMM<=Imm;
			JADDR<=Jaddr;
		end
	end	
endmodule