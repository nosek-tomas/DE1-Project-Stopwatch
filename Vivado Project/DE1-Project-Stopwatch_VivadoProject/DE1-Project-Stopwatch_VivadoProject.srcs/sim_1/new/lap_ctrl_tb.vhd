library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lap_ctrl_tb is
end lap_ctrl_tb;

architecture tb of lap_ctrl_tb is

    ------------------------------------------------------------------------
    -- 1. Component declaration
    ------------------------------------------------------------------------
    component lap_ctrl is
        Port (
            clk             : in  STD_LOGIC;
            rst             : in  STD_LOGIC;
            lap_button      : in  STD_LOGIC;
            time_actual     : in  STD_LOGIC_VECTOR (31 downto 0);
            sw              : in  STD_LOGIC_VECTOR (15 downto 0);
            lap_time_output : out STD_LOGIC_VECTOR (31 downto 0);
            show_lap        : out STD_LOGIC;
            led             : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;

    ------------------------------------------------------------------------
    -- Internal signals
    ------------------------------------------------------------------------
    signal clk             : STD_LOGIC := '0';
    signal rst             : STD_LOGIC := '0';
    signal lap_button      : STD_LOGIC := '0';
    signal time_actual     : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal sw              : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
    
    signal lap_time_output : STD_LOGIC_VECTOR (31 downto 0);
    signal show_lap        : STD_LOGIC;
    signal led             : STD_LOGIC_VECTOR (15 downto 0);

    constant TbPeriod : time := 10 ns;
    signal TbSimEnded : STD_LOGIC := '0';

begin

    ------------------------------------------------------------------------
    -- 2. Component instantiation (DUT)
    ------------------------------------------------------------------------
    dut : lap_ctrl
        port map (
            clk             => clk,
            rst             => rst,
            lap_button      => lap_button,
            time_actual     => time_actual,
            sw              => sw,
            lap_time_output => lap_time_output,
            show_lap        => show_lap,
            led             => led
        );

    ------------------------------------------------------------------------
    -- Clock generation
    ------------------------------------------------------------------------
    clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';

    ------------------------------------------------------------------------
    -- Test process
    ------------------------------------------------------------------------
    stimuli : process
    begin
        
        -- INIT
        rst <= '1';
        lap_button <= '0';
        sw <= (others => '0');
        time_actual <= x"00000000";
        wait for 50 ns;

        rst <= '0';
        wait for 50 ns;

        -- A) TEST SAVE 1st LAP
        -- Stopwatch is running, time is 11111111
        time_actual <= x"11111111";
        wait for 50 ns;
        -- Press LAP button (simulate pulse from debouncer)
        lap_button <= '1';
        wait for TbPeriod;
        lap_button <= '0';
        wait for 50 ns;

        -- B) TEST SAVE 2nd LAP
        -- Time changed to 22222222
        time_actual <= x"22222222";
        wait for 50 ns;
        -- Press LAP button again
        lap_button <= '1';
        wait for TbPeriod;
        lap_button <= '0';
        wait for 50 ns;

        -- C) TEST SAVE 3rd LAP
        -- Time changed to 33333333
        time_actual <= x"33333333";
        wait for 50 ns;
        lap_button <= '1';
        wait for TbPeriod;
        lap_button <= '0';
        wait for 50 ns;

        -- D) TEST READ 1st LAP (Switch 15 - most left)
        -- Change live time to 99999999 so we see the difference!
        time_actual <= x"99999999";
        sw(15) <= '1';
        wait for 50 ns;
        -- CHECK: lap_time_output must be 11111111 and show_lap must be 1

        -- E) TEST PRIORITY (Switch 15 and Switch 14 are UP)
        sw(14) <= '1';
        wait for 50 ns;
        -- CHECK: Output must STILL be 11111111 because Switch 15 has priority

        -- F) TEST READ 2nd LAP
        -- Turn off Switch 15, leave Switch 14 UP
        sw(15) <= '0';
        wait for 50 ns;
        -- CHECK: Output must change to 22222222

        -- G) TEST EMPTY SLOT
        -- Try to read LAP 10 (Switch 5 is UP), but we saved only 3 laps!
        sw(14) <= '0';
        sw(5) <= '1';
        wait for 50 ns;
        -- CHECK: show_lap must be 0, output is 00000000

        -- End simulation
        TbSimEnded <= '1';
        wait;
        
    end process;

end tb;