# Counter2_bcd
čitač
## Vstupy a Výstupy
| **Port** | **Směr** | **Typ** | **Popis** |
| :-: | :-: | :-- | :-- |
| `clk` | in  | `std_logic` | Hlavní hodinový signál (Clock). |
| `rst` | in  | `std_logic` | Synchronní reset. Pokud je '1', vynuluje všechny čítače. |
| `en` | in  | `std_logic` | . |
| `cnt` | out | `std_logic_vector(1 downto 0)` | . |
| `ovf` | out | `std_logic` | . |

## Princip fungování
Komponenta čítá signály ze ([`stopwatch_ctrl`](../docs/stopwatch_ctrl.md)). 
- V setinách a desetinách sekundy počítá 0-9
- V jednotkách sekund, minut a hodin počítá 0-9
- V desítkách sekund, minut a hodin počítá 0-5, 0-5, 0-23

## Schéma zapojení
[Zdrojový kód komponenty](../Vivado%20Project/DE1-Project-Stopwatch_VivadoProject/DE1-Project-Stopwatch_VivadoProject.srcs/sources_1/new/counter2_bcd.vhd)

![Ukázka komp counter2_bcd](../img/readme_pics/counter2_bcd_schema.png)
*(Obrázek: Schéma zapojení čítačů)*

## Simulace (Testbench)
[Zdrojový kód testbenche](../Vivado%20Project/DE1-Project-Stopwatch_VivadoProject/DE1-Project-Stopwatch_VivadoProject.srcs/sources_1/new/counter2_bcd_tb.vhd)

Testbench (`counter2_bcd_tb`) testuje nálsedující **požadované funkce:**



![Ukázka simulace time_counter](../img/simulations/counter2_bcd_sim.png)
