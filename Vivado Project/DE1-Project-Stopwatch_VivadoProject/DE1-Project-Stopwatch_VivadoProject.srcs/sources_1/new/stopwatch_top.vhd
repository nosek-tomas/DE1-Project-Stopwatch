library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity stopwatch_top is
    Port ( clk : in STD_LOGIC;
           btnd : in STD_LOGIC; -- Reset
           btnl : in STD_LOGIC; -- Start/stop
           --btnr : in STD_LOGIC;  -- Lap
           seg : out STD_LOGIC_VECTOR (6 downto 0); -- Segment display
           an : out STD_LOGIC_VECTOR (7 downto 0); -- Anodes to turn on specific display
           dp :out STD_LOGIC
           );
end stopwatch_top;

architecture Behavioral of stopwatch_top is

    ------------------------------------------------------------------------
    -- 1. Component Declarations 
    ------------------------------------------------------------------------
    
    component debounce is
        Port ( 
            clk        : in STD_LOGIC;
            rst        : in STD_LOGIC;
            btn_in     : in STD_LOGIC;
            btn_state  : out STD_LOGIC;
            btn_press  : out STD_LOGIC;
            btn_relase : out STD_LOGIC
        );
    end component;

    component clk_en is
        generic ( G_MAX : positive );
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            ce  : out std_logic
        );
    end component;

    component stopwatch_ctrl is
        Port (
            clk         : in  STD_LOGIC;
            rst         : in  STD_LOGIC;
            btn_in      : in  STD_LOGIC; 
            clk_en_in   : in  STD_LOGIC; 
            clk_en_out  : out STD_LOGIC  
        );
    end component;

    component time_counter is
        Port (
            clk      : in  STD_LOGIC;
            rst      : in  STD_LOGIC;
            en       : in  STD_LOGIC;
            time_actual : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component display_ctrl is
        Port ( 
            data_live : in  STD_LOGIC_VECTOR (31 downto 0);
            data_lap  : in  STD_LOGIC_VECTOR (31 downto 0);
            show_lap  : in  STD_LOGIC;
            data_out  : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    component display_driver2 is
        Port ( 
            clk   : in STD_LOGIC;
            rst   : in STD_LOGIC;
            data  : in STD_LOGIC_VECTOR (31 downto 0);
            seg   : out STD_LOGIC_VECTOR (6 downto 0);
            anode : out STD_LOGIC_VECTOR (7 downto 0);
            datapoint : out STD_LOGIC
        );
    end component;
    
    ------------------------------------------------------------------------
    -- 2.  Signal Declarations
    ------------------------------------------------------------------------
    -- Signals for buttons
     signal sig_btn_toggle_debounced_pulse: std_logic;
    
    -- Signals for time ticks
    signal sig_ce_100Hz : std_logic;
    signal sig_ce_100Hz_toggled : std_logic;
    
    -- Signals for time data
    signal sig_actual_time : STD_LOGIC_VECTOR (31 downto 0);
    signal sig_display_time : STD_LOGIC_VECTOR (31 downto 0);
    
begin
    ------------------------------------------------------------------------
    -- 3.  Component Instantiation
    ------------------------------------------------------------------------
    -- Clock enable 100 Hz for time counting
    clk_en_100hz_inst : clk_en
        generic map ( G_MAX => 1000000 ) -- 100 MHz / 100 Hz = 1 000 000
        port map (
            clk => clk,
            rst => btnd,
            ce  => sig_ce_100Hz
        );  
        
    -- Debouncer for Start/Stop button
    debouncer_btn_toggle_inst : debounce
        port map (
            clk        => clk,
            rst        => btnd,
            btn_in     => btnl,
            btn_state  => open, -- Not used
            btn_press  => sig_btn_toggle_debounced_pulse, 
            btn_relase => open  -- Not used
        );

    -- Control unit (Start / Stop logic)
    stopwatch_ctrl_inst : stopwatch_ctrl
        port map (
            clk         => clk,
            rst         => btnd,
            btn_in      => sig_btn_toggle_debounced_pulse,
            clk_en_in   => sig_ce_100Hz,
            clk_en_out  => sig_ce_100Hz_toggled
        );
        
    -- Time counter
    time_counter_inst : time_counter
        port map (
            clk      => clk,
            rst      => btnd,
            en       => sig_ce_100Hz_toggled,
            time_actual => sig_actual_time
        );
  
  -- Display switcher (Live or LAP)
    display_switch_inst : display_ctrl
        port map (
            data_live => sig_actual_time,
            data_lap  => x"12345678", --dummy value for first version
            show_lap  => '0',        -- Dont have LAP implemented yet
            data_out  => sig_display_time
        );

    -- Display driver 
    display_driver2_inst : display_driver2
        port map (
            clk   => clk,
            rst   => btnd,
            data  => sig_display_time,
            seg   => seg,
            anode => an,
            datapoint => dp
        );
    
end Behavioral;
