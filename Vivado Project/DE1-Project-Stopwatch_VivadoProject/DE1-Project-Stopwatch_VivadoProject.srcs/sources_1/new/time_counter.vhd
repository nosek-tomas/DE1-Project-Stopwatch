library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity time_counter is
    Port (
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC;
        en       : in  STD_LOGIC;
        time_actual : out STD_LOGIC_VECTOR(31 downto 0) -- Time output
    );
end time_counter;

architecture Behavioral of time_counter is
 
    -----------------------
    -- Declaration: signals
    -----------------------
    signal sig_time_ns :  STD_LOGIC_VECTOR(3 downto 0); -- Setiny
    signal sig_time_ms :  STD_LOGIC_VECTOR(3 downto 0); -- Desetiny
    signal sig_time_s :  STD_LOGIC_VECTOR(3 downto 0); -- Jednotky sekund
    signal sig_time_10s :  STD_LOGIC_VECTOR(3 downto 0); -- Desítky sekund
    signal sig_time_m :  STD_LOGIC_VECTOR(3 downto 0); -- Minuty
    signal sig_time_10m :  STD_LOGIC_VECTOR(3 downto 0); -- Minuty
    signal sig_time_h :  STD_LOGIC_VECTOR(3 downto 0); -- Minuty
    signal sig_time_10h :  STD_LOGIC_VECTOR(3 downto 0); -- Minuty
    
    signal sig_ovf_ns : std_logic;
    signal sig_ovf_ms : std_logic;
    signal sig_ovf_s : std_logic;
    signal sig_ovf_10s : std_logic;
    signal sig_ovf_m : std_logic;
    signal sig_ovf_10m : std_logic;
    signal sig_ovf_h : std_logic;
    
    
    
    
    
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
            cnt => sig_time_ns,
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
            cnt => sig_time_ms,
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
            cnt => sig_time_s,
            ovf => sig_ovf_s 
        );

    ------------------------------------
    -- Instantiation: counter for 10s
    ------------------------------------
    cnt_10s : counter2_bcd
        generic map (
            G_MAX => 5,
            G_BITS => 4
        )
        port map (
            clk => clk,
            rst => rst,
            en  => sig_ovf_s,
            cnt => sig_time_10s,
            ovf => sig_ovf_10s
        );
    ------------------------------------
    -- Instantiation: counter for m
    ------------------------------------
    cnt_m : counter2_bcd
        generic map (
            G_MAX => 9,
            G_BITS => 4
        )
        port map (
            clk => clk,
            rst => rst,
            en  => sig_ovf_10s,
            cnt => sig_time_m,
            ovf => sig_ovf_m
        );
    ------------------------------------
    -- Instantiation: counter for 10m
    ------------------------------------
    cnt_10m : counter2_bcd
        generic map (
            G_MAX => 5,
            G_BITS => 4
        )
        port map (
            clk => clk,
            rst => rst,
            en  => sig_ovf_m,
            cnt => sig_time_10m,
            ovf => sig_ovf_10m
        );
    ------------------------------------
    -- Instantiation: counter for h
    ------------------------------------
    cnt_h : counter2_bcd
        generic map (
            G_MAX => 9,
            G_BITS => 4
        )
        port map (
            clk => clk,
            rst => rst,
            en  => sig_ovf_10m,
            cnt => sig_time_h,
            ovf => sig_ovf_h
        );
    ------------------------------------
    -- Instantiation: counter for 10h
    ------------------------------------
    cnt_10h : counter2_bcd
        generic map (
            G_MAX => 9,
            G_BITS => 4
        )
        port map (
            clk => clk,
            rst => rst,
            en  => sig_ovf_h,
            cnt => sig_time_10h,
            ovf => open
        );
        
        
        time_actual(3 downto 0) <= sig_time_ns;
        time_actual(7 downto 4) <= sig_time_ms;
        time_actual(11 downto 8) <= sig_time_s;
        time_actual(15 downto 12) <= sig_time_10s;
        time_actual(19 downto 16) <= sig_time_m;
        time_actual(23 downto 20) <= sig_time_10m;
        time_actual(27 downto 24) <= sig_time_h;
        time_actual(31 downto 28) <= sig_time_10h;
end Behavioral;