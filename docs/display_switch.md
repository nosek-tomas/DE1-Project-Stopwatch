### Display_switch
- ovládá input data pro driver

| **Port** | **Direction** | **Type** | **Description** |
| :-: | :-: | :-- | :-- |
| `data_live` | in  | `std_logic_vector(31 down to 0)` | Main clock |
| `data_lap` | in  | `std_logic` | High-active synchronous reset |
| `show_lap` | in  | `std_logic` | Raw push-button input (may contain bounce) |
| `data_out` | out | `std_logic_vector(31 down to 0)` | One-clock pulse generated when the button is pressed |
