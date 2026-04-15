library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display_ctrl is
    Port ( 
        data_live : in  STD_LOGIC_VECTOR (31 downto 0); -- running time
        data_lap  : in  STD_LOGIC_VECTOR (31 downto 0); -- output from stored LAP
        show_lap  : in  STD_LOGIC;                      -- show data_lap or data_live?
        data_out  : out STD_LOGIC_VECTOR (31 downto 0)  -- output to display_driver2
    );
end display_ctrl;

architecture Behavioral of display_ctrl is

begin
    
     data_out <=   data_lap when (show_lap = '1') else data_live;
    
end Behavioral;