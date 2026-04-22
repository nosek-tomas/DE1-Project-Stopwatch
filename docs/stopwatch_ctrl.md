### Stopwatch_ctrl
- řídí počítání času
  
| **Port** | **Direction** | **Type** | **Description** |
| :-: | :-: | :-- | :-- |
| `clk` | in  | `std_logic` | Main clock |
| `rst` | in  | `std_logic` | High-active synchronous reset |
| `btn_in` | in  | `std_logic` | Raw push-button input (may contain bounce) |
| `clk_en_in` | in | `std_logic` | One-clock pulse generated when the button is pressed |
| `clk_en_out` | out | `std_logic` | One-clock pulse generated when the button is pressed |
