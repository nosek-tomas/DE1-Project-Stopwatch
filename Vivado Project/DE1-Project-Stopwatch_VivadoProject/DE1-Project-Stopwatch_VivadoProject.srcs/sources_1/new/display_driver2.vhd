

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;  -- Package for data types conversion


entity display_driver2 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (7 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           anode : out STD_LOGIC_VECTOR (1 downto 0));
end display_driver2;

architecture Behavioral of display_driver2 is

    -- Component declaration for clock enable
    component clk_en is
        generic ( G_MAX : positive );
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            ce  : out std_logic
        );
    end component clk_en;
 
    -- Component declaration for binary counter
    component counter2_bcd is
        generic (
            G_BITS : positive;
            G_MAX : positive);
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            en  : in  std_logic;
            cnt : out std_logic_vector(G_BITS - 1 downto 0)
        );
    end component counter2_bcd;
 
    component bin2seg is
        -- TODO: Add component declaration of `bin2seg`
       Port ( bin : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
    end component bin2seg;
 
    -- Internal signals
    signal sig_en : std_logic;

    -- TODO: Add other needed signals
    signal sig_digit : std_logic_vector(0 downto 0);
    signal sig_bin : std_logic_vector(3 downto 0);
begin

    ------------------------------------------------------------------------
    -- Clock enable generator for refresh timing
    ------------------------------------------------------------------------
    clock_0 : clk_en
        generic map ( G_MAX => 800 )  -- Adjust for flicker-free multiplexing
        port map (                  -- For simulation: 8
            clk => clk,             -- For implementation: 8_000_000
            rst => rst,
            ce  => sig_en
        );

    counter_0 : counter2_bcd
        generic map (
            G_BITS => 1,
            G_MAX => 1
        )
        port map (
            clk => clk,
            rst => rst,
            en  => sig_en,
            cnt => sig_digit
        );

    ------------------------------------------------------------------------
    -- Digit select
    ------------------------------------------------------------------------
    sig_bin <= data(3 downto 0) when sig_digit = "0" else
               data(7 downto 4);

    ------------------------------------------------------------------------
    -- 7-segment decoder
    ------------------------------------------------------------------------
    decoder_0 : bin2seg
        port map (

            -- TODO: Add component instantiation of `bin2seg`
            bin => sig_bin,
            seg => seg
        );

    ------------------------------------------------------------------------
    -- Anode select process
    ------------------------------------------------------------------------
    p_anode_select : process (sig_digit) is
    begin
        case sig_digit is
            when "0" =>
                anode <= "10";  -- Right digit active
                
            when "1" =>
                anode <= "01"; -- left active
            -- TODO: Add another anode selection(s)

            when others =>
                anode <= "11";  -- All off
        end case;
    end process;

end Behavioral;
