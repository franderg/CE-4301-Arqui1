`timescale 1ns / 1ps

module InstructionMem(Pc,clk,OpCode,RS,RT,RD,IMM,JADDR,UsableInstruc,NEWPC);
	input clk;
	input  [31:0] Pc;
  	output reg [4:0] OpCode;
  	output reg [4:0] RS, RT, RD;
	output reg [31:0] UsableInstruc;
	output [31:0] NEWPC;
	output reg [16:0] IMM;
	output reg [31:0] JADDR;
	 
	 
	reg [0:0] ended; 
	//reg [31:0] mem [0:19];
	 
	initial begin
		ended=1'd0;
		UsableInstruc =32'b11111000000000000000000000000000;
		OpCode =5'b11111;
		RS =5'd0;
		RT =5'd0; 
		RD =5'd0;
		IMM =17'd0;
		JADDR =31'd0;

		/*
		mem[0]=32'b11111000000000000000000000000000; //NOP
		mem[1]=32'b00010000010000100000000000000001; //ADDI R1,R1,1
		mem[2]=32'b00010000100001000000000000000011; //ADDI R2,R2,3
		mem[3]=32'b11111000000000000000000000000000; //NOP
		mem[4]=32'b11111000000000000000000000000000; //NOP
		mem[5]=32'b11111000000000000000000000000000; //NOP
		mem[6]=32'b00100000110000100010000000000000; //MLT R3,R1,R2
		mem[7]=32'b11111000000000000000000000000000; //NOP
        mem[8]=32'b11111000000000000000000000000000; //NOP
        mem[9]=32'b11111000000000000000000000000000; //NOP
		mem[10]=32'b01110000010001100000000000001111; //BEQ R1,R3,15                                                                    
        mem[11]=32'b11111000000000000000000000000000; //NOP
        mem[12]=32'b11111000000000000000000000000000; //NOP
        mem[13]=32'b11111000000000000000000000000000; //NOP
		mem[14]=32'b10000000000000000000000000010010; //J 18
		mem[15]=32'b10001001000001000001000000000000; //CMP R4,R2,R1                                                                                                              
		mem[16]=32'b11111000000000000000000000000000; //NOP
	    mem[17]=32'b11111000000000000000000000000000; //NOP   
	    mem[18]=32'b11111000000000000000000000000000; //NOP
	    mem[19]=32'b11111111111111111111111111111111; //END*/
	
	end 
	
	
	 wire [31:0] instruction;
	 rom rom1(
		.address(Pc),
		.clock(clk),
		.q(instruction)
	);
	
	always @ (Pc or ended or instruction) begin
		UsableInstruc=instruction;
	  //  if (ended) UsableInstruc=32'b11111000000000000000000000000000;
		//else if (mem[Pc]==32'b11111111111111111111111111111111) ended=1'd1;
		
		//else UsableInstruc=mem[Pc];
		
		
		if (ended) UsableInstruc=32'b1111100000000000000000000000000;
		else if (UsableInstruc==32'b11111111111111111111111111111111) ended=1'd1;
		
		OpCode = UsableInstruc[31:27];
		RS = UsableInstruc[21:17];
		RT = UsableInstruc[16:12];
		RD = UsableInstruc[26:22];
		IMM = UsableInstruc[16:0];
		JADDR[26:0] = UsableInstruc[26:0];
		JADDR[31:27]=5'd0;
                                                                
	 end
	 assign NEWPC = (OpCode==5'd16)? JADDR: Pc+1; 
	 

	 
endmodule