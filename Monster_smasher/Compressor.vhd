
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity Compressor is
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
end Compressor;

architecture Behavioral of Compressor is
    
    type Compressor_State is (Idle,Op1,Op2,Assign,Evaluate,Finish);  -- Define the states
	signal State : Compressor_State; 
    
    --OUT signal mapping
    signal End_Round_int : std_logic;
    signal End_Compression_int : std_logic;

    signal ROM_addr_int : std_logic_vector(3 downto 0);
    signal RAM_Data_int : std_logic_vector(31 downto 0);
    
    signal Mem_wren_int : std_logic;
    signal Mem_wAddress_int : std_logic_vector(6 downto 0);
    
    --Counters

    signal WriteRamCounter : std_logic_vector(3 downto 0);
    signal ReadRomCounter : std_logic_vector(3 downto 0);
    signal AssignCounter : std_logic_vector(3 downto 0);
    
    --Flip Flops
    
    signal StartFF : std_logic;
    
    --Internal Register
    
    signal A_int : std_logic_vector(31 downto 0);
    signal B_int : std_logic_vector(31 downto 0);
    signal C_int : std_logic_vector(31 downto 0);
    signal D_int : std_logic_vector(31 downto 0);
    signal E_int : std_logic_vector(31 downto 0);
    signal F_int : std_logic_vector(31 downto 0);
    signal G_int : std_logic_vector(31 downto 0);
    signal H_int : std_logic_vector(31 downto 0);
    
    signal R0 : std_logic_vector(31 downto 0); --Rotate Register 0
    signal R1 : std_logic_vector(31 downto 0); --Rotate Register 1
    signal R2 : std_logic_vector(31 downto 0); --Rotate Register 2
    signal R3 : std_logic_vector(31 downto 0); --Rotate Register 3
    signal R4 : std_logic_vector(31 downto 0); --Rotate Register 4
    signal R5 : std_logic_vector(31 downto 0); --Rotate Register 5
    
    signal S0 : std_logic_vector(31 downto 0); --Rotated and Xored Reg 0
    signal S1 : std_logic_vector(31 downto 0); --Rotated and Xored Reg 1
    signal ch : std_logic_vector(31 downto 0); --Xored Reg 0
    signal naj : std_logic_vector(31 downto 0); --Xored Reg 1
    
    signal temp0 : std_logic_vector(31 downto 0); --Temp Reg 0
    signal temp1 : std_logic_vector(31 downto 0); --Temp Reg 1
    
    --Internal Signals
    
    
begin
    
    End_Round_out <= End_Round_int;
    End_Compression_out <= End_Compression_int;
    
    RAM_Data_out <= RAM_Data_int;
    Mem_wAddress_out <= Mem_wAddress_int;
    Mem_wren_out <= Mem_wren_int;
    ROM_addr_out <= ROM_addr_int;

    process(clk)
	begin
	  if rising_edge(clk) then 
	    if reset = '0' then
           --Outputs
	       End_Round_int <= '0';
           End_Compression_int <= '0';
           Mem_wren_int <= '0';
           Mem_wAddress_int <= "0000000";
    
           A_int <= x"00000000";
           B_int <= x"00000000";
           C_int <= x"00000000";
           D_int <= x"00000000";
           E_int <= x"00000000";
           F_int <= x"00000000";
           G_int <= x"00000000";
           H_int <= x"00000000";
           
           R0 <= (others => '0');
           R1 <= (others => '0');
           R2 <= (others => '0');
           R3 <= (others => '0');
           R4 <= (others => '0');
           R5 <= (others => '0');
           S0 <= (others => '0');
           S1 <= (others => '0');
           naj <= (others => '0');
           ch <= (others => '0');
           
           ROM_addr_int <= (others => '0');
           RAM_Data_int <= (others => '0');
           
           --Counters
           WriteRamCounter <= (others => '0');
           ReadRomCounter <= (others => '0');
           AssignCounter <= (others => '0');
           
           --FlipFlops
           StartFF <= '0';
           
           --State
           State <= Idle;
           
	    else
	    
	       case State is
	           when Idle =>
	               
	               End_Round_int <= '0';
	               End_Compression_int <= '0';
	               
	               if( Start_in = '1' and StartFF = '0' ) then --Catch Start Event
	               
	                   StartFF <= '1'; 
	                   ROM_addr_int <= "0000";
	                   
	               elsif( StartFF = '1') then
	                  
                      if( ReadRomCounter < 8+1 and Round_in = "000000" ) then
                        
                        ReadRomCounter <= ReadRomCounter + 1;
     
                        case ReadRomCounter is
                            when "0000" => A_int <=MemH_in; ROM_addr_int <= "0001";
                            when "0001" => B_int <=MemH_in; ROM_addr_int <= "0010";
                            when "0010" => C_int <=MemH_in; ROM_addr_int <= "0011";
                            when "0011" => D_int <=MemH_in; ROM_addr_int <= "0100";
                            when "0100" => E_int <=MemH_in; ROM_addr_int <= "0101";
                            when "0101" => F_int <=MemH_in; ROM_addr_int <= "0110";
                            when "0110" => G_int <=MemH_in; ROM_addr_int <= "0111";
                            when "0111" => H_int <=MemH_in; ROM_addr_int <= "0000";
                            when others => ROM_addr_int <= "0000";     
                        end case;
                        
                      else

	                    ReadRomCounter <= "0000";
	                    
                        --Rx(31-N downto 0) <= y_in(31 downto N);
	                    --Rx(31 downto 31-(N-1)) <= y_in(N-1 downto 0);
	                  
	                    --Init the Rotate Registers
                        R0(25 downto 0) <= E_int(31 downto 6);
                        R0(31 downto 26) <= E_int(5 downto 0);
                       
                        R1(20 downto 0) <= E_int(31 downto 11);
                        R1(31 downto 21) <= E_int(10 downto 0);
                       
                        R2(31-25 downto 0) <= E_int(31 downto 25);
                        R2(31 downto 31-(25-1)) <= E_int(25-1 downto 0);
                       
                        R3(31-2 downto 0) <= A_int(31 downto 2);
                        R3(31 downto 31-(2-1)) <= A_int(2-1 downto 0);
                           
                        R4(31-13 downto 0) <= A_int(31 downto 13);
                        R4(31 downto 31-(13-1)) <= A_int(13-1 downto 0);
                           
                        R5(31-22 downto 0) <= A_int(31 downto 22);
                        R5(31 downto 31-(22-1)) <= A_int(22-1 downto 0);   
                        
                        StartFF <= '0';  
                        State <= Op1;
                          
                       end if;
                       
	               else
	                  State <= Idle;
	               end if;
	               
	           when Op1 =>
	               
	               for i in 0 to 31 loop
                        S1(i) <= R0(i) xor R1(i) xor R2(i);
                        S0(i) <= R3(i) xor R4(i) xor R5(i);
                        ch(i) <= (E_int(i) and F_int(i)) xor ((not E_int(i)) and G_int(i));
                        naj(i) <=  (A_int(i) and B_int(i)) xor (A_int(i) and C_int(i)) xor (B_int(i) and C_int(i));      
                   end loop;
	               
	               State <= Op2;
	               
	           when Op2 =>
	               
	               Temp0 <= H_int + S1 + ch + MemK_in + MemW_in;
	               Temp1 <= S0 + naj;
	               
	               State <= Assign;
	               
	           when Assign =>
	           
	               if( AssignCounter < (8) ) then
                        
                        AssignCounter <= AssignCounter + 1;
     
                        case AssignCounter is
                            when "0000" => H_int <= G_int;
                            when "0001" => G_int <= F_int;
                            when "0010" => F_int <= E_int;
                            when "0011" => E_int <= D_int + Temp0;
                            when "0100" => D_int <= C_int;
                            when "0101" => C_int <= B_int;
                            when "0110" => B_int <= A_int;
                            when "0111" => A_int <= Temp0 + Temp1; 
                            when others => AssignCounter <= "0000";    
                        end case;
                        
                        State <= Assign;
                   else
                        AssignCounter <= "0000";  
                        State <= Evaluate;
                   end if;
	               
	           when Evaluate =>
	               
	               if( Round_in < 63 ) then
	                   State <= Idle;
	                   End_Round_int <= '1';
	               else
	                   State <= Finish;
	               end if;
	               
	           when Finish =>
	               
	               if( WriteRamCounter < (9) ) then
                        
                        Mem_wren_int <= '1';
                        WriteRamCounter <= WriteRamCounter + 1;
     
                        case WriteRamCounter is
                            when "0000" => Mem_wAddress_int <= "1000000"; RAM_Data_int <= A_int + MemH_in; ROM_addr_int <= "0000" ; --0x40
                            when "0001" => Mem_wAddress_int <= "1000001"; RAM_Data_int <= B_int + MemH_in; ROM_addr_int <= "0001" ;--0x41
                            when "0010" => Mem_wAddress_int <= "1000010"; RAM_Data_int <= C_int + MemH_in; ROM_addr_int <= "0010" ;--0x42
                            when "0011" => Mem_wAddress_int <= "1000011"; RAM_Data_int <= D_int + MemH_in; ROM_addr_int <= "0011" ;--0x43
                            when "0100" => Mem_wAddress_int <= "1000100"; RAM_Data_int <= E_int + MemH_in; ROM_addr_int <= "0100" ;--0x44
                            when "0101" => Mem_wAddress_int <= "1000101"; RAM_Data_int <= F_int + MemH_in; ROM_addr_int <= "0101" ;--0x45
                            when "0110" => Mem_wAddress_int <= "1000110"; RAM_Data_int <= G_int + MemH_in; ROM_addr_int <= "0110" ;--0x46
                            when "0111" => Mem_wAddress_int <= "1000111"; RAM_Data_int <= H_int + MemH_in; ROM_addr_int <= "0111" ;--0x47
                            when "1000" => Mem_wAddress_int <= "1001001"; RAM_Data_int <= x"00000001";--0x49 Status Register
                            when others => Mem_wAddress_int <= "1111111";
                        end case;
                        
                        State <= Finish;
                   else
                        Mem_wren_int <= '0'; 
                        End_Compression_int <= '1';
	                    State <= Idle;
                        
                   end if;
	               
	           when others =>
	               State <= Idle;
	       end case;
	       
	       
	    end if;
	end if;
	       
	end process;
	
	--StateDebug <= "000" WHEN State=Idle;
	
end Behavioral;
