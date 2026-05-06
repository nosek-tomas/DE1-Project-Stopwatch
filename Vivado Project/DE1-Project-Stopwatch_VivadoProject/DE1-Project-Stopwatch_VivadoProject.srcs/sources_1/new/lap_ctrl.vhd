library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity lap_ctrl is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        lap_button : in STD_LOGIC;                              -- Button to store actual time to memory
        time_actual : in STD_LOGIC_VECTOR (31 downto 0);        -- Actual time to store
        sw : in STD_LOGIC_VECTOR (15 downto 0);                 -- Switches to choose memory slot to display
        lap_time_output : out STD_LOGIC_VECTOR (31 downto 0);   -- Time from memory to be displayed
        show_lap :  out STD_LOGIC;                              -- Info to display_ctrl that we want to show time from lap_ctrl
        led : out STD_LOGIC_VECTOR (15 downto 0)                -- LEDs to indicate
        
      );
end lap_ctrl;

architecture Behavioral of lap_ctrl is

    ----------------------------------------------------------------
    -- 1. Component declaration 
    ----------------------------------------------------------------
    -- Clock enable --> freqency of LED blinking
    component clk_en is
        generic ( G_MAX : positive);  
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               ce : out STD_LOGIC);
    end component clk_en;
    
    -- Counting from 0 to 1 for changing state of LED in active memory slot
    component counter2_bcd is
    generic ( 
        G_BITS : positive;
        G_MAX : positive
    );  
    port (
        clk : in  std_logic;                              -- Main clock
        rst : in  std_logic;                              -- High-active synchronous reset
        en  : in  std_logic;                              -- Clock enable input
        cnt : out std_logic_vector(G_BITS - 1 downto 0);  -- Counter value
        ovf : out std_logic                               -- Overflow to next counter
    );
    end component counter2_bcd;
 
    ----------------------------------------------------------------
    -- 2. Signal Declaration
    ----------------------------------------------------------------
    signal sig_ce_2hz : STD_LOGIC;                      -- for LED Blinkg
    signal sig_blinking : STD_LOGIC;                    -- for LED Blinkg
    signal sig_write_ptr : integer range 0 to 16 := 0;  -- Numeric pointer to first free memory slot to write
    
    ----------------------------------------------------------------
    -- 3. LAP memory "storage"
    ----------------------------------------------------------------
    type t_memory is array (0 to 15) of std_logic_vector(31 downto 0); --new datatype
    signal sig_memory : t_memory := (others => (others => '0'));         -- Create storage and initialise with zeros 
    
begin

    ----------------------------------------------------------------
    -- Clock Enable instantiation --> for LED blinking (2Hz)
    ----------------------------------------------------------------
    blink_gen : clk_en
        generic map ( G_MAX => 50_000_000 ) -- 100MHz / 2Hz = 50M
        port map (
            clk => clk,
            rst => rst,
            ce => sig_ce_2hz
        );
     
     cnt_blink : counter2_bcd
        generic map (
            G_MAX => 1,
            G_BITS => 1
        )
        port map (
            clk => clk,
            rst => rst,
            en  => sig_ce_2hz,
            cnt(0) => sig_blinking,
            ovf => open 
        );
    ----------------------------------------------------------------
    -- Saveing actual time to memory
    ----------------------------------------------------------------        
    p_memory_write : process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                sig_memory <= (others => (others => '0')); -- reset memory
                -- led <= (others => '0'); -- reset LEDS; no needindg for that, state is based on memory allocation
                sig_write_ptr <= 0;    -- move pointer to first memory slot
            elsif lap_button = '1' then
                if sig_write_ptr < 16 then
                        sig_memory(sig_write_ptr) <= time_actual; --save to actually pointed memory slot
                        sig_write_ptr <= sig_write_ptr + 1;     -- increment pointer to next memory slot
                    end if;
            end  if;
        end  if;
    end process p_memory_write;
    
    ----------------------------------------------------------------
    -- Reading and showing selected lap from memory
    ----------------------------------------------------------------     
    p_memory_read_and_leds : process (sw, sig_write_ptr, sig_memory, sig_ce_2hz)
    begin
        
        -- Set dafault values which will be set at the end of process, if nothing else done in process
        lap_time_output <= (others => '0');
        show_lap <= '0';            
        led  <= (others => '0'); 

        -- Show saved memories from left side of the board
        for i in 0 to 15 loop
            if i < sig_write_ptr then
                led(15 - i) <= '1';
            end if;
        end loop;

        -- 3) Searching for active switch with saved data --> from left side of board. First from left has priority
        for i in 0 to 15 loop
            if sw(15 - i) = '1' and i < sig_write_ptr then
                lap_time_output <= sig_memory(i);
                show_lap <= '1';
                led(15 - i) <= sig_blinking; -- LED blinking
                
                exit; -- End searching for active switch
                
            end if;
        end loop;
    end process p_memory_read_and_leds;

end Behavioral;
