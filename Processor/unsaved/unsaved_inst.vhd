	component unsaved is
		port (
			clk_clk         : in  std_logic                     := 'X';             -- clk
			pc_address      : in  std_logic_vector(4 downto 0)  := (others => 'X'); -- address
			pc_debugaccess  : in  std_logic                     := 'X';             -- debugaccess
			pc_clken        : in  std_logic                     := 'X';             -- clken
			pc_chipselect   : in  std_logic                     := 'X';             -- chipselect
			pc_write        : in  std_logic                     := 'X';             -- write
			pc_readdata     : out std_logic_vector(31 downto 0);                    -- readdata
			pc_writedata    : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			pc_byteenable   : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			reset_reset     : in  std_logic                     := 'X';             -- reset
			reset_reset_req : in  std_logic                     := 'X'              -- reset_req
		);
	end component unsaved;

	u0 : component unsaved
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --   clk.clk
			pc_address      => CONNECTED_TO_pc_address,      --    pc.address
			pc_debugaccess  => CONNECTED_TO_pc_debugaccess,  --      .debugaccess
			pc_clken        => CONNECTED_TO_pc_clken,        --      .clken
			pc_chipselect   => CONNECTED_TO_pc_chipselect,   --      .chipselect
			pc_write        => CONNECTED_TO_pc_write,        --      .write
			pc_readdata     => CONNECTED_TO_pc_readdata,     --      .readdata
			pc_writedata    => CONNECTED_TO_pc_writedata,    --      .writedata
			pc_byteenable   => CONNECTED_TO_pc_byteenable,   --      .byteenable
			reset_reset     => CONNECTED_TO_reset_reset,     -- reset.reset
			reset_reset_req => CONNECTED_TO_reset_reset_req  --      .reset_req
		);

