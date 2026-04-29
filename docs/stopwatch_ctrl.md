# Stopwatch_ctrl
- řídí počítání času

## Vstupy a Výstupy
| **Port** | **Směr** | **Typ** | **Popis** |
| :-: | :-: | :-- | :-- |
| `clk` | in  | `std_logic` | Hlavní hodinový signál (Clock). |
| `rst` | in  | `std_logic` | Synchronní reset. Pokud je '1', vynuluje všechno. |
| `btn_in` | in  | `std_logic` | Dává signál k změně operace. |
| `clk_en_in` | in | `std_logic` | Clock signál ustředěný na 100 Hz |
| `clk_en_out` | out | `std_logic` | Clock signál ustředěný na 100 Hz |

## Princip fungování



## Schéma zapojení
[Zdrojový kód komponenty](../Vivado%20Project/DE1-Project-Stopwatch_VivadoProject/DE1-Project-Stopwatch_VivadoProject.srcs/sources_1/new/stopwatch_ctrl.vhd)


## Simualce (Testbench)
