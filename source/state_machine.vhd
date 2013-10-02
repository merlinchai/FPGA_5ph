-- Quartus II VHDL Template
-- Single-port RAM with single read/write address and initial contents	

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity three_state_moore_state_machine is

	generic 
	(
		DATA_WIDTH : natural := 16;
		ADDR_WIDTH : natural := 5
	);

	port 
	(
		en		: in std_logic := '1';
		clk		: in std_logic;
		xwe		: in std_logic := '1';
		xzcs2	: in std_logic := '1';
		addr	: in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
		
		clk2	 : in	std_logic;
		NSYNC	 : out	std_logic;
		DIN		 : out	std_logic
	);
	

end three_state_moore_state_machine;

architecture rtl of three_state_moore_state_machine is

	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;

	function init_ram
		return memory_t is 
		variable tmp : memory_t := (others => (others => '0'));
	begin 
		for addr_pos in 0 to 2**ADDR_WIDTH - 1 loop 
			-- Initialize each address with the address itself
			tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, DATA_WIDTH));
		end loop;
		return tmp;
	end init_ram;	

	signal ram : memory_t := init_ram;
	
	-- Build an enumerated type for the state machine
	type state_type is (sync, dataTrans, waiting);

	-- Register to hold the current state
	signal state   : state_type;
	
	-- define 30 clk period in total
	signal count : integer :=0;
	signal output_buff: std_logic_vector(23 downto 0);
	
	signal addrD : std_logic_vector (2 downto 0);
	signal Ddata : std_logic_vector (11 downto 0);

begin

	process(clk)
	
	variable addrN : integer := 0;	
	
	begin
	if(rising_edge(clk)) then
	
	--	if reset = '0' then
	--		ram <= init_ram;
	--		state <= sync;
	--		count <= 0;
	--	end if;
				
		if(xzcs2='0' and xwe='0' and en='0') then
			addrN := conv_integer(addr);
			ram(addrN) <= data;
		end if;

	end if;
	end process;

--	 Logic to advance to the next state
	process (clk2)
	
	variable count_ADDR: integer :=0;
	
	begin
		if (rising_edge(clk2)) then
	
		--	if reset = '0' then
		--	ram <= init_ram;
		--	state <= sync;
		--	count <= 0;
		--	end if;
			
			case count is
				when 0 =>
					state <= sync;
					addrD <=conv_std_logic_vector(count_ADDR,3);
					Ddata <=ram(count_ADDR)(11 downto 0);
					count_ADDR := count_ADDR+1;
					if count_ADDR=4 then
						count_ADDR := 0;
						end if;
				when 1 to 24 =>
						state <= dataTrans;
				when 25 to 29 =>
						state <= waiting;
				when others =>
						state <= waiting;
			end case;
			count <= count + 1;
			if count = 30 then
				count <= 0 ;
				end if;
		end if;
	end process;

	-- Output depends solely on the current state
	process (clk2, state)
	
	begin
	if (rising_edge(clk2)) then
		case state is
			when sync =>
				output_buff <= "00" & "011" & addrD & Ddata & "0000";
				NSYNC <= '1';
				DIN   <= '0';				
			when dataTrans =>
				NSYNC <= '0';
				DIN   <= output_buff(23);
				output_buff(23 downto 1) <= output_buff (22 downto 0);
			when waiting =>
				NSYNC <= '0';
				DIN   <= '0';
		end case;
		end if;
	end process;

end rtl;
