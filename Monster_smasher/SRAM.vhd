
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity SRAM is
Port ( 

    clk : in std_logic;
    reset : in std_logic;
    
    Address_in : in std_logic_vector(2 downto 0);
    Data_in : in std_logic_vector(31 downto 0);
    
    wr_en_in : in std_logic;
    rd_en_in : in std_logic;
    
    Data_out : out std_logic_vector(31 downto 0)

);
end SRAM;

architecture Behavioral of SRAM is

    signal Data_int : std_logic_vector(31 downto 0);
    signal Memory : std_logic_vector((32*8)-1 downto 0);

begin

    Data_out <= Data_int;

    process(clk)
	begin
	  if rising_edge(clk) then 
	    if reset = '0' then
	       Memory <= (others => '0');
	       Data_int <= (others => '0');
	    elsif( wr_en_in = '1' )then
	       Memory(32*to_integer(unsigned(Address_in))-1+32 downto 32*to_integer(unsigned(Address_in))) <= Data_in;
	    elsif( rd_en_in = '1') then
	       Data_int <= Memory(32*to_integer(unsigned(Address_in))-1+32 downto 32*to_integer(unsigned(Address_in)));
	    end if;
	end if;
	       
	end process;

end Behavioral;
