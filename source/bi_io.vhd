library ieee;
use ieee.std_logic_1164.all;

entity bidirectional_io is
generic
(
	WIDTH	: integer  :=	16
);
port
(
	output_enable : in std_logic;
	data : in std_logic_vector(WIDTH-1 downto 0);
	bidir_variable : inout std_logic_vector(WIDTH-1 downto 0);
	read_buffer : out std_logic_vector(WIDTH-1 downto 0)
);
end bidirectional_io;

architecture rtl of bidirectional_io is
begin
	-- If we are using the inout as an output, assign it an output value, 
	-- otherwise assign it high-impedence
	bidir_variable <= data when output_enable = '0' else (others => 'Z');

	-- Read in the current value of the bidir port, which comes either 
	-- from the input or from the previous assignment
	read_buffer <= bidir_variable;
end rtl;