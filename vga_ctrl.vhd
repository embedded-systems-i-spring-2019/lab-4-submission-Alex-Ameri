----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/30/2019 09:10:51 PM
-- Design Name: 
-- Module Name: vga_ctrl - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ctrl is
    Port (
        clk : in STD_LOGIC;
        en : in STD_LOGIC;
        hcount, vcount : out STD_LOGIC_VECTOR (9 downto 0);
        vid, hs, vs : out STD_LOGIC
    );
end vga_ctrl;

architecture Behavioral of vga_ctrl is
    signal hcount_signal : std_logic_vector (9 downto 0) := (others => '0');
    signal vcount_signal : std_logic_vector (9 downto 0) := (others => '0');
    signal new_frame : std_logic := '1';
    signal vid_buf : std_logic := '1';
    signal hs_buf : std_logic := '1';
    signal vs_buf : std_logic := '1';
begin

    --Glue logic
    hcount <= hcount_signal;
    vcount <= vcount_signal;
    vid <= vid_buf;
    hs <= hs_buf;
    vs <= vs_buf;
    
    --Process
    main : process(clk, en) 
    begin 
        if(rising_edge(clk) and en = '1') then
            --Increment the vertical counter
            if(unsigned(hcount_signal) = 799) then
                if(unsigned(vcount_signal) < 524) then
                    if(new_frame = '0') then
                        vcount_signal <= std_logic_vector(unsigned(vcount_signal) + 1);
                    else
                        new_frame <= '0';
                    end if;
                else
                    vcount_signal <= (others => '0');
                    new_frame <= '0';
                end if;
            end if;
            
            --Increment the horizontal counter
            if(unsigned(hcount_signal) < 799) then
                hcount_signal <= std_logic_vector(unsigned(hcount_signal) + 1);
            else
                hcount_signal <= (others => '0');
            end if;
            
            --Logic for front/back porches and sync pulses
            --horizontal
            if(unsigned(hcount_signal) > 654 and unsigned(hcount_signal) < 751) then
                hs_buf <= '0';
            else
                hs_buf <= '1';
            end if;
            
            --vertical
            if((unsigned(vcount_signal) > 489 and unsigned(vcount_signal) < 492)) then
                if(unsigned(vcount_signal) = 491 and unsigned(hcount_signal) = 799) then
                    vs_buf <= '1';
                else    
                    vs_buf <= '0';
                end if;
            else
                if(unsigned(vcount_signal) = 489 and unsigned(hcount_signal) = 799) then
                    vs_buf <= '0';
                else
                    vs_buf <= '1';
                end if;
            end if;
            
            
            
            --Logic for display
            if((unsigned(hcount_signal) < 639 and unsigned(vcount_signal) < 480) or
               (unsigned(hcount_signal) = 799 and unsigned(vcount_signal) = 524)) then
                vid_buf <= '1';
            else
                if((unsigned(hcount_signal) = 799 and unsigned(vcount_signal) < 480))  then
                    vid_buf <= '1';
                else   
                    vid_buf <= '0';
                end if;
            end if;
            
        end if;    
    end process;
        

end Behavioral;
