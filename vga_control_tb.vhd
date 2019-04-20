----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/01/2019 04:14:12 AM
-- Design Name: 
-- Module Name: vga_control_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_control_tb is
--  Port ( );
end vga_control_tb;

architecture Behavioral of vga_control_tb is

    --Components
    component vga_ctrl is
        Port (
            clk : in STD_LOGIC;
            en : in STD_LOGIC;
            hcount, vcount : out STD_LOGIC_VECTOR (9 downto 0);
            vid, hs, vs : out STD_LOGIC
        );
    end component;
    
    --Signals
    signal clk : std_logic := '0';
    signal en : std_logic := '1'; 
    signal vid, hs, vs : std_logic;
    
    signal hcount : std_logic_vector(9 downto 0) := (others => '0');
    signal vcount : std_logic_vector(9 downto 0) := (others => '0');
    
begin

dut : vga_ctrl port map(clk, en, hcount, vcount, vid, hs, vs);

clock : process
begin
    wait for 4 ns;
    clk <= not clk;  
end process;

end Behavioral;
