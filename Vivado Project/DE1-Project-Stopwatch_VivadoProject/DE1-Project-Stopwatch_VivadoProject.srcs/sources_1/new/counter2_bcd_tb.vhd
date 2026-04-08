library ieee;
use ieee.std_logic_1164.all;

entity counter2_bcd_tb is
end counter2_bcd_tb;

architecture tb of counter2_bcd_tb is

    -- Set generics
    constant C_G_MAX  : positive := 9;
    constant C_G_BITS : positive := 4;

    -- Signlas definitions
    signal clk : std_logic;
    signal rst : std_logic;
    signal en  : std_logic;
    signal ovf : std_logic;
    signal cnt : std_logic_vector(C_G_BITS - 1 downto 0);

    
    -- Tb clock
    constant TbPeriod : time := 10 ns; 
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
    
    
    -----------------------
    -- Declaration: counter
    -----------------------
    component counter2_bcd is
    generic ( 
        G_BITS : positive;
        G_MAX : positive
    );  
    port (
        clk : in  std_logic;                              --! Main clock
        rst : in  std_logic;                              --! High-active synchronous reset
        en  : in  std_logic;                              --! Clock enable input
        cnt : out std_logic_vector(G_BITS - 1 downto 0);  --! Counter value
        ovf : out std_logic                               --! Overflow to next counter
    );
    end component counter2_bcd;
    
begin


    dut : counter2_bcd
    generic map (
        G_MAX  => C_G_MAX,
        G_BITS => C_G_BITS
    )
    port map (
        clk => clk,
        rst => rst,
        en  => en,
        cnt => cnt,
        ovf => ovf
    );

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    clk <= TbClock;

    -----
    stimuli : process
    begin
        -- INIT and RESET
        en <= '0';
        rst <= '1';
        wait for 25 ns;
        rst <= '0';
        wait for 20 ns;

        -- A) Overflow test
        en <= '1';
        wait for 350 ns; -- 35 tacts of clock
        
        -- B) EN react
        en <= '0';
        wait for 50 ns; -- Counter must be stay freezed
        
        -- C) clk_en test
        for i in 1 to 7 loop
            en <= '1';             -- Enable
            wait for TbPeriod;     -- Wait 1 clock period
            en <= '0';             -- Not enable
            wait for 3 * TbPeriod; -- 3 tact of clock --> simulation of "clk_en"
        end loop;
        
        -- End
        TbSimEnded <= '1';
        wait;
    end process;

end tb;