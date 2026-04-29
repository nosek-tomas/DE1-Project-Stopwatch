# Komponenta: `stopwatch_ctrl`
Funguje jako řídící jednotka pro `time_counter`. Vypíná a zapíná tok clock signálu clock_en zformovaného na 100 Hz. 
## Vstupy a Výstupy
| **Port** | **Směr** | **Typ** | **Popis** |
| :-: | :-: | :-- | :-- |
| `clk` | in  | `std_logic` | Hlavní hodinový signál (Clock). |
| `rst` | in  | `std_logic` | Synchronní reset. Pokud je '1', vynuluje všechno. |
| `btn_in` | in  | `std_logic` | Dává signál k změně operace. |
| `clk_en_in` | in | `std_logic` | Clock signál ustředěný na 100 Hz |
| `clk_en_out` | out | `std_logic` | Clock signál ustředěný na 100 Hz |

## Princip fungování
Po stisku `BTNL` začne propouštět clc_en signál do counteru nebo naopak přestane propouštět signál.


## Schéma zapojení
[Zdrojový kód komponenty](../Vivado%20Project/DE1-Project-Stopwatch_VivadoProject/DE1-Project-Stopwatch_VivadoProject.srcs/sources_1/new/stopwatch_ctrl.vhd)


## Simualce (Testbench)
[Zdrojový kód testbenche](../Vivado%20Project/DE1-Project-Stopwatch_VivadoProject/DE1-Project-Stopwatch_VivadoProject.srcs/sim_1/new/stopwatch_ctrl_tb.vhd)
