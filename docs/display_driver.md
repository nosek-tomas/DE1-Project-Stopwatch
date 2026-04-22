### Display_driver
- ovládá segmenty na 7 segmentovém display, podle dat z display_switche

| **Port** | **Direction** | **Type** | **Description** |
| :-: | :-: | :-- | :-- |
| `clk` | in  | `std_logic` | Main clock |
| `rst` | in  | `std_logic` | High-active synchronous reset |
| `data` | in  | `std_logic_vector(31 down to 0)` | Raw push-button input (may contain bounce) |
| `anode` | out | `std_logic_vector(7 down to 0)` | One-clock pulse generated when the button is pressed |
| `seg` | out | `std_logic_vector(6 down to 0)` | One-clock pulse generated when the button is pressed |
