# Display_driver
- ovládá segmenty na 7 segmentovém display, podle dat z display_switche


## Vstupy a výstupy
| **Port** | **Směr** | **Typ** | **Popis** |
| :-: | :-: | :-- | :-- |
| `clk` | in  | `std_logic` | Hlavní hodinový signál (Clock). |
| `rst` | in  | `std_logic` | Synchronní reset. Pokud je '1', vynuluje všechny čítače. |
| `data` | in  | `std_logic_vector(31 down to 0)` | Vstup 32 bitů ze switche. |
| `anode` | out | `std_logic_vector(7 down to 0)` | 8 bitový výstup, který ovládá čísla. |
| `seg` | out | `std_logic_vector(6 down to 0)` | Ovladač segmentů v 7 segmentovém čísle. |

## Princip fungování


## Schéma zapojení
[Zdrojový kód komponenty](../Vivado%20Project/DE1-Project-Stopwatch_VivadoProject/DE1-Project-Stopwatch_VivadoProject.srcs/sources_1/new/display_driver2.vhd)

(Obrázek)

## Simulace (Testbench)

