library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity time_counter is
    Port (
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC;
        en       : in  STD_LOGIC;
        time_ns   : out STD_LOGIC_VECTOR(3 downto 0); -- Setiny
        time_ms    : out STD_LOGIC_VECTOR(3 downto 0); -- Desetiny
        time_s    : out STD_LOGIC_VECTOR(3 downto 0); -- Jednotky sekund
        time_10s   : out STD_LOGIC_VECTOR(3 downto 0)  -- Desítky sekund
    );
end time_counter;

architecture Behavioral of time_counter is
 
    -----------------------
    -- Declaration: signals
    -----------------------
    signal sig_ovf_ns : std_logic;
    signal sig_ovf_ms : std_logic;
    signal sig_ovf_s : std_logic;
    
    
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
    ------------------------------------
    -- Instantiation: counter for ns
    ------------------------------------
    cnt_ns : counter2_bcd
        generic map (
            G_MAX => 9,
            G_BITS => 4
        )
        port map (
            clk => clk,
            rst => rst,
            en  => en,
            cnt => time_ns,
            ovf => sig_ovf_ns 
        );
        
    ------------------------------------
    -- Instantiation: counter for ms
    ------------------------------------
    cnt_ms : counter2_bcd
        generic map (
            G_MAX => 9,
            G_BITS => 4
        )
        port map (
            clk => clk,
            rst => rst,
            en  => sig_ovf_ns,
            cnt => time_ms,
            ovf => sig_ovf_ms 
        );
        
    ------------------------------------
    -- Instantiation: counter for s
    ------------------------------------
    cnt_s : counter2_bcd
        generic map (
            G_MAX => 9,
            G_BITS => 4
        )
        port map (
            clk => clk,
            rst => rst,
            en  => sig_ovf_ms,
            cnt => time_s,
            ovf => sig_ovf_s 
        );

    ------------------------------------
    -- Instantiation: counter for 10s
    ------------------------------------
    cnt_10s : counter2_bcd
        generic map (
            G_MAX => 9,
            G_BITS => 4
        )
        port map (
            clk => clk,
            rst => rst,
            en  => sig_ovf_s,
            cnt => time_10s,
            ovf => open
        );
end Behavioral;