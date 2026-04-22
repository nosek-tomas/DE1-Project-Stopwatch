### Counter
čitač
| **Port** | **Direction** | **Type** | **Description** |
| :-: | :-: | :-- | :-- |
| `clk` | in  | `std_logic` | Main clock |
| `rst` | in  | `std_logic` | High-active synchronous reset |
| `en` | in  | `std_logic` | Raw push-button input (may contain bounce) |
| `cnt` | out | `std_logic_vector(1 downto 0)` | One-clock pulse generated when the button is pressed |
| `ovf` | out | `std_logic` | One-clock pulse generated when the button is pressed |
