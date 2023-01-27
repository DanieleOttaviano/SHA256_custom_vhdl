
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity ROM_H is
Port ( 
    Address_in : in std_logic_vector(2 downto 0);
    Data_out : out std_logic_vector(31 downto 0)
);
end ROM_H;

architecture Behavioral of ROM_H is

    --signal Data_int : std_logic_vector(31 downto 0);
    signal Memory : std_logic_vector((32*8)-1 downto 0) := x"5be0cd191f83d9ab9b05688c510e527fa54ff53a3c6ef372bb67ae856a09e667";

begin

    Data_out <= Memory(32*to_integer(unsigned(Address_in))-1+32 downto 32*to_integer(unsigned(Address_in)));
    --Data_out <= x"00000000";
    
end Behavioral;
