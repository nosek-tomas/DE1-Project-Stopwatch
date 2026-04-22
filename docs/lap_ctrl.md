### Lap_ctrl
- složí jako paměť k ukládání a vyvolávání času

| **Port** | **Direction** | **Type** | **Description** |
| :-: | :-: | :-- | :-- |
| `time_in` | in  | `std_logic` | Main clock |
| `clk` | in  | `std_logic` | Main clock |
| `rst` | in  | `std_logic` | High-active synchronous reset |
| `btn_in` | in  | `std_logic` | Raw push-button input (may contain bounce) |
| `time_out` | out | `std_logic` | One-clock pulse generated when the button is pressed |
| `led` | out | `std_logic_vector(15 down to 0)` | One-clock pulse generated when the button is pressed |
