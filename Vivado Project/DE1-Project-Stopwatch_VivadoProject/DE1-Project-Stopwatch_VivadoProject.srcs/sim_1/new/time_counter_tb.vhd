library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity time_counter_tb is
end time_counter_tb;

architecture tb of time_counter_tb is

    ------------------------------------
    -- 1. Component declaration
    ------------------------------------
    component time_counter is
        Port (
            clk      : in  STD_LOGIC;
            rst      : in  STD_LOGIC;
            en       : in  STD_LOGIC;
            time_ns  : out STD_LOGIC_VECTOR(3 downto 0); 
            time_ms  : out STD_LOGIC_VECTOR(3 downto 0); 
            time_s   : out STD_LOGIC_VECTOR(3 downto 0); 
            time_10s : out STD_LOGIC_VECTOR(3 downto 0)  
        );
    end component;

    ------------------------------------
    -- Signals
    ------------------------------------
    signal clk      : STD_LOGIC := '0';
    signal rst      : STD_LOGIC := '0';
    signal en       : STD_LOGIC := '0';
    
    signal time_ns  : STD_LOGIC_VECTOR(3 downto 0);
    signal time_ms  : STD_LOGIC_VECTOR(3 downto 0);
    signal time_s   : STD_LOGIC_VECTOR(3 downto 0);
    signal time_10s : STD_LOGIC_VECTOR(3 downto 0);

    -- Clock settings
    constant TbPeriod : time := 10 ns;
    signal TbSimEnded : STD_LOGIC := '0';

begin

    ------------------------------------
    -- 2. Component instantiation 
    ------------------------------------
    dut : time_counter
        port map (
            clk      => clk,
            rst      => rst,
            en       => en,
            time_ns  => time_ns,
            time_ms  => time_ms,
            time_s   => time_s,
            time_10s => time_10s
        );

    ------------------------------------
    -- Clock generation
    ------------------------------------
    clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';

    ------------------------------------
    -- Test process
    ------------------------------------
    stimuli : process
    begin
        
        -- A) TEST RESET
        -- Set reset to 1. All outputs must be 0.
        rst <= '1';
        en  <= '0';
        wait for 30 ns;
        
        -- Turn off reset.
        rst <= '0';
        wait for 20 ns;

        -- B) TEST COUNTING WITH PULSES
        -- We make realistic short pulses.
        -- We loop 115 times to see fast counting.
        -- Output will be 0 1 1 5 (1.15 seconds).
        for i in 1 to 115 loop
            en <= '1';              -- Enable is ON
            wait for TbPeriod;      -- Wait 1 clock tick
            
            en <= '0';              -- Enable is OFF
            wait for 3 * TbPeriod;  -- Wait 3 ticks (pause between pulses)
        end loop;

        -- C) TEST STOP
        -- Do not send enable pulses. Time must stop and wait.
        en <= '0';
        wait for 100 ns;

        -- D) TEST RESET WHILE STOPPED
        -- Press reset button. Counters must go back to 0.
        rst <= '1';
        wait for 50 ns;
        
        -- Turn off reset again.
        rst <= '0';
        wait for 50 ns;

        -- End simulation
        TbSimEnded <= '1';
        wait;
        
    end process;

end tb;