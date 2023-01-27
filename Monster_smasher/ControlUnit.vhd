
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity ControlUnit is
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
end ControlUnit;

architecture Behavioral of ControlUnit is

    type Control_State is (Idle,Setup,Start,Waiting);  -- Define the states
	signal State : Control_State;
	
	signal round_int : std_logic_vector(5 downto 0);
	signal start_compression_int : std_logic;
	signal Mem_wren_int : std_logic;
    signal Mem_rden_int : std_logic;
    signal Mem_rAddress_int : std_logic_vector(6 downto 0);

begin

    round_out <= round_int;
    start_compression_out <= start_compression_int;
    Mem_rden_out <= Mem_rden_int;
    Mem_rAddress_out <= Mem_rAddress_int;

    process(clk)
	begin
	  if rising_edge(clk) then 
	    if reset = '0' then
           --Outputs
	       round_int <= (others => '0');
	       start_compression_int <= '0';
	       Mem_wren_int <= '0';
           Mem_rden_int <= '0';
           Mem_rAddress_int <= (others => '0');
           --Counters
           
           --FlipFlops
           
           --State
           State <= Idle;
           
	    else
	    
	       case State is
	           when Idle =>
	           
	             round_int <= "000000";  
	             if( start_smashing_in = '1' ) then
	               State <= Setup;
	             else
	               State <= Idle;
	             end if;
	             
	           when Setup =>
	           
	               --Read AXI mem Protocol
	               if( Mem_rden_int = '0' ) then
	                   Mem_rden_int <= '1';
	                   Mem_rAddress_int(5 downto 0) <= round_int;
	                   State <= Setup;
	               else
	                   Mem_rden_int <= '0';
	                   Mem_rAddress_int(5 downto 0) <= "000000";
	                   State <= Start;
	               end if;
	           
	           when Start =>
	           
	               start_compression_int <= '1';
	               State <= Waiting;
	           
	           when Waiting =>
	               
	               start_compression_int <= '0';
	               if( end_round_in = '1' and end_compression_in = '0' ) then
                        round_int <= round_int + 1;
                        State <= Setup;
                   elsif( end_round_in = '0' and end_compression_in = '1' ) then
                        round_int <= "000000";
                        State <= Idle;
	               end if;
	               
	           when others =>
	               State <= Idle;
	       end case;
	          
	    end if;
	end if;
	       
	end process;

end Behavioral;
