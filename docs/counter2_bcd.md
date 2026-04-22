### Time_counter
- sčítá signály po 10ns, které pak nechává přetéct na vyšší jednotky

| **Port** | **Direction** | **Type** | **Description** |
| :-: | :-: | :-- | :-- |
| `clk` | in  | `std_logic` | Main clock |
| `rst` | in  | `std_logic` | High-active synchronous reset |
| `en` | in  | `std_logic` | Raw push-button input (may contain bounce) |
| `time_actual` | in | `std_logic_vector(31 down to 0)` | One-clock pulse generated when the button is pressed |
