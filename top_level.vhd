----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2019 12:25:05 AM
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
    Port ( clk : in STD_LOGIC;
           vga_r, vga_b : out STD_LOGIC_VECTOR(4 downto 0);
           vga_g : out STD_LOGIC_VECTOR(5 downto 0);
           vga_hs, vga_vs : out STD_LOGIC);
end top_level;

architecture Behavioral of top_level is
    --component
    component pixel_pusher is
    Port ( clk, en, VS, vid : in STD_LOGIC;
           pixel : in STD_LOGIC_VECTOR (7 downto 0);
           hcount : in STD_LOGIC_VECTOR (9 downto 0);
           R, B : out STD_LOGIC_VECTOR(4 downto 0);
           G : out STD_LOGIC_VECTOR(5 downto 0);
           addr : out STD_LOGIC_VECTOR(17 downto 0));
    end component;

    component clock_div is
    Port ( clk : in STD_LOGIC;
           div : out STD_LOGIC);
    end component;
    
    component vga_ctrl is
    Port (
        clk : in STD_LOGIC;
        en : in STD_LOGIC;
        hcount, vcount : out STD_LOGIC_VECTOR (9 downto 0);
        vid, hs, vs : out STD_LOGIC
    );
    end component;
    
    --signals
    signal en, vs, hs, vid : STD_LOGIC;
    signal pixel : STD_LOGIC_VECTOR (7 downto 0);
    signal hcount : STD_LOGIC_VECTOR (9 downto 0);
    signal vcount : STD_LOGIC_VECTOR (9 downto 0);
    signal R, B : STD_LOGIC_VECTOR(4 downto 0);
    signal G : STD_LOGIC_VECTOR(5 downto 0);
    signal addr : STD_LOGIC_VECTOR(17 downto 0);
    
begin

    pixelPusher : pixel_pusher port map (clk, en, vs, vid, pixel, hcount, R, B, G, addr);
    vgaController : vga_ctrl port map (clk, en, hcount, vcount, vid, hs, vs);
    divider : clock_div port map (clk, en);
    
    --Glue logic
    vga_r <= R;
    vga_g <= G;
    vga_b <= B;
    vga_hs <= hs;
    vga_vs <= vs;
    
end Behavioral;
