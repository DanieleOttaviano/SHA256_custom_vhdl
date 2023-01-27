
library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Peripheral_TB is
end Peripheral_TB;

architecture Behavioral of Peripheral_TB is

    component IP_SHA_Accelerator_v1_0 is
        generic (
            C_S00_AXI_ID_WIDTH	: integer	:= 1;
            C_S00_AXI_DATA_WIDTH	: integer	:= 32;
            C_S00_AXI_ADDR_WIDTH	: integer	:= 9;
            C_S00_AXI_AWUSER_WIDTH	: integer	:= 0;
            C_S00_AXI_ARUSER_WIDTH	: integer	:= 0;
            C_S00_AXI_WUSER_WIDTH	: integer	:= 0;
            C_S00_AXI_RUSER_WIDTH	: integer	:= 0;
            C_S00_AXI_BUSER_WIDTH	: integer	:= 0
        );
        port (
            s00_axi_aclk	: in std_logic;
            s00_axi_aresetn	: in std_logic;
            s00_axi_awid	: in std_logic_vector(C_S00_AXI_ID_WIDTH-1 downto 0);
            s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
            s00_axi_awlen	: in std_logic_vector(7 downto 0);
            s00_axi_awsize	: in std_logic_vector(2 downto 0);
            s00_axi_awburst	: in std_logic_vector(1 downto 0);
            s00_axi_awlock	: in std_logic;
            s00_axi_awcache	: in std_logic_vector(3 downto 0);
            s00_axi_awprot	: in std_logic_vector(2 downto 0);
            s00_axi_awqos	: in std_logic_vector(3 downto 0);
            s00_axi_awregion	: in std_logic_vector(3 downto 0);
            s00_axi_awuser	: in std_logic_vector(C_S00_AXI_AWUSER_WIDTH-1 downto 0);
            s00_axi_awvalid	: in std_logic;
            s00_axi_awready	: out std_logic;
            s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
            s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
            s00_axi_wlast	: in std_logic;
            s00_axi_wuser	: in std_logic_vector(C_S00_AXI_WUSER_WIDTH-1 downto 0);
            s00_axi_wvalid	: in std_logic;
            s00_axi_wready	: out std_logic;
            s00_axi_bid	: out std_logic_vector(C_S00_AXI_ID_WIDTH-1 downto 0);
            s00_axi_bresp	: out std_logic_vector(1 downto 0);
            s00_axi_buser	: out std_logic_vector(C_S00_AXI_BUSER_WIDTH-1 downto 0);
            s00_axi_bvalid	: out std_logic;
            s00_axi_bready	: in std_logic;
            s00_axi_arid	: in std_logic_vector(C_S00_AXI_ID_WIDTH-1 downto 0);
            s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
            s00_axi_arlen	: in std_logic_vector(7 downto 0);
            s00_axi_arsize	: in std_logic_vector(2 downto 0);
            s00_axi_arburst	: in std_logic_vector(1 downto 0);
            s00_axi_arlock	: in std_logic;
            s00_axi_arcache	: in std_logic_vector(3 downto 0);
            s00_axi_arprot	: in std_logic_vector(2 downto 0);
            s00_axi_arqos	: in std_logic_vector(3 downto 0);
            s00_axi_arregion	: in std_logic_vector(3 downto 0);
            s00_axi_aruser	: in std_logic_vector(C_S00_AXI_ARUSER_WIDTH-1 downto 0);
            s00_axi_arvalid	: in std_logic;
            s00_axi_arready	: out std_logic;
            s00_axi_rid	: out std_logic_vector(C_S00_AXI_ID_WIDTH-1 downto 0);
            s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
            s00_axi_rresp	: out std_logic_vector(1 downto 0);
            s00_axi_rlast	: out std_logic;
            s00_axi_ruser	: out std_logic_vector(C_S00_AXI_RUSER_WIDTH-1 downto 0);
            s00_axi_rvalid	: out std_logic;
            s00_axi_rready	: in std_logic
        );
    end component;
            
    signal s_s00_axi_aclk	:  std_logic;
    signal s_s00_axi_aresetn	:  std_logic;
    signal s_s00_axi_awid	:  std_logic_vector(0 downto 0);
    signal s_s00_axi_awaddr	:  std_logic_vector(9-1 downto 0) := "000000000";
    signal s_s00_axi_awlen	:  std_logic_vector(7 downto 0) := "00000000";
    signal s_s00_axi_awsize	:  std_logic_vector(2 downto 0) := "000";
    signal s_s00_axi_awburst	:  std_logic_vector(1 downto 0) := "00";
    signal s_s00_axi_awlock	:  std_logic := '0';
    signal s_s00_axi_awcache	:  std_logic_vector(3 downto 0) := "0000";
    signal s_s00_axi_awprot	:  std_logic_vector(2 downto 0) := "000";
    signal s_s00_axi_awqos	:  std_logic_vector(3 downto 0) := "0000";
    signal s_s00_axi_awregion	:  std_logic_vector(3 downto 0) := "0000";
    signal s_s00_axi_awuser	:  std_logic_vector(-1 downto 0);
    signal s_s00_axi_awvalid	:  std_logic := '0';
    signal s_s00_axi_awready	:  std_logic := '0';
    signal s_s00_axi_wdata	:  std_logic_vector(31 downto 0) := x"00000000";
    signal s_s00_axi_wstrb	:  std_logic_vector((32/8)-1 downto 0) := x"f";
    signal s_s00_axi_wlast	:  std_logic := '0';
    signal s_s00_axi_wuser	:  std_logic_vector(-1 downto 0);
    signal s_s00_axi_wvalid	:  std_logic := '0';
    signal s_s00_axi_wready	:  std_logic := '0';
    signal s_s00_axi_bid	:  std_logic_vector(0 downto 0);
    signal s_s00_axi_bresp	:  std_logic_vector(1 downto 0) := "00";
    signal s_s00_axi_buser	:  std_logic_vector(-1 downto 0);
    signal s_s00_axi_bvalid	:  std_logic := '0';
    signal s_s00_axi_bready	:  std_logic := '0';
    signal s_s00_axi_arid	:  std_logic_vector(0 downto 0);
    signal s_s00_axi_araddr	:  std_logic_vector(9-1 downto 0) := "000000000";
    signal s_s00_axi_arlen	:  std_logic_vector(7 downto 0) := "00000000";
    signal s_s00_axi_arsize	:  std_logic_vector(2 downto 0) := "000";
    signal s_s00_axi_arburst	:  std_logic_vector(1 downto 0) := "00";
    signal s_s00_axi_arlock	:  std_logic := '0';
    signal s_s00_axi_arcache	:  std_logic_vector(3 downto 0) := "0000";
    signal s_s00_axi_arprot	:  std_logic_vector(2 downto 0) := "000";
    signal s_s00_axi_arqos	:  std_logic_vector(3 downto 0) := "0000";
    signal s_s00_axi_arregion	:  std_logic_vector(3 downto 0) := "0000";
    signal s_s00_axi_aruser	:  std_logic_vector(-1 downto 0);
    signal s_s00_axi_arvalid	:  std_logic := '0';
    signal s_s00_axi_arready	:  std_logic := '0';
    signal s_s00_axi_rid	:  std_logic_vector(0 downto 0);
    signal s_s00_axi_rdata	:  std_logic_vector(32-1 downto 0) := x"00000000";
    signal s_s00_axi_rresp	:  std_logic_vector(1 downto 0) := "00";
    signal s_s00_axi_rlast	:  std_logic := '0';
    signal s_s00_axi_ruser	:  std_logic_vector(-1 downto 0);
    signal s_s00_axi_rvalid	:  std_logic := '0';
    signal s_s00_axi_rready	:  std_logic := '0';
    
    signal W : std_logic_vector((32*64)-1 downto 0) := (others => '0');

begin

    uut : IP_SHA_Accelerator_v1_0 port
    map(
        s00_axi_aclk => s_s00_axi_aclk,
        s00_axi_aresetn => s_s00_axi_aresetn,
        s00_axi_awid => s_s00_axi_awid,
        s00_axi_awaddr => s_s00_axi_awaddr,
        s00_axi_awlen => s_s00_axi_awlen,
        s00_axi_awsize => s_s00_axi_awsize,
        s00_axi_awburst => s_s00_axi_awburst,
        s00_axi_awlock => s_s00_axi_awlock,
        s00_axi_awcache => s_s00_axi_awcache,
        s00_axi_awprot => s_s00_axi_awprot,
        s00_axi_awqos => s_s00_axi_awqos,
        s00_axi_awregion => s_s00_axi_awregion,
        s00_axi_awuser => s_s00_axi_awuser,
        s00_axi_awvalid => s_s00_axi_awvalid,
        s00_axi_awready => s_s00_axi_awready,
        s00_axi_wdata => s_s00_axi_wdata,
        s00_axi_wstrb => s_s00_axi_wstrb,
        s00_axi_wlast => s_s00_axi_wlast,
        s00_axi_wuser => s_s00_axi_wuser,
        s00_axi_wvalid => s_s00_axi_wvalid,
        s00_axi_wready => s_s00_axi_wready,
        s00_axi_bid => s_s00_axi_bid,
        s00_axi_bresp => s_s00_axi_bresp,
        s00_axi_buser => s_s00_axi_buser,
        s00_axi_bvalid => s_s00_axi_bvalid,
        s00_axi_bready => s_s00_axi_bready,
        s00_axi_arid => s_s00_axi_arid,
        s00_axi_araddr => s_s00_axi_araddr,
        s00_axi_arlen => s_s00_axi_arlen,
        s00_axi_arsize => s_s00_axi_arsize,
        s00_axi_arburst => s_s00_axi_arburst,
        s00_axi_arlock => s_s00_axi_arlock,
        s00_axi_arcache => s_s00_axi_arcache,
        s00_axi_arprot => s_s00_axi_arprot,
        s00_axi_arqos => s_s00_axi_arqos,
        s00_axi_arregion => s_s00_axi_arregion,
        s00_axi_aruser => s_s00_axi_aruser,
        s00_axi_arvalid => s_s00_axi_arvalid,
        s00_axi_arready => s_s00_axi_arready,
        s00_axi_rid => s_s00_axi_rid,
        s00_axi_rdata => s_s00_axi_rdata,
        s00_axi_rresp => s_s00_axi_rresp,
        s00_axi_rlast => s_s00_axi_rlast,
        s00_axi_ruser => s_s00_axi_ruser,
        s00_axi_rvalid => s_s00_axi_rvalid,
        s00_axi_rready => s_s00_axi_rready
    );
    
    tb : process
    begin
        --1 ||Reset||
        s_s00_axi_aresetn <= '0';
        s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
        s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
        
        s_s00_axi_aresetn <='1';
        s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
        
        --2 ||WRITE the array W with burst||
            --Setup the BURST
                s_s00_axi_awburst <= "01"; -- incremental burst
                s_s00_axi_awsize <= "010"; -- Size of 32 bit per transfer
                s_s00_axi_awlen <= x"3F"; -- 64 Transfers 
        
            --Address Handshake
                s_s00_axi_awaddr <= "000000000";
                s_s00_axi_awvalid <= '1';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_awvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
            --Data Handshake 1   
                s_s00_axi_bready <= '1';
                         
                s_s00_axi_wdata <= W(31 downto 0);
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
            
            --Data Handshake N              
                for I in 2 to 63 loop
                    W((32*I)-1 downto 32*(I-1)) <= W((32*I)-1 downto 32*(I-1)) + 4*I;
                    s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                    
                    s_s00_axi_wdata <= W((32*I)-1 downto 32*(I-1));
                    s_s00_axi_wstrb <= x"f";
                    s_s00_axi_wvalid <= '1';
            
                    s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                    
                    s_s00_axi_wvalid <= '0';
                    
                    s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                END LOOP;
                
            --Last Write    
                W((32*64)-1 downto 32*(64-1)) <= W((32*64)-1 downto 32*(64-1)) + 4*64;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                    
                s_s00_axi_wdata <= W((32*64)-1 downto 32*(64-1));
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
 
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wlast <= '1';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                s_s00_axi_wlast <= '0';   
            
            --Write End
            
                for I in 1 to 5 loop
                    s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                end loop;
                
                s_s00_axi_bready <= '0';
                
        --||READ A WORD||
            --Setup the BURST
        --        s_s00_axi_arburst <= "01"; -- incremental burst
        --        s_s00_axi_arsize <= "010"; -- Size of 32 bit per transfer
        --        s_s00_axi_arlen <= x"3F"; -- 64 Transfers
        --Protocol
            --Address Handshake
        --        s_s00_axi_araddr <= "000000000";
        --        s_s00_axi_arvalid <= '1';
                
        --        s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
        --        s_s00_axi_arvalid <= '0';
                
        --        s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
            --Data Handshake 1    
                
        --        s_s00_axi_rready <= '1';
                
        --        for I in 1 to 127 loop
        --            s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
        --        end loop;
                
        --       s_s00_axi_rready <= '0';
                
         -- 3 ||WRITE ON CR REGISTER||
            --Setup the BURST
                s_s00_axi_awburst <= "00"; -- FIXED burst
                s_s00_axi_awsize <= "010"; -- Size of 32 bit per transfer
                s_s00_axi_awlen <= x"00"; -- 1 Transfers 

            --Address Handshake
                s_s00_axi_awaddr <= "100100000";
                s_s00_axi_awvalid <= '1';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_awvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
            --Data Handshake         
                s_s00_axi_bready <= '1';
                         
                s_s00_axi_wdata <= x"00000001";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wlast <= '1';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                s_s00_axi_wlast <= '0';   
            
            --Write End            
                for I in 1 to 5 loop
                    s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                end loop;
                
                s_s00_axi_bready <= '0';
                
        -- 4 ||WAIT FOR DIGEST TO BE PRODUCED||  
            for I in 1 to 1200 loop
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
            end loop;    
        
        -- 5 ||READ THE DIGEST||
            --Setup the BURST
                s_s00_axi_arburst <= "01"; -- incremental burst
                s_s00_axi_arsize <= "010"; -- Size of 32 bit per transfer
                s_s00_axi_arlen <= x"07"; -- 8 Transfers
                
            --Address Handshake
                s_s00_axi_araddr <= "100000000";
                s_s00_axi_arvalid <= '1';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_arvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
              
            --Data Handshake 1                   
                s_s00_axi_rready <= '1';
                
                for I in 1 to 16 loop
                    s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                end loop;
                
                s_s00_axi_rready <= '0';
                
          --||READ THE STATUS REGISTER||
            --Setup the BURST
                s_s00_axi_arburst <= "00"; -- incremental burst
                s_s00_axi_arsize <= "010"; -- Size of 32 bit per transfer
                s_s00_axi_arlen <= x"00"; -- 1 Transfers
            --Protocol
            --Address Handshake
                s_s00_axi_araddr <= "100100100";
                s_s00_axi_arvalid <= '1';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_arvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
            --Data Handshake 1    
                
                s_s00_axi_rready <= '1';
                
                for I in 1 to 2 loop
                    s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                end loop;
                
                s_s00_axi_rready <= '0';  
    wait;
    end process;     
    
end Behavioral;