
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Compressor_tb is
end Compressor_tb;

architecture Behavioral of Compressor_tb is

    component Compressor is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        
        RAM_Data_in : in std_logic_vector(31 downto 0);
    
        --Mem Interfaces
        MemW_in : in std_logic_vector(31 downto 0);
        MemK_in : in std_logic_vector(31 downto 0);
        MemH_in : in std_logic_vector(31 downto 0);
        
        RAM_addr_out : out std_logic_vector(3 downto 0);
        RAM_wr_en_out : out std_logic;
        RAM_rd_en_out : out std_logic;
        
        --Control Signals
        Start_in : in std_logic;
        Round_in : in std_logic;
        End_Round_out : out std_logic;
        End_Compression_out : out std_logic;
        
        --Data out
        RAM_Data_out : out std_logic_vector(31 downto 0)
    );
    end component;
    
    signal s_clk : std_logic;
    signal s_reset : std_logic;
    
    signal s_RAM_Data_in : std_logic_vector(31 downto 0) := x"00000000";

    signal s_MemW_in : std_logic_vector(31 downto 0) := x"00000000";
    signal s_MemK_in : std_logic_vector(31 downto 0) := x"00000000";
    signal s_MemH_in : std_logic_vector(31 downto 0) := x"00000000";
    
    signal s_RAM_addr_out : std_logic_vector(3 downto 0);
    signal s_RAM_wr_en_out : std_logic;
    signal s_RAM_rd_en_out : std_logic;
        
    signal s_Start_in : std_logic;
    signal s_Round_in : std_logic;
    signal s_End_Round_out : std_logic;
    signal s_End_Compression_out : std_logic;
       
    signal s_RAM_Data_out : std_logic_vector(31 downto 0) := x"00000000";  

begin
    
    uut : Compressor port
    map(
        clk => s_clk,
        reset => s_reset,
        
        RAM_Data_in => s_RAM_Data_in,
        
        MemW_in => s_MemW_in,
        MemK_in => s_MemK_in,
        MemH_in => s_MemH_in,
        
        RAM_addr_out => s_RAM_addr_out,
        RAM_wr_en_out => s_RAM_wr_en_out,
        RAM_rd_en_out => s_RAM_rd_en_out,
        
        Start_in => s_Start_in,
        Round_in => s_Round_in,
        End_Round_out => s_End_Round_out,
        End_Compression_out => s_End_Compression_out,
        
        RAM_Data_out => s_RAM_Data_out
    );
    
    tb : process
    begin
    
        s_reset <= '0';
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_reset <='1';
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_start_in <= '1';
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_start_in <= '0';
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_RAM_Data_in <= x"0f0f0f0f";  
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
        s_clk <= '1'; wait for 5 ns; s_clk <= '0'; wait for 5 ns;
        
    wait;
    end process;   

end Behavioral;
