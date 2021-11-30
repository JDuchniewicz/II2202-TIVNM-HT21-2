

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use IEEE.fixed_pkg.all;
USE work.neuron_type_pkg.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY fakememory IS
	PORT (
		address : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock : IN STD_LOGIC := '1';
		data : IN sfixed (int_size-1 DOWNTO -frac_size);
		wren : IN STD_LOGIC;
		q : OUT sfixed (int_size-1 DOWNTO -frac_size)
	);
END fakememory;
ARCHITECTURE fake OF fakememory IS
	type program is array (natural range <>) of std_logic_vector(15 downto 0);
		signal data_temp	:sfixed (int_size-1 DOWNTO -frac_size);
		signal address_temp :STD_LOGIC_VECTOR (7 DOWNTO 0);
		signal wren_temp	:STD_LOGIC ;
		SIGNAL RAM	:  neuron_inputs(0 to 63):=(
			to_sfixed(-0.289,  int_size-1, -frac_size), to_sfixed(-0.461,  int_size-1, -frac_size),
			to_sfixed(-1.009,  int_size-1, -frac_size), to_sfixed(-1.651,  int_size-1, -frac_size), 
			to_sfixed(-0.114,  int_size-1, -frac_size), to_sfixed(-0.465,  int_size-1, -frac_size), 
			to_sfixed(-0.559,  int_size-1, -frac_size), to_sfixed(-0.192,  int_size-1, -frac_size),
			to_sfixed(-1.298,  int_size-1, -frac_size), to_sfixed(1.475,  int_size-1, -frac_size), 
			to_sfixed(-0.054,  int_size-1, -frac_size), to_sfixed(1.381,  int_size-1, -frac_size), 
			to_sfixed(-0.244,  int_size-1, -frac_size), to_sfixed(1.402,  int_size-1, -frac_size),
			to_sfixed(1.219,  int_size-1, -frac_size), to_sfixed(0.62,  int_size-1, -frac_size),
			to_sfixed(0.632,  int_size-1, -frac_size), to_sfixed(0.093,  int_size-1, -frac_size),
			to_sfixed(1.64,  int_size-1, -frac_size),  to_sfixed(0.197,  int_size-1, -frac_size),
			to_sfixed(-0.873,  int_size-1, -frac_size), to_sfixed(0.744,  int_size-1, -frac_size),
			to_sfixed(0.127,  int_size-1, -frac_size), to_sfixed(-0.395,  int_size-1, -frac_size), 
			to_sfixed(0.94,  int_size-1, -frac_size), to_sfixed(-1.629,  int_size-1, -frac_size), 
			to_sfixed(1.15,  int_size-1, -frac_size), to_sfixed(0.574,  int_size-1, -frac_size), 
			to_sfixed(0.282,  int_size-1, -frac_size), to_sfixed(0.803,  int_size-1, -frac_size),
			to_sfixed(0.459,  int_size-1, -frac_size), to_sfixed(1.255,  int_size-1, -frac_size),
			to_sfixed(-0.177,  int_size-1, -frac_size), to_sfixed(-0.432,  int_size-1, -frac_size),
			to_sfixed(0.451,  int_size-1, -frac_size), to_sfixed(1.56,  int_size-1, -frac_size),
			to_sfixed(0.065,  int_size-1, -frac_size), to_sfixed(0.5,  int_size-1, -frac_size), 
			to_sfixed(0.075,  int_size-1, -frac_size), to_sfixed(1.694,  int_size-1, -frac_size), 
			to_sfixed(-0.726,  int_size-1, -frac_size), to_sfixed(-0.706,  int_size-1, -frac_size),
			to_sfixed(-0.942,  int_size-1, -frac_size), to_sfixed(-0.868,  int_size-1, -frac_size),
			to_sfixed(-0.469,  int_size-1, -frac_size), to_sfixed(0.065,  int_size-1, -frac_size),
			to_sfixed(-0.527,  int_size-1, -frac_size), to_sfixed(0.247,  int_size-1, -frac_size),
			to_sfixed(0.222,  int_size-1, -frac_size), to_sfixed(0.263,  int_size-1, -frac_size), 
			to_sfixed(0.216,  int_size-1, -frac_size), to_sfixed(-1.881,  int_size-1, -frac_size), 
			to_sfixed(0.904,  int_size-1, -frac_size), to_sfixed(-0.747,  int_size-1, -frac_size), 
			to_sfixed(-0.537,  int_size-1, -frac_size), to_sfixed(-0.635,  int_size-1, -frac_size),
			to_sfixed(-0.724,  int_size-1, -frac_size), to_sfixed(0.075,  int_size-1, -frac_size), 
			to_sfixed(1.009,  int_size-1, -frac_size), to_sfixed(-0.484,  int_size-1, -frac_size), 
			to_sfixed(1.136,  int_size-1, -frac_size), to_sfixed(0.63,  int_size-1, -frac_size), 
			to_sfixed(0.414,  int_size-1, -frac_size), to_sfixed(-0.064,  int_size-1, -frac_size));


	BEGIN
		process (clock)
		begin
			if (rising_edge(clock)) then 
				address_temp <= address;
				data_temp <= data;
				wren_temp <= wren;
			end if;
		end process;

		process(data_temp,address_temp,wren_temp)
		begin
		if(wren_temp = '0') then
			RAM (to_integer(UNSIGNED(data_temp))) <= data_temp;
		else
		q    <= RAM(to_integer(UNSIGNED(address_temp)));
		end if;
		end process;
	-- altsyncram_component : altsyncram
	-- GENERIC MAP(
	-- 	clock_enable_input_a => "BYPASS",
	-- 	clock_enable_output_a => "BYPASS",
	-- 	init_file => "memory.hex",
	-- 	intended_device_family => "Cyclone IV E",
	-- 	lpm_hint => "ENABLE_RUNTIME_MOD=YES,INSTANCE_NAME=RAM",
	-- 	lpm_type => "altsyncram",
	-- 	numwords_a => 256,
	-- 	operation_mode => "SINGLE_PORT",
	-- 	outdata_aclr_a => "NONE",
	-- 	outdata_reg_a => "UNREGISTERED",
	-- 	power_up_uninitialized => "FALSE",
	-- 	read_during_write_mode_port_a => "NEW_DATA_NO_NBE_READ",
	-- 	widthad_a => 8,
	-- 	width_a => 16,
	-- 	width_byteena_a => 1
	-- )
	-- PORT MAP(
	-- 	address_a => address,
	-- 	clock0 => clock,
	-- 	data_a => data,
	-- 	wren_a => wren,
	-- 	q_a => q
	-- );

END fake;