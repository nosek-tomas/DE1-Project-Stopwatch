----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2026 13:51:26
-- Design Name: 
-- Module Name: counter2_bcd - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- Package for data types conversion

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter2_bcd is
    generic ( 
        G_BITS : positive := 4;  --! Default number of bits
        G_MAX : positive := 4 --! Default max number to count to
    );  
    port (
        clk : in  std_logic;                              --! Main clock
        rst : in  std_logic;                              --! High-active synchronous reset
        en  : in  std_logic;                              --! Clock enable input
        cnt : out std_logic_vector(G_BITS - 1 downto 0);  --! Counter value
        ovf : out std_logic                               --! overflow to next counter
    );
end counter2_bcd;

architecture Behavioral of counter2_bcd is
    -- Integer counter with defined range
    signal sig_cnt : integer range 0 to G_MAX;

begin

    --! Clocked process with synchronous reset which implements
    --! N-bit up counter.

    p_counter : process (clk) is
    begin
        if rising_edge(clk) then
            if rst = '1' then    -- Synchronous, active-high reset
                sig_cnt <= 0;                
            elsif en = '1' then  -- Clock enable activated
                if sig_cnt = G_MAX then
                    sig_cnt <= 0;
                else
                    sig_cnt <= sig_cnt + 1;
                end if;          -- Each `if` must end by `end if`
            end if;
        end if;
    end process p_counter;

    -- Convert integer to std_logic_vector
    cnt <= std_logic_vector(to_unsigned(sig_cnt, G_BITS));
    ovf <= '1' when (sig_cnt = G_MAX and en = '1') else '0'; -- Overflow enable for next counter

end Behavioral;
