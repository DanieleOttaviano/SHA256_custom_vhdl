
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MonsterSmasher_TB is
end MonsterSmasher_TB;

architecture Behavioral of MonsterSmasher_TB is

    component MonsterSmasher is
    Port ( 
        clk : in std_logic;
        reset : in std_logic;
        
        --Memory Interfaces
        Data_in : in std_logic_vector(31 downto 0);
        Start_Smashing_in : in std_logic;
        
        Mem_wren_out : out std_logic;
        Mem_rden_out : out std_logic;
        
        Mem_Address_out : out std_logic_vector(6 downto 0);
        Digest_out : out std_logic_vector(31 downto 0)
    
    );
    end component;
    
    signal s_clk : std_logic;
    signal s_reset : std_logic;

    signal s_Data_in : std_logic_vector(31 downto 0) := x"0f0f0f0f";
    signal s_Start_Smashing_in : std_logic := '0';
    signal s_Mem_wren_out : std_logic := '0';
    signal s_Mem_rden_out : std_logic := '0';
        
    signal s_Mem_Address_out : std_logic_vector(6 downto 0) := "0000000" ;    
    signal s_Digest_out : std_logic_vector(31 downto 0);
    
begin

    uut : MonsterSmasher port
    map( 
        clk => s_clk,
        reset => s_reset,
        
        --Memory Interfaces
        Data_in => s_Data_in,
        Start_Smashing_in => s_start_smashing_in,
        Mem_wren_out => s_Mem_wren_out,
        Mem_rden_out => s_Mem_rden_out,
        
        Mem_Address_out => s_Mem_Address_out,
        
        Digest_out => s_Digest_out
    
    );

    tb : process
    begin
    
        s_reset <= '0';
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_reset <='1';
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;  
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_Start_Smashing_in <= '1';
                
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_Start_Smashing_in <= '0';
        
        for I in 1 to 26*1 loop
            s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        END LOOP;
        
    wait;
    end process;     

end Behavioral;
