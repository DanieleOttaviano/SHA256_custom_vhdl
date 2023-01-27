library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SRAM_tb is
end SRAM_tb;

architecture Behavioral of SRAM_tb is

    component SRAM is
    Port ( 
    
        clk : in std_logic;
        reset : in std_logic;
        
        Address_in : in std_logic_vector(2 downto 0);
        Data_in : in std_logic_vector(31 downto 0);
        
        wr_en_in : in std_logic;
        rd_en_in : in std_logic;
        
        Data_out : out std_logic_vector(31 downto 0)
    
    );
    end component;
    
    signal s_clk : std_logic := '0';
    signal s_reset : std_logic := '0';       
    signal s_Address_in : std_logic_vector(2 downto 0) := "000";
    signal s_Data_in : std_logic_vector(31 downto 0) := x"00000000";     
    signal s_wr_en_in : std_logic := '0';
    signal s_rd_en_in : std_logic := '0'; 
    signal s_Data_out : std_logic_vector(31 downto 0);

begin

    uut : SRAM port
    map(
        clk => s_clk,
        reset => s_reset,
        Address_in => s_Address_in,
        Data_in => s_Data_in,
        wr_en_in => s_wr_en_in,
        rd_en_in => s_rd_en_in,
        Data_out => s_Data_out
    );
    
    
    tb : process
    begin
    
        s_reset <= '0';
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_reset <='1';
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;  
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_wr_en_in <= '1';
        s_Address_in <= "000";
        s_Data_in <= x"1111ffff";
        
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_wr_en_in <= '0';
        
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_rd_en_in <= '1';
        s_Address_in <= "000";
        
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_rd_en_in <= '0';
        
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_wr_en_in <= '1';
        s_Address_in <= "111";
        s_Data_in <= x"abab0101";
        
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_wr_en_in <= '0';
        
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_rd_en_in <= '1';
        s_Address_in <= "111";
        
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_rd_en_in <= '0';
        
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
    wait;
    end process;     

end Behavioral;
