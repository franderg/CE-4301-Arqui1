`timescale 1ns / 1ps

module Processor(clk,Reset,seven);
	input clk, Reset;
	output [6:0]seven;
	
	
	wire [31:0] pcsignal;
	
	
	wire [31:0] pc;
	
	wire [4:0]opcode;
  	wire [4:0] rs,rt,rd;
	wire [31:0] instruction;
	wire [16:0] imm;
	wire [31:0] jaddr;
	wire [31:0] newpc;
	
	wire [4:0] opcode1;
  	wire [4:0] rs1,rt1,rd1;
	wire [16:0] imm1;
	wire [31:0] jaddr1;
	
	wire [0:0] enable1,enable2,enable3,enable4;
	wire [0:0] bselector;
	wire [1:0] regselector;
	wire [0:0] pcselect;
	wire [0:0] memrd,memwd,regwrite;
	
	wire [4:0] muxout1;
	wire [4:0] muxout2;
	
	wire [31:0] rdata1,rdata2;
	
	wire [0:0] bselector1;	
	wire [31:0] rvalue11,rvalue21;
	wire [4:0] rd2;
	wire [0:0] memrd1,memwd1,regwrite1;
	wire [4:0] opcode2;
	wire [31:0] immvalue1;
	wire [31:0] immvalue2;
	
	wire [31:0] alumuxout;
	
	wire [0:0] zero;
	wire [31:0] aluout;
	
	wire [0:0] memrd2,memwd2,regwrite2;
	wire [31:0] datain;
	wire [31:0] memoryaddress;
	wire [4:0] writeaddress;
	
	wire [31:0] dataout;	
	
	wire [31:0] writedata;
	wire [0:0] regwrite3;
	wire [4:0] writeaddress1;
		
		
	MuxData pcselectmux(
		.Output(pcsignal),
		.Input0(newpc),
		.Input1(immvalue2),
		.Selector(pcselect)
	);
	
	
	SimpleReg pcreg(
		.clk(clk),
		.Reset(Reset),
		.DataIn(pcsignal),
		.DataOut(pc)
	);
	
	
	InstructionMem insmem(
		.Pc(pc),
		.clk(clk),
		.OpCode(opcode),
		.RS(rs),
		.RT(rt),
		.RD(rd),
		.IMM(imm),
		.JADDR(jaddr),
		.UsableInstruc(instruction),
		.NEWPC(newpc)
	);
	
	
	IF_ID ifid(.clk(clk),
		.Reset(Reset),
		.Enable(enable1),
		.Rd(rd),
		.Rs(rs),
		.Rt(rt),
		.Imm(imm),
		.Jaddr(jaddr),
		.Opcode(opcode),
		.Pc(pc),
		.RD(rd1),
		.RS(rs1),
		.RT(rt1),
		.IMM(imm1),
		.JADDR(jaddr1),
		.OPCODE(opcode1),
		.PC()	
	);
				
    
    SignExt signext(.SEin(imm1),.SEout(immvalue1));
    
    
	ControlUnit ctrlunit(
		.clk(clk),
		.OPCODE(opcode1),
		.BOpCode(opcode2),
		.Zero(zero),
		.BSelector(bselector),
		.MemRD(memrd),
		.MemWD(memwd),
		.RegWrite(regwrite),
		.RegSelector(regselector),
		.PCSelect(pcselect),
		.Enable1(enable1),
		.Enable2(enable2),
		.Enable3(enable3),
		.Enable4(enable4)
	);	
	
	      
	MuxReg reg1(.Output(muxout1), .Input0(rs1), .Input1(rd1), .Input2(rs1),.Selector(regselector));
	MuxReg reg2(.Output(muxout2), .Input0(rt1), .Input1(rs1), .Input2(rd1),.Selector(regselector));
	
	wire [31:0] r;
	wire[6:0] seven1; 
	
	sevenSeg ss(.R(r),.Seg(seven1));
	
	assign seven = opcode;
	
	RegisterBanc regbank(
		.ReadData1(rdata1),
		.ReadData2(rdata2),
		.WriteData(writedata),
		.ReadAddr1(muxout1),
		.ReadAddr2(muxout2),
		.WriteAddr(writeaddress1),
		.RegWrite(regwrite3),
		.clk(clk),
		.ro(r)
	);		


	ID_Ex idex(
		.clk(clk),
		.Reset(Reset),
		.Enable(enable2),
		.Opcode(opcode1),
		.BSelector(bselector),
		.Rd(rd1),
		.RValue1(rdata1),
		.RValue2(rdata2),
		.ImmValue(immvalue1),
		.MemRD(memrd),
		.memWD(memwd),
		.RegWrite(regwrite),
		.OPCODE(opcode2),
		.BSELECTOR(bselector1),
		.RD(rd2),
		.RVALUE1(rvalue11),
		.RVALUE2(rvalue21),
		.IMMVALUE(immvalue2),
		.MEMWD(memwd1),
		.MEMRD(memrd1),
		.REGWRITE(regwrite1)
	);
				
	
	MuxData alumuxB(.Output(alumuxout), .Input0(rvalue21),.Input1(immvalue2),.Selector(bselector1));
		
	
	ALU alu(.A(rvalue11), .B(alumuxout), .ALUOp(opcode2) ,
	 .ALUOut(aluout), .Zero(zero));
				
				
	EX_MEM exmen(
		.clk(clk),
		.Reset(Reset),
		.Enable(enable3),
		.MemoryAddress(aluout),
		.WriteAddress(rd2),
		.DataIn(rvalue21),
		.MemRD(memrd1),
		.MemWD(memwd1),
		.RegWrite(regwrite1),
		.MEMORYADDRESS(memoryaddress),
		.WRITEADDRESS(writeaddress),
		.DATAIN(datain),
		.MEMRD(memrd2),
		.MEMWD(memwd2),
		.REGWRITE(regwrite2)
	);

	DataMemory datamen(
		.clk(clk),
		.Reset(Reset),
		.MemoryAddress(memoryaddress),
		.memWD(memwd2),
		.memRD(memrd2),
		.DataOut(dataout),
		.DataIn(datain)
	);		
					
					
	MEM_WB menwb(
		.clk(clk),
		.Reset(Reset),
		.Enable(enable4),
		.RegWrite(regwrite2),
		.WriteAddress(writeaddress),
		.WriteData(dataout),
		.REGWRITE(regwrite3),
		.WRITEADDRESS(writeaddress1),
		.WRITEDATA(writedata)
	);

				
endmodule