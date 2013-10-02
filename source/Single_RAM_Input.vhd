-- Quartus II VHDL Template
-- Single-port RAM with single read/write address and initial contents	

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity single_port_ram_input_with_init is

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
		xrd		: in std_logic := '1';
		xzcs2	: in std_logic := '1';
		addr	: in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
		data_out: out std_logic_vector((DATA_WIDTH-1) downto 0);
				
		IOA		: inout STD_LOGIC_VECTOR(23 downto 0);
		
		rst		: in std_logic := '1'
	);

end single_port_ram_input_with_init;

architecture rtl of single_port_ram_input_with_init is

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

	-- Declare the RAM signal and specify a default value.	Quartus II
	-- will create a memory initialization file (.mif) based on the 
	-- default value.
	signal ram : memory_t := init_ram;

begin

	process(clk)
	
	variable addrN : integer := 0;	
	CONSTANT IODIRLOW: natural := 24; -- define the direction of 24 pin I/O [23..0]
	CONSTANT IODIRHIGH: natural := 25;-- '1' is output, '0' is input
	
	begin
	if(rising_edge(clk)) then
		if(rst='0') then
			ram <= init_ram;
			ram(IODIRLOW) <= "0000000000000000";
			ram(IODIRHIGH) <= "0000000000000000";
			IOA <= "ZZZZZZZZZZZZZZZZZZZZZZZZ";			
		elsif (xzcs2='0' and xwe='0' and en='0') then
				addrN := conv_integer(addr);
				ram(addrN) <= data;
				if(addrN<16) then
					if (ram(IODIRLOW)(addrN)='1')then -- '1' means output is enable
						if (ram(addrN)="0000000000000000") then
							IOA(addrN) <= '0';
						else IOA(addrN) <= '1';
						end if;
					end if;
				elsif(addrN<24)then			
					if (ram(IODIRHIGH)(addrN-16)='1')then -- 15..0 is lower pin
						if (ram(addrN)="0000000000000000") then
							IOA(addrN) <= '0';
						else IOA(addrN) <= '1';
						end if;
					end if;
				end if;
			end if;
		
		if(xzcs2='0' and xrd='0' and en='0') then
			addrN := conv_integer(addr);
			if (addrN<24) then		-- fetch the data whatever the pin is output or input	
				if (IOA(addrN)='0') then
					ram(addrN) <= "0000000000000000";
				else ram(addrN) <= "0000000000000001";
				end if;
			end if;
			data_out <= ram(addrN);						
		end if;
				
	end if;
	end process;

end rtl;






