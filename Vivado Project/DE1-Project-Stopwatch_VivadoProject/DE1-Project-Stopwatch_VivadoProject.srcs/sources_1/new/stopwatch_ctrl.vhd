library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity stopwatch_ctrl is
    Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        btn_in  : in  STD_LOGIC; -- Btn input (afterd debounce)
        clk_en_in   : in  STD_LOGIC; 
        clk_en_out  : out STD_LOGIC  
    );
end stopwatch_ctrl;

architecture Behavioral of stopwatch_ctrl is
    signal sig_running : STD_LOGIC := '0';

begin
    
    process_toggle : process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                sig_running <= '0'; -- Stop after reset
                
            elsif btn_in = '1' then
                    -- Toggle to running state
                sig_running <= not sig_running; 
            end if;
        end if;
    end process process_toggle;


    -- OUTPUT SIGNAL --> based on inputted clk_en and state of run/stop 
    clk_en_out <= clk_en_in and sig_running;

end Behavioral;