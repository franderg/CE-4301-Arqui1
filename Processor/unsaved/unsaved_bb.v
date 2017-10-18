
module unsaved (
	clk_clk,
	pc_address,
	pc_debugaccess,
	pc_clken,
	pc_chipselect,
	pc_write,
	pc_readdata,
	pc_writedata,
	pc_byteenable,
	reset_reset,
	reset_reset_req);	

	input		clk_clk;
	input	[4:0]	pc_address;
	input		pc_debugaccess;
	input		pc_clken;
	input		pc_chipselect;
	input		pc_write;
	output	[31:0]	pc_readdata;
	input	[31:0]	pc_writedata;
	input	[3:0]	pc_byteenable;
	input		reset_reset;
	input		reset_reset_req;
endmodule
