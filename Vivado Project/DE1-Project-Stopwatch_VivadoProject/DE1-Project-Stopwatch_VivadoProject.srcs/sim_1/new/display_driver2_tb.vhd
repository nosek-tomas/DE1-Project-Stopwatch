library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display_driver2_tb is
end display_driver2_tb;

architecture tb of display_driver2_tb is

    ------------------------------------------------------------------------
    -- 1. Component declaration
    ------------------------------------------------------------------------
    component display_driver2 is
        Port ( 
            clk   : in STD_LOGIC;
            rst   : in STD_LOGIC;
            data  : in STD_LOGIC_VECTOR (31 downto 0);
            seg   : out STD_LOGIC_VECTOR (6 downto 0);
            anode : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    ------------------------------------------------------------------------
    -- Internal signals
    ------------------------------------------------------------------------
    signal clk   : STD_LOGIC := '0';
    signal rst   : STD_LOGIC := '0';
    signal data  : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal seg   : STD_LOGIC_VECTOR (6 downto 0);
    signal anode : STD_LOGIC_VECTOR (7 downto 0);

    -- Clock settings (100 MHz)
    constant TbPeriod : time := 10 ns;
    signal TbSimEnded : STD_LOGIC := '0';

begin

    ------------------------------------------------------------------------
    -- 2. Component instantiation (DUT)
    ------------------------------------------------------------------------
    dut : display_driver2
        port map (
            clk   => clk,
            rst   => rst,
            data  => data,
            seg   => seg,
            anode => anode
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
        data <= (others => '0');
        wait for 50 ns;
        
        rst <= '0';
        wait for 50 ns;

        -- A) TEST RESET
        -- Press reset button. Display must stop and show nothing.
        rst <= '1';
        wait for 10 us; 
        rst <= '0';
        wait for 1 us;

        -- B) TEST SHOW DATA 1
        -- Put number 12345678 (Hexadecimal) to data input.
        -- Wait enough time to see all 8 digits on display.
        -- (800 ticks * 10ns = 8us per digit. 8 digits = 64us).
        data <= x"12345678";
        wait for 80 us;

        -- C) TEST SHOW DATA 2
        -- Change number to 87654321.
        -- Check if display output changes correctly.
        data <= x"87654321";
        wait for 80 us;

        -- End simulation
        TbSimEnded <= '1';
        wait;
        
    end process;

end tb;