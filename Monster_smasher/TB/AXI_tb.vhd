
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AXI_tb is
end AXI_tb;

architecture Behavioral of AXI_tb is

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
    
        s_s00_axi_aresetn <= '0';
        s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
        s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
        
        s_s00_axi_aresetn <='1';
        s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
        
        --||WRITE A WORD||
            --Setup the BURST
                s_s00_axi_awburst <= "01"; -- incremental burst
                s_s00_axi_awsize <= "010"; -- Size of 32 bit per transfer
                s_s00_axi_awlen <= x"0e"; -- 3 Transfers 
        
        --Protocol
            --Address Handshake
                s_s00_axi_awaddr <= "000000000";
                s_s00_axi_awvalid <= '1';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_awvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
            --Data Handshake 1
            
                s_s00_axi_bready <= '1';
                
                s_s00_axi_wdata <= x"0f0f0f0f";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
            
            --Data Handshake 2
            
                s_s00_axi_wdata <= x"0e0e0e0e";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
            
            --Data Handshake 3
            
                s_s00_axi_wdata <= x"0d0d0d0d";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
            
            --Data Handshake 4
                
                s_s00_axi_wdata <= x"0c0c0c0c";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
            
            --Data Handshake 5
            
                s_s00_axi_wdata <= x"0b0b0b0b";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
            
            --Data Handshake 6
            
                s_s00_axi_wdata <= x"0a0a0a0a";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
            --Data Handshake 7
            
                s_s00_axi_wdata <= x"09090909";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
               
            --Data Handshake 8
            
                s_s00_axi_wdata <= x"08080808";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
            --Data Handshake 9
            
                s_s00_axi_wdata <= x"07070707";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
             
            --Data Handshake 10
            
                s_s00_axi_wdata <= x"06060606";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
               
            --Data Handshake 11
            
                s_s00_axi_wdata <= x"05050505";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
            --Data Handshake 12
            
                s_s00_axi_wdata <= x"04040404";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns; 
             
            --Data Handshake 13
            
                s_s00_axi_wdata <= x"03030303";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
               
            --Data Handshake 14
            
                s_s00_axi_wdata <= x"02020202";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
        
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
            --Data Handshake 15
            
                s_s00_axi_wdata <= x"01010101";
                s_s00_axi_wstrb <= x"f";
                s_s00_axi_wvalid <= '1';
 
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wlast <= '1';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_wvalid <= '0';
                s_s00_axi_wlast <= '0';   
            
            --Write End
            
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_bready <= '0';
                
        --||READ A WORD||
            --Setup the BURST
                s_s00_axi_arburst <= "01"; -- incremental burst
                s_s00_axi_arsize <= "010"; -- Size of 32 bit per transfer
                s_s00_axi_arlen <= x"0e"; -- 3 Transfers
        --Protocol
            --Address Handshake
                s_s00_axi_araddr <= "000000000";
                s_s00_axi_arvalid <= '1';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                s_s00_axi_arvalid <= '0';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
            --Data Handshake 1    
                
                s_s00_axi_rready <= '1';
                
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                s_s00_axi_aclk <= '1'; wait for 5 ns; s_s00_axi_aclk <= '0'; wait for 5 ns;
                
                
                s_s00_axi_rready <= '0';
                
    wait;
    end process;     
    
end Behavioral;
