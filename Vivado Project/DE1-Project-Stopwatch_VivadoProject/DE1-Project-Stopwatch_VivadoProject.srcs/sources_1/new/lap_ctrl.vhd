library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity lap_ctrl is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        lap_button : in STD_LOGIC;                              -- Button to store actual time to memory
        time_actual : in STD_LOGIC_VECTOR (31 downto 0);        -- Actual time to store
        sw : in STD_LOGIC_VECTOR (15 downto 0);                 -- Switches to choose memory slot to display
        lap_time_output : out STD_LOGIC_VECTOR (31 downto 0);   -- Time from memory to be displayed
        show_lap :  out STD_LOGIC;                              -- Info to display_ctrl that we want to show time from lap_ctrl
        led : out STD_LOGIC_VECTOR (15 downto 0)                -- LEDs to indicate
        
      );
end lap_ctrl;

architecture Behavioral of lap_ctrl is

    ----------------------------------------------------------------
    -- 1. Component declaration for clock enable --> for LED blinking
    ----------------------------------------------------------------
    component clk_en is
        generic ( G_MAX : positive);  
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               ce : out STD_LOGIC);
    end component clk_en;
 
    ----------------------------------------------------------------
    -- 2. Signal Declaration
    ----------------------------------------------------------------
    signal sig_ce_2hz : STD_LOGIC; -- for LED Blinkg
begin


end Behavioral;
