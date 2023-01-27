
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Peripheral_lite_TB is
end Peripheral_lite_TB;

architecture Behavioral of Peripheral_lite_TB is

    component IP_SHA_Accelerator_lite_v1_0 is
        generic (
            -- Users to add parameters here
    
            -- User parameters ends
            -- Do not modify the parameters beyond this line
    
    
            -- Parameters of Axi Slave Bus Interface S00_AXI
            C_S00_AXI_DATA_WIDTH	: integer	:= 32;
            C_S00_AXI_ADDR_WIDTH	: integer	:= 9
        );
        port (
            -- Users to add ports here
    
            -- User ports ends
            -- Do not modify the ports beyond this line
    
    
            -- Ports of Axi Slave Bus Interface S00_AXI
            s00_axi_aclk	: in std_logic;
            s00_axi_aresetn	: in std_logic;
            s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
            s00_axi_awprot	: in std_logic_vector(2 downto 0);
            s00_axi_awvalid	: in std_logic;
            s00_axi_awready	: out std_logic;
            s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
            s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
            s00_axi_wvalid	: in std_logic;
            s00_axi_wready	: out std_logic;
            s00_axi_bresp	: out std_logic_vector(1 downto 0);
            s00_axi_bvalid	: out std_logic;
            s00_axi_bready	: in std_logic;
            s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
            s00_axi_arprot	: in std_logic_vector(2 downto 0);
            s00_axi_arvalid	: in std_logic;
            s00_axi_arready	: out std_logic;
            s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
            s00_axi_rresp	: out std_logic_vector(1 downto 0);
            s00_axi_rvalid	: out std_logic;
            s00_axi_rready	: in std_logic
        );
    end component;
            
    signal s_s00_axi_aclk	:  std_logic;
    signal s_s00_axi_aresetn :  std_logic;
    signal s_s00_axi_awaddr	:  std_logic_vector(9-1 downto 0) := "000000000";
    signal s_s00_axi_awprot	:  std_logic_vector(2 downto 0) := "000";
    signal s_s00_axi_awvalid :  std_logic := '0';
    signal s_s00_axi_awready :  std_logic := '0';
    signal s_s00_axi_wdata	:  std_logic_vector(32-1 downto 0) := x"00000000";
    signal s_s00_axi_wstrb	:  std_logic_vector((32/8)-1 downto 0) := x"f";
    signal s_s00_axi_wvalid	:  std_logic := '0';
    signal s_s00_axi_wready	:  std_logic := '0';
    signal s_s00_axi_bresp	:  std_logic_vector(1 downto 0) := "00";
    signal s_s00_axi_bvalid	:  std_logic := '0';
    signal s_s00_axi_bready	:  std_logic := '0';
    signal s_s00_axi_araddr	:  std_logic_vector(9-1 downto 0) := "000000000";
    signal s_s00_axi_arprot	:  std_logic_vector(2 downto 0) := "000";
    signal s_s00_axi_arvalid :  std_logic := '0';
    signal s_s00_axi_arready :  std_logic := '0';
    signal s_s00_axi_rdata	:  std_logic_vector(32-1 downto 0) := x"00000000";
    signal s_s00_axi_rresp	:  std_logic_vector(1 downto 0) := "00";
    signal s_s00_axi_rvalid	:  std_logic := '0';
    signal s_s00_axi_rready	:  std_logic := '0';
    
    signal W : std_logic_vector((32*64)-1 downto 0) := (others => '0');

begin

    uut : IP_SHA_Accelerator_lite_v1_0 port
    map(
        s00_axi_aclk => s_s00_axi_aclk,
        s00_axi_aresetn => s_s00_axi_aresetn,
        s00_axi_awaddr	=> s_s00_axi_awaddr,
        s00_axi_awprot	=> s_s00_axi_awprot,
        s00_axi_awvalid	=> s_s00_axi_awvalid,
        s00_axi_awready	=> s_s00_axi_awready,
        s00_axi_wdata	=> s_s00_axi_wdata,
        s00_axi_wstrb	=> s_s00_axi_wstrb,
        s00_axi_wvalid	=> s_s00_axi_wvalid,
        s00_axi_wready	=> s_s00_axi_wready,
        s00_axi_bresp	=> s_s00_axi_bresp,
        s00_axi_bvalid	=> s_s00_axi_bvalid,
        s00_axi_bready	=> s_s00_axi_bready,
        s00_axi_araddr	=> s_s00_axi_araddr,
        s00_axi_arprot	=> s_s00_axi_arprot,
        s00_axi_arvalid	=> s_s00_axi_arvalid,
        s00_axi_arready	=> s_s00_axi_arready,
        s00_axi_rdata	=> s_s00_axi_rdata,
        s00_axi_rresp	=> s_s00_axi_rresp,
        s00_axi_rvalid	=> s_s00_axi_rvalid,
        s00_axi_rready	=> s_s00_axi_rready
    );
    
    tb : process
    begin
        --1 ||Reset||
        s_s00_axi_aresetn <= '0';
        s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
        s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
        
        s_s00_axi_aresetn <='1';
        s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
        
        --2 ||WRITE the array W without burst||  
        for I in 1 to 64 loop
            --Address Handshake
                s_s00_axi_awaddr <= "000000000" + 4*(I-1);
                s_s00_axi_awvalid <= '1';
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_awvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
             
            --Data Handshake             
                s_s00_axi_bready <= '1';
                         
                W((32*I)-1 downto 32*(I-1)) <= W((32*I)-1 downto 32*(I-1)) + 4*I;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                    
                s_s00_axi_wdata <= W((32*I)-1 downto 32*(I-1));
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0'; 
            
            --Write End        
                for I in 1 to 5 loop
                    s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                end loop;
                
                s_s00_axi_bready <= '0';
        END LOOP;          
                
        --||READ THE MONSTER||
        --for I in 1 to 64 loop
        --Protocol
            --Address Handshake
        --        s_s00_axi_araddr <= "000000000" + 4*(I-1);
        --        s_s00_axi_arvalid <= '1';
                
        --        s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
        --        s_s00_axi_arvalid <= '0';
                
        --        s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
            --Data Handshake 1    
                
        --        s_s00_axi_rready <= '1';
                
        --        for j in 1 to 2 loop
        --            s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
        --        end loop;
                
        --        s_s00_axi_rready <= '0';
        --   END LOOP; 
         
       -- 3 ||WRITE ON CR REGISTER|| 
            --Address Handshake
                s_s00_axi_awaddr <= "100100000";
                s_s00_axi_awvalid <= '1';
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_awvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
            --Data Handshake            
                s_s00_axi_bready <= '1';
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                    
                s_s00_axi_wdata <= x"00000001";
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0'; 
            
            --Write End 
                for I in 1 to 5 loop
                    s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                end loop;
                
                s_s00_axi_bready <= '0'; 
                
         -- 4 ||WAIT FOR DIGEST TO BE PRODUCED||     
         for I in 1 to 1200 loop
            s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
         END LOOP;
         
         -- 5 ||READ THE DIGEST||
          for I in 1 to 8 loop
            --Address Handshake
                s_s00_axi_araddr <= "100000000" + 4*(I-1);
                s_s00_axi_arvalid <= '1';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
               -- s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_arvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
             
            --Data Handshake             
                s_s00_axi_rready <= '1';                   
                for I in 1 to 2 loop
                    s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                end loop;                  
                s_s00_axi_rready <= '0';
                
        END LOOP;
        
        for I in 1 to 5 loop
            s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
        end loop;
    wait;    
    end process;     
    
end Behavioral;