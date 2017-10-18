`timescale 1ns / 1ps

module ALU(A, B, ALUOp , ALUOut, Zero);

    output reg [31:0] ALUOut;
	 output reg [0:0] Zero;
    input [31:0] A, B;
    input [4:0] ALUOp;
	 
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
	
	parameter on = 1'd1; 
	parameter off = 1'd0;
	 
	 
	 
	 initial begin
		ALUOut=32'd0;
		Zero=1'd0;
	 end
	 
    always @ (A or B or ALUOp) begin
			  case (ALUOp)
					ADD:
						begin 
							ALUOut = A+B; 
							Zero=off;
						end 
					SUB:
						begin 
							ALUOut = A-B;
							Zero=off;
						end
					ADDI: 
						begin 
							ALUOut = A+B; 
							Zero=off;
						end
					SUBI: 
						begin 
							ALUOut = A-B;
							Zero=off;	
						end
					MLT: 
						begin 
							ALUOut = A*B;
							Zero=off;
						end
					MLTI: 
						begin 
							ALUOut = A*B;
							Zero=off;
						end
					AND: 
						begin 
							ALUOut = A&B;
							Zero=off;
						end
					OR:
						begin 
							ALUOut = A|B;
							Zero=off;
						end
					ANDI: 
						begin 
							ALUOut = A&B;
							Zero=off;
						end
					ORI: 
						begin 
							ALUOut = A|B; 
							Zero=off;
						end
					SLR:
						begin 
							ALUOut = A>>B; 
							Zero=off;
						end
					SLL: 
						begin 
							ALUOut = A<<B; 
							Zero=off;
						end
					LDR:
						begin 
							ALUOut = A+B; 
							Zero=off;
						end
					STR: 
						begin 
							ALUOut = A+B; 
							Zero=off;
						end
					BNE: 
						begin
							ALUOut = 32'd0;
							if(A==B) Zero=on;
							else Zero=off;
						end
					BEQ:
						begin
							ALUOut = 32'd0;
							if (A==B) Zero=on;
							else Zero=off;
						end
					CMP:
						begin
							if (A>B) ALUOut=2'd1;
							else if(A==B) ALUOut=2'd0;
							else ALUOut=2'd2;
							Zero=off;
						end 
					default: 
						begin
							ALUOut = 32'd0;
							Zero=off;
						end 
			  endcase
    end
endmodule