
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MonsterSmasher is
Port ( 
    clk : in std_logic;
    reset : in std_logic;
    
    --Memory Interfaces
    Data_in : in std_logic_vector(31 downto 0);
    Start_Smashing_in : in std_logic;
    
    Mem_wren_out : out std_logic;
    Mem_rden_out : out std_logic;
    
    Mem_rAddress_out : out std_logic_vector(6 downto 0);
    Mem_wAddress_out : out std_logic_vector(6 downto 0);
    Digest_out : out std_logic_vector(31 downto 0)

);
end MonsterSmasher;

architecture Behavioral of MonsterSmasher is

    component Compressor is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        
        MemH_in : in std_logic_vector(31 downto 0);
    
        --Mem Interfaces
        MemW_in : in std_logic_vector(31 downto 0);
        MemK_in : in std_logic_vector(31 downto 0);
        
        ROM_addr_out : out std_logic_vector(3 downto 0);
        
        Mem_wren_out : out std_logic;
        Mem_wAddress_out : out std_logic_vector(6 downto 0);
        
        --Control Signals
        Start_in : in std_logic;
        Round_in : in std_logic_vector(5 downto 0);
        End_Round_out : out std_logic;
        End_Compression_out : out std_logic;
        
        --Data out
        RAM_Data_out : out std_logic_vector(31 downto 0)
    );
    end component;
    
    component ControlUnit is
    Port ( 
        clk : in std_logic;
        reset : in std_logic;
        
        start_smashing_in : in std_logic;
        end_round_in : in std_logic;
        end_compression_in : in std_logic;
        
        Mem_rden_out : out std_logic;
        
        Mem_rAddress_out : out std_logic_vector(6 downto 0);
        
        start_compression_out : out std_logic;
        round_out : out std_logic_vector(5 downto 0)
        
    );
    end component;
    
    component ROM_K is
    Port ( 
        Address_in : in std_logic_vector(5 downto 0);
        Data_out : out std_logic_vector(31 downto 0)
    );
    end component;
    
    component ROM_H is
    Port ( 
        Address_in : in std_logic_vector(2 downto 0);
        Data_out : out std_logic_vector(31 downto 0)
    );
    end component;
    
    signal ROM_H_Data_int : std_logic_vector(31 downto 0);
    signal ROM_K_Data_int : std_logic_vector(31 downto 0);
    
    signal ROM_H_Addr_int : std_logic_vector(3 downto 0);
    
    signal start_compression_int : std_logic;
    signal end_compression_int : std_logic;
    signal end_round_int : std_logic;
    
    signal round_int : std_logic_vector(5 downto 0);
    
    signal Digest_int : std_logic_vector(31 downto 0);

begin

    Digest_out <= Digest_int;
    
    Comp : Compressor port
    map(
        clk => clk,
        reset => reset,
        
        MemH_in => ROM_H_Data_int,
    
        --Mem Interfaces
        MemW_in => Data_in,
        MemK_in => ROM_K_Data_int,
        
        ROM_addr_out => ROM_H_Addr_int,
        Mem_wren_out => Mem_wren_out,
        Mem_wAddress_out => Mem_wAddress_out,
        
        --Control Signals
        Start_in => start_compression_int,
        Round_in => round_int,
        End_Round_out => end_round_int,
        End_Compression_out => end_compression_int,
        
        --Data out
        RAM_Data_out => Digest_int
    );
    
    CU : ControlUnit port
    map( 
        clk => clk,
        reset => reset,
        
        start_smashing_in => start_smashing_in,
        end_round_in => end_round_int,
        end_compression_in => end_compression_int,
        
        Mem_rden_out => Mem_rden_out,
        
        Mem_rAddress_out => Mem_rAddress_out,
        
        start_compression_out => start_compression_int,
        round_out => round_int
        
    );
    
    Rk : ROM_K port
    map( 
        Address_in => round_int, --AKA ROM_K_Addr_int
        Data_out => ROM_K_Data_int
    );
 
    Rh : ROM_H port
    map(  
        Address_in => ROM_H_Addr_int(2 downto 0),
        Data_out => ROM_H_Data_int
    );
    
end Behavioral;
