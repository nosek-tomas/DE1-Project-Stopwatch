library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity stopwatch_top is
    Port ( clk : in STD_LOGIC;
           btnd : in STD_LOGIC; -- Reset
           btnl : in STD_LOGIC; -- Start/stop
           btnr : in STD_LOGIC  -- Lap
           );
end stopwatch_top;

architecture Behavioral of stopwatch_top is

begin


end Behavioral;
