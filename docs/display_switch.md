# Komponenta: `Display_switch`
- ovládá input data pro driver

| **Port** | **Směr** | **Typ** | **Popis** |
| :-: | :-: | :-- | :-- |
| `data_live` | in  | `std_logic_vector(31 down to 0)` | Vstup aktuálního času z time_counteru |
| `data_lap` | in  | `std_logic` | Vstup času uložený v 32 bitech z lap_ctrl |
| `show_lap` | in  | `std_logic` | Pokud show_lap '1' zobrazí uložený čas |
| `data_out` | out | `std_logic_vector(31 down to 0)` | Výstup zvoleného času do display_driveru |

## Princip fungování



## Schéma zapojení
[Zdrojový kód komponenty](../Vivado%20Project/DE1-Project-Stopwatch_VivadoProject/DE1-Project-Stopwatch_VivadoProject.srcs/sources_1/new/display_ctrl.vhd)



## Simulace (testbench)
[Zdrojový kód testbenche](../Vivado%20Project/DE1-Project-Stopwatch_VivadoProject/DE1-Project-Stopwatch_VivadoProject.srcs/sim_1/new/stopwatch_ctrl_tb.vhd)



![Ukázka simulace display_switch](../img/simulations/display_ctrl_sim.png)
