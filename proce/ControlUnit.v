`timescale 1ns / 1ps

module ControlUnit (clk,OPCODE,BOpCode,Zero,BSelector,MemRD,MemWD,RegWrite,RegSelector,PCSelect,Enable1,Enable2,Enable3,Enable4);
	input wire clk;
	input [4:0] OPCODE;
	input [0:0] Zero;
	input [4:0] BOpCode;
	
	output reg[0:0] BSelector;
	output reg[0:0] MemRD;
	output reg[0:0] MemWD;
	output reg[0:0] RegWrite;
	output reg[1:0] RegSelector;
	output reg[0:0] PCSelect;
	output reg[0:0] Enable1;
	output reg[0:0] Enable2;
	output reg[0:0] Enable3;
	output reg[0:0] Enable4;
	
	parameter ADD = 5'd0;
   parameter SUB = 5'd1;
   parameter ADDI  = 5'd2;
	parameter SUBI = 5'd3;
	parameter MLT = 5'd4;
   parameter MLTI = 5'd5;
   parameter AND = 5'd6;
	parameter OR = 5'd7;
	parameter ANDI = 5'd8;
	parameter ORI = 5'd9;
	parameter SLR = 5'd10;
	parameter SLL = 5'd11;
	parameter LDR = 5'd12;
	parameter STR = 5'd13;
	parameter BNE = 5'd14;
	parameter BEQ = 5'd15;
	parameter J = 5'd16;
	parameter CMP = 5'd17;
	parameter NOP = 5'b11111;
	
	
	initial begin
		BSelector = 1'd0;
		PCSelect= 1'd0;
		MemRD = 1'd0;
		MemWD = 1'd0;
		RegWrite = 1'd0;
		RegSelector = 2'd0;
		Enable1 = 1'd1;
		Enable2 = 1'd1;
		Enable3 = 1'd1;
		Enable4 = 1'd1;
	end
	
	
	
	always @ (posedge clk) begin
		case(OPCODE)
			ADD:
				begin 
					BSelector = 1'd0;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd1;
					RegSelector = 2'd0;
				end
			SUB:
				begin
					BSelector =1'd0;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd1;
					RegSelector =2'd0 ;
				end
			ADDI:
				begin
					BSelector =1'd1;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd1;
					RegSelector = 2'd1;
				end
			SUBI:
				begin
					BSelector =1'd1;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd1;
					RegSelector = 2'd1;
				end
			MLT:
				begin
					BSelector =1'd0;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd1;
					RegSelector = 2'd0;
				end
			MLTI:
				begin
					BSelector =1'd1;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd1;
					RegSelector = 2'd1;
				end
			AND:
				begin
					BSelector =1'd0;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd1;
					RegSelector = 2'd0;
				end
			OR:
				begin
					BSelector =1'd0;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd1;
					RegSelector = 2'd0;
				end
			ANDI:
				begin
					BSelector =1'd1;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd1;
					RegSelector = 2'd1;
				end
			ORI:
				begin
					BSelector =1'd1;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd1;
					RegSelector = 2'd1;
				end
			SLR:
				begin
					BSelector =1'd1;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd1;
					RegSelector =2'd1;
				end
			SLL:
				begin
					BSelector = 1'd1;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd1;
					RegSelector = 2'd1;
				end
			LDR:
				begin
					BSelector =1'd1;
					MemRD = 1'd1;
					MemWD = 1'd0;
					RegWrite = 1'd1;
					RegSelector = 2'd2;
				end
			STR:
				begin
					BSelector =1'd1;
					MemRD = 1'd0;
					MemWD = 1'd1;
					RegWrite = 1'd1;
					RegSelector = 2'd2;
				end
			BNE:
				begin
					BSelector =1'd0;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd0;
					RegSelector = 2'd1;
				end
			BEQ:
				begin
					BSelector =1'd0;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd0;
					RegSelector = 2'd1;
				end
			J:
				begin
					BSelector =1'd0;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd0;
					RegSelector = 2'd0;
				end
			CMP:
				begin
					BSelector =1'd0;
					MemRD = 1'd0;
					MemWD =1'd0 ;
					RegWrite = 1'd1;
					RegSelector = 2'd0;
				end
			NOP:
				begin
					BSelector = 1'd0;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd0;
					RegSelector = 2'd0;
				end
			default:
				begin
					BSelector = 1'd0;
					MemRD = 1'd0;
					MemWD = 1'd0;
					RegWrite = 1'd0;
					RegSelector = 2'd0;
				end 
		endcase
	end
	
	always @ (Zero,BOpCode) begin
	   if (BOpCode==BNE && !Zero) PCSelect=1'd1; 
        else if (BOpCode==BEQ && Zero) PCSelect=1'd1;
        else PCSelect=1'd0;
    end
    

endmodule