library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity stopwatch_ctrl_tb is
end stopwatch_ctrl_tb;

architecture tb of stopwatch_ctrl_tb is

    ------------------------------------------------------------------------
    -- 1. Component declaration
    ------------------------------------------------------------------------
    component stopwatch_ctrl is
        Port (
            clk         : in  STD_LOGIC;
            rst         : in  STD_LOGIC;
            btn_in      : in  STD_LOGIC; 
            clk_en_in   : in  STD_LOGIC; 
            clk_en_out  : out STD_LOGIC  
        );
    end component;

    ------------------------------------------------------------------------
    -- Internal signals
    ------------------------------------------------------------------------
    signal clk         : STD_LOGIC := '0';
    signal rst         : STD_LOGIC := '0';
    signal btn_in      : STD_LOGIC := '0';
    signal clk_en_in   : STD_LOGIC := '0';
    signal clk_en_out  : STD_LOGIC;

    -- Clock settings
    constant TbPeriod : time := 10 ns;
    signal TbSimEnded : STD_LOGIC := '0';

begin

    ------------------------------------------------------------------------
    -- 2. Component instantiation (DUT)
    ------------------------------------------------------------------------
    dut : stopwatch_ctrl
        port map (
            clk         => clk,
            rst         => rst,
            btn_in      => btn_in,
            clk_en_in   => clk_en_in,
            clk_en_out  => clk_en_out
        );

    ------------------------------------------------------------------------
    -- Main clock generation
    ------------------------------------------------------------------------
    clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';

    ------------------------------------------------------------------------
    -- Background Generator for clk_en_in
    -- This simulates your clk_en component ticking on background
    ------------------------------------------------------------------------
    p_ce_gen : process
    begin
        while TbSimEnded = '0' loop
            clk_en_in <= '0';
            wait for 40 ns;         -- Wait some time
            clk_en_in <= '1';
            wait for TbPeriod;      -- Pulse is exactly 1 clock tick
        end loop;
        wait;
    end process;

    ------------------------------------------------------------------------
    -- Test process (Button pressing)
    ------------------------------------------------------------------------
    stimuli : process
    begin
        
        -- INIT
        rst <= '1';
        btn_in <= '0';
        wait for 30 ns;
        
        rst <= '0';
        wait for 50 ns;
        -- Now clk_en_out must be 0, because stopwatch is stopped.

        -- A) TEST START
        -- Press button (simulate short pulse from debouncer)
        btn_in <= '1';
        wait for TbPeriod;
        btn_in <= '0';
        
        -- Now stopwatch is running. 
        -- clk_en_out must copy clk_en_in.
        wait for 200 ns;

        -- B) TEST STOP
        -- Press button again
        btn_in <= '1';
        wait for TbPeriod;
        btn_in <= '0';
        
        -- Now stopwatch is stopped.
        -- clk_en_out must be 0 all the time.
        wait for 200 ns;

        -- C) TEST RESET WHILE RUNNING
        -- Start stopwatch first
        btn_in <= '1';
        wait for TbPeriod;
        btn_in <= '0';
        wait for 100 ns;
        
        -- Press reset button!
        rst <= '1';
        wait for 50 ns;
        rst <= '0';
        
        -- Must stop running immediately.
        wait for 100 ns;

        -- End simulation
        TbSimEnded <= '1';
        wait;
        
    end process;

end tb;