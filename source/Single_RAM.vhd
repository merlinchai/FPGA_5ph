-- Quartus II VHDL Template
-- Single-port RAM with single read/write address and initial contents	

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity single_port_ram_with_init is

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
		rst		: in std_logic;
		
		PWMA	: OUT STD_LOGIC_VECTOR(11 downto 0);
		xint2	: OUT std_logic := '0';    
		flag	: OUT std_logic := '0'
	);

end single_port_ram_with_init;

architecture rtl of single_port_ram_with_init is

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
	
	begin
	if(rising_edge(clk)) then
		if(xzcs2='0' and xwe='0' and en='0') then
			addrN := conv_integer(addr);
			ram(addrN) <= data;
		end if;

	end if;
	end process;

  main:PROCESS

  CONSTANT period: STD_LOGIC_VECTOR(15 downto 0):= X"4E20"; --X"3A98"; --15000
  --CONSTANT halfperiod: STD_LOGIC_VECTOR(15 downto 0):="0011101010011000";
  
  
 --define the corresponding registor name of ram address 
  CONSTANT PWM_period: natural := 0;
  
  CONSTANT PWMA_Wa1: natural := 1;    
  CONSTANT PWMA_Du1: natural := 2; 
  CONSTANT PWMA_Wa2: natural := 3;    
  CONSTANT PWMA_Du2: natural := 4;   
  CONSTANT PWMA_Wa3: natural := 5;    
  CONSTANT PWMA_Du3: natural := 6;  
  CONSTANT PWMA_Wa4: natural := 7;    
  CONSTANT PWMA_Du4: natural := 8; 
  CONSTANT PWMA_Wa5: natural := 9;    
  CONSTANT PWMA_Du5: natural := 10;  
  CONSTANT PWMA_Wa6: natural := 11;    
  CONSTANT PWMA_Du6: natural := 12;  
  CONSTANT PWMA_Wa7: natural := 13;    
  CONSTANT PWMA_Du7: natural := 14;  
  CONSTANT PWMA_Wa8: natural := 15;    
  CONSTANT PWMA_Du8: natural := 16;  
  CONSTANT PWMA_Wa9: natural := 17;    
  CONSTANT PWMA_Du9: natural := 18; 
  CONSTANT PWMA_Wa10: natural := 19;    
  CONSTANT PWMA_Du10: natural := 20;  
  CONSTANT PWMA_Wa11: natural := 21;    
  CONSTANT PWMA_Du11: natural := 22;  
  CONSTANT PWMA_Wa12: natural := 23;    
  CONSTANT PWMA_Du12: natural := 24;  
  
  VARIABLE count:STD_LOGIC_VECTOR(15 downto 0):= X"0000";
  
  VARIABLE PWMA_W1,PWMA_W2,PWMA_W3,PWMA_W4,PWMA_W5,PWMA_W6,PWMA_W7,PWMA_W8,PWMA_W9,PWMA_W10,PWMA_W11,PWMA_W12:STD_LOGIC_VECTOR(15 downto 0);
  VARIABLE PWMA_D1,PWMA_D2,PWMA_D3,PWMA_D4,PWMA_D5,PWMA_D6,PWMA_D7,PWMA_D8,PWMA_D9,PWMA_D10,PWMA_D11,PWMA_D12:STD_LOGIC_VECTOR(15 downto 0);
  
  BEGIN
   WAIT UNTIL clk'event and clk='1';
   
	if(rst='0') then
        		
		PWMA <= "000000000000";
		
		IF (count=period)THEN 		
            xint2<='1';
            count:= X"0000";
			flag <= '1';					
		ELSif count > 500 then
			xint2<='0';    
			flag <='0';
		END IF;
		
        count:=count+1;		
        		
	else  
	 IF (count=period)THEN        
		PWMA_W1 := ram(PWMA_Wa1);                     
		PWMA_W2 := ram(PWMA_Wa2);                             
		PWMA_W3 := ram(PWMA_Wa3);
		PWMA_W4 := ram(PWMA_Wa4);
		PWMA_W5 := ram(PWMA_Wa5);
		PWMA_W6 := ram(PWMA_Wa6);
		PWMA_W7 := ram(PWMA_Wa7);                     
		PWMA_W8 := ram(PWMA_Wa8);                             
		PWMA_W9 := ram(PWMA_Wa9);
		PWMA_W10 := ram(PWMA_Wa10);
		PWMA_W11 := ram(PWMA_Wa11);
		PWMA_W12 := ram(PWMA_Wa12);
		
		PWMA_D1 := ram(PWMA_Du1);                     
		PWMA_D2 := ram(PWMA_Du2);                             
		PWMA_D3 := ram(PWMA_Du3);
		PWMA_D4 := ram(PWMA_Du4);
		PWMA_D5 := ram(PWMA_Du5);
		PWMA_D6 := ram(PWMA_Du6);
		PWMA_D7 := ram(PWMA_Du7);                     
		PWMA_D8 := ram(PWMA_Du8);                             
		PWMA_D9 := ram(PWMA_Du9);
		PWMA_D10 := ram(PWMA_Du10);
		PWMA_D11 := ram(PWMA_Du11);
		PWMA_D12 := ram(PWMA_Du12);	
										
                    xint2<='1';
                    count:= X"0000";
					flag <= '1';
					
    ELSif count > 500 then
		xint2<='0';    
		flag <='0';
    END IF;
           
   count:=count+1;

-- PWM generation **********************************************************
IF (PWMA_W1+PWMA_D1<=period) then   
	IF (count>=PWMA_W1 and count<=(PWMA_W1+PWMA_D1)) THEN
		 PWMA(0) <= '1';
	ELSE
		 PWMA(0) <= '0';
	END IF; 
else
	if (count<=(PWMA_W1+PWMA_D1-period) and (count>=0)) then
		PWMA(0) <= '1';
	elsif (count>(PWMA_W1+PWMA_D1-period) and count<PWMA_W1) then
		PWMA(0) <= '0';	
	else
		PWMA(0) <= '1';	
	end if;
end if;


IF (PWMA_W2+PWMA_D2<=period) then   
	IF (count>=PWMA_W2 and count<=(PWMA_W2+PWMA_D2)) THEN
		 PWMA(1) <= '1';
	ELSE
		 PWMA(1) <= '0';
	END IF; 
else
	if (count<=(PWMA_W2+PWMA_D2-period) and (count>=0)) then
		PWMA(1) <= '1';
	elsif (count>(PWMA_W2+PWMA_D2-period) and count<PWMA_W2) then
		PWMA(1) <= '0';	
	else
		PWMA(1) <= '1';	
	end if;
end if;

IF (PWMA_W3+PWMA_D3<=period) then   
	IF (count>=PWMA_W3 and count<=(PWMA_W3+PWMA_D3)) THEN
		 PWMA(2) <= '1';
	ELSE
		 PWMA(2) <= '0';
	END IF; 
else
	if (count<=(PWMA_W3+PWMA_D3-period) and (count>=0)) then
		PWMA(2) <= '1';
	elsif (count>(PWMA_W3+PWMA_D3-period) and count<PWMA_W3) then
		PWMA(2) <= '0';	
	else
		PWMA(2) <= '1';	
	end if;
end if;

IF (PWMA_W4+PWMA_D4<=period) then   
	IF (count>=PWMA_W4 and count<=(PWMA_W4+PWMA_D4)) THEN
		 PWMA(3) <= '1';
	ELSE
		 PWMA(3) <= '0';
	END IF; 
else
	if (count<=(PWMA_W4+PWMA_D4-period) and (count>=0)) then
		PWMA(3) <= '1';
	elsif (count>(PWMA_W4+PWMA_D4-period) and count<PWMA_W4) then
		PWMA(3) <= '0';	
	else
		PWMA(3) <= '1';	
	end if;
end if; 

IF (PWMA_W5+PWMA_D5<=period) then   
	IF (count>=PWMA_W5 and count<=(PWMA_W5+PWMA_D5)) THEN
		 PWMA(4) <= '1';
	ELSE
		 PWMA(4) <= '0';
	END IF; 
else
	if (count<=(PWMA_W5+PWMA_D5-period) and (count>=0)) then
		PWMA(4) <= '1';
	elsif (count>(PWMA_W5+PWMA_D5-period) and count<PWMA_W5) then
		PWMA(4) <= '0';	
	else
		PWMA(4) <= '1';	
	end if;
end if;

IF (PWMA_W5+PWMA_D5<=period) then   
	IF (count>=PWMA_W5 and count<=(PWMA_W5+PWMA_D5)) THEN
		 PWMA(5) <= '0';
	ELSE
		 PWMA(5) <= '1';
	END IF; 
else
	if (count<=(PWMA_W5+PWMA_D5-period) and (count>=0)) then
		PWMA(5) <= '0';
	elsif (count>(PWMA_W5+PWMA_D5-period) and count<PWMA_W5) then
		PWMA(5) <= '1';	
	else
		PWMA(5) <= '0';	
	end if;
end if;

--IF (PWMA_W6+PWMA_D6<=period) then   
--	IF (count>=PWMA_W6 and count<=(PWMA_W6+PWMA_D6)) THEN
--		 PWMA(5) <= '1';
--	ELSE
--		 PWMA(5) <= '0';
--	END IF; 
--else
--	if (count<=(PWMA_W6+PWMA_D6-period) and (count>=0)) then
--		PWMA(5) <= '1';
--	elsif (count>(PWMA_W6+PWMA_D6-period) and count<PWMA_W6) then
--		PWMA(5) <= '0';	
--	else
--		PWMA(5) <= '1';	
--	end if;
--end if;

IF (PWMA_W7+PWMA_D7<=period) then   
	IF (count>=PWMA_W7 and count<=(PWMA_W7+PWMA_D7)) THEN
		 PWMA(6) <= '1';
	ELSE
		 PWMA(6) <= '0';
	END IF; 
else
	if (count<=(PWMA_W7+PWMA_D7-period) and (count>=0)) then
		PWMA(6) <= '1';
	elsif (count>(PWMA_W7+PWMA_D7-period) and count<PWMA_W7) then
		PWMA(6) <= '0';	
	else
		PWMA(6) <= '1';	
	end if;
end if;

IF (PWMA_W8+PWMA_D8<=period) then   
	IF (count>=PWMA_W8 and count<=(PWMA_W8+PWMA_D8)) THEN
		 PWMA(7) <= '1';
	ELSE
		 PWMA(7) <= '0';
	END IF; 
else
	if (count<=(PWMA_W8+PWMA_D8-period) and (count>=0)) then
		PWMA(7) <= '1';
	elsif (count>(PWMA_W8+PWMA_D8-period) and count<PWMA_W8) then
		PWMA(7) <= '0';	
	else
		PWMA(7) <= '1';	
	end if;
end if;

IF (PWMA_W9+PWMA_D9<=period) then   
	IF (count>=PWMA_W9 and count<=(PWMA_W9+PWMA_D9)) THEN
		 PWMA(8) <= '0';
	ELSE
		 PWMA(8) <= '1';
	END IF; 
else
	if (count<=(PWMA_W9+PWMA_D9-period) and (count>=0)) then
		PWMA(8) <= '0';
	elsif (count>(PWMA_W9+PWMA_D9-period) and count<PWMA_W9) then
		PWMA(8) <= '1';	
	else
		PWMA(8) <= '0';	
	end if;
end if;

IF (PWMA_W10+PWMA_D10<=period) then   
	IF (count>=PWMA_W10 and count<=(PWMA_W10+PWMA_D10)) THEN
		 PWMA(9) <= '1';
	ELSE
		 PWMA(9) <= '0';
	END IF; 
else
	if (count<=(PWMA_W10+PWMA_D10-period) and (count>=0)) then
		PWMA(9) <= '1';
	elsif (count>(PWMA_W10+PWMA_D10-period) and count<PWMA_W10) then
		PWMA(9) <= '0';	
	else
		PWMA(9) <= '1';	
	end if;
end if;

IF (PWMA_W11+PWMA_D11<=period) then   
	IF (count>=PWMA_W11 and count<=(PWMA_W11+PWMA_D11)) THEN
		 PWMA(10) <= '1';
	ELSE
		 PWMA(10) <= '0';
	END IF; 
else
	if (count<=(PWMA_W11+PWMA_D11-period) and (count>=0)) then
		PWMA(10) <= '1';
	elsif (count>(PWMA_W11+PWMA_D11-period) and count<PWMA_W11) then
		PWMA(10) <= '0';	
	else
		PWMA(10) <= '1';	
	end if;
end if;

IF (PWMA_W12+PWMA_D12<=period) then   
	IF (count>=PWMA_W12 and count<=(PWMA_W12+PWMA_D12)) THEN
		 PWMA(11) <= '1';
	ELSE
		 PWMA(11) <= '0';
	END IF; 
else
	if (count<=(PWMA_W12+PWMA_D12-period) and (count>=0)) then
		PWMA(11) <= '1';
	elsif (count>(PWMA_W12+PWMA_D12-period) and count<PWMA_W12) then
		PWMA(11) <= '0';	
	else
		PWMA(11) <= '1';	
	end if;
end if;

end if;

END PROCESS main;


end rtl;
