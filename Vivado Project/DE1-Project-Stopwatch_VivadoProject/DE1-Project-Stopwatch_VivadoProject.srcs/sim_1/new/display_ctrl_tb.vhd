library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display_ctrl_tb is
end display_ctrl_tb;

architecture tb of display_ctrl_tb is

    ------------------------------------------------------------------------
    -- 1. Component declaration
    ------------------------------------------------------------------------
    component display_ctrl is
        Port ( 
            data_live : in  STD_LOGIC_VECTOR (31 downto 0);
            data_lap  : in  STD_LOGIC_VECTOR (31 downto 0);
            show_lap  : in  STD_LOGIC;
            data_out  : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    ------------------------------------------------------------------------
    -- Internal signals
    ------------------------------------------------------------------------
    signal data_live : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal data_lap  : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal show_lap  : STD_LOGIC := '0';
    signal data_out  : STD_LOGIC_VECTOR (31 downto 0);

begin

    ------------------------------------------------------------------------
    -- 2. Component instantiation (DUT)
    ------------------------------------------------------------------------
    dut : display_ctrl
        port map (
            data_live => data_live,
            data_lap  => data_lap,
            show_lap  => show_lap,
            data_out  => data_out
        );

    ------------------------------------------------------------------------
    -- Test process
    ------------------------------------------------------------------------
    stimuli : process
    begin
        
        -- INIT
        -- Set some dummy numbers. 
        -- Live time = 11111111, Lap time = 88888888
        data_live <= x"11111111";  -- number in HEX instand of BCD
        data_lap  <= x"88888888";
        show_lap  <= '0';
        wait for 50 ns;

        -- A) TEST SHOW LIVE TIME
        -- show_lap is 0. Output must be 11111111.
        show_lap <= '0';
        wait for 50 ns;

        -- B) TEST SHOW LAP TIME
        -- Switch the lever. show_lap is 1. Output must be 88888888.
        show_lap <= '1';
        wait for 50 ns;

        -- C) TEST LIVE DATA CHANGE
        -- Stopwatches are running (live time changes to 22222222).
        -- But we are looking at LAP (show_lap is 1).
        -- Output must STILL be 88888888.
        data_live <= x"22222222";
        wait for 50 ns;

        -- D) TEST LAP DATA CHANGE AND SWITCH BACK
        -- We change switch to another LAP memory (LAP changes to 99999999).
        -- Output must change immediately to 99999999.
        data_lap <= x"99999999";
        wait for 50 ns;
        
        -- Switch lever back to 0. Must show 22222222.
        show_lap <= '0';
        wait for 50 ns;
        
        
        -- Switch curent time. Must change to 33333333
        data_live <= x"33333333";
        wait for 150ns;
        
        -- Toggle ON and OFF lap
        show_lap <= '1';
        wait for 50ns;
        show_lap <= '0';
        -- End simulation
        wait;
        
    end process;

end tb;