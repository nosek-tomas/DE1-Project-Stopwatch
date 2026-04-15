-- Component derivated from display_driver.vhd from PC LABs
-- Extended for disaplying on all 8 displays with longer input vector
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;  -- Package for data types conversion


entity display_driver2 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (31 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           anode : out STD_LOGIC_VECTOR (7 downto 0);
           datapoint : out STD_LOGIC
           );
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
    signal sig_digit : std_logic_vector(2 downto 0);
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
        
    ------------------------------------------------------------------------
    -- Counter for interating through digits
    ------------------------------------------------------------------------
    counter_0 : counter2_bcd
        generic map (
            G_BITS => 3,
            G_MAX => 7
        )
        port map (
            clk => clk,
            rst => rst,
            en  => sig_en,
            cnt => sig_digit
        );


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
    -- Anode select process + select digit to render
    ------------------------------------------------------------------------
    p_anode_select_and_digit_render : process (sig_digit, data) is
    begin
        case sig_digit is
            when "000" =>
                anode <= "11111110";            -- 1. digit active
                sig_bin <= data(3 downto 0);    -- send 1. digit from input vector
                datapoint <= '1';               -- DP ff
                
            when "001" =>
                anode <= "11111101";            -- 2. digit active
                sig_bin <= data(7 downto 4);    -- send 2. digit from input vector
                datapoint <= '1';               -- DP off
                
            when "010" =>
                anode <= "11111011";             -- 3. digit active
                sig_bin <= data(11 downto 8);    -- send 3. digit from input vector
                datapoint <= '0';                -- DP on
                
            when "011" =>
                anode <= "11110111";             -- 4. digit active
                sig_bin <= data(15 downto 12);   -- send 4. digit from input vector
                datapoint <= '1';                -- DP off
                
            when "100" =>
                anode <= "11101111";             -- 5. digit active
                sig_bin <= data(19 downto 16);   -- send 5. digit from input vector
                datapoint <= '0';                -- DP on
                
            when "101" =>
                anode <= "11011111";             -- 6. digit active 
                sig_bin <= data(23 downto 20);   -- send 6. digit from input vector
                datapoint <= '1';                -- DP off
                
            when "110" =>
                anode <= "10111111";             -- 7. digit active 
                sig_bin <= data(27 downto 24);   -- send 7. digit from input vector
                datapoint <= '0';                -- DP on
                                                
            when "111" =>
                anode <= "01111111";             -- 8. digit active                                                                          
                sig_bin <= data(31 downto 28);   -- send 8. digit from input vector
                datapoint <= '1';                -- DP off
                        
            when others =>
                anode <= "11111111"; -- All off
                sig_bin <= "0000";   -- Output 0 0 0 0
                
        end case;
    end process;

end Behavioral;
