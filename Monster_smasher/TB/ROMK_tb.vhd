
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ROMK_tb is
end ROMK_tb;

architecture Behavioral of ROMK_tb is

    component ROM_K is
    Port ( 
        Address_in : in std_logic_vector(5 downto 0);
        Data_out : out std_logic_vector(31 downto 0)
    );
    end component;
    
    signal s_Address_in : std_logic_vector(5 downto 0) := "000000";
    signal s_Data_out : std_logic_vector(31 downto 0);

begin

    uut : ROM_K port
    map(
        Address_in => s_Address_in,
        Data_out => s_Data_out 
    );
    
    
    tb : process
    begin
    
        s_Address_in <= "000000";
        wait for 10 ns;
        
        s_Address_in <= "000001";
        wait for 10 ns;
        
        s_Address_in <= "000010";
        wait for 10 ns;
        
        s_Address_in <= "000011";
        wait for 10 ns;
        
        s_Address_in <= "000100";
        wait for 10 ns;
        
        s_Address_in <= "000101";
        wait for 10 ns;
        
        s_Address_in <= "000110";
        wait for 10 ns;
        
        s_Address_in <= "000111";
        wait for 10 ns;
        
        s_Address_in <= "111111";
        wait for 10 ns;
        
    wait;
    end process;
    
    


end Behavioral;
