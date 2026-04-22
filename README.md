# Semestrální projekt z předmětu BPC-DE1 - VHDL StopWatch (lap)

## Členové týmu:
- Matěj Berger
- Tomáš Nosek 
- Eduard Josefík

## Digitalní stopky s funkci lap:
- Cílem projektu je v rámci předmětu DE1 navrhnout a implementovat **digitální stopky s funkcí uložení mezi času (lap)**. K realizaci projektu je použita deska **Nexys A7 50t**, která slouží jako hlavní řídící jednotka.
- Projekt je složen z několika bloků:
  - `clk_en` pro generování časových pulzů
  - `debouncer` pro eliminaci chvění signálu z tlačítka
  - `stopwatch_ctrl` jako ovladač časového čitače
  - `time_counter` jako binarní čitač času
  - `lap_ctrl` jako registru pro ukládání mezičasu
  - `display_swtich` jako datov přepínač displayového ovladače
  - `disp_driver2` jako budiče sedmisegmentového displeye, který zajišťuje zobrazení uložených lap časů. 
- K ovládání stopek slouží **integrovaná tlačítka** desky pro funkce start/stop, reset a uložení mezičasu.
Zdrojový kod je v jazyce **VHDL**, testovací prostředí a simulace vytvořeny pomocí programu **Vivado**.

### Top-level schéma:
<img width="1349" height="606" alt="IMG_0178" src="./img/readme_pics/top_level.jpg" />

### Princip ovládání:
<img width="1152" height="648" alt="SCHEMA_s_popisky" src="./img/readme_pics/SCHEMA_s_popisky.jpg" />




## Hardware:
- Nexys A7 50t board is a complete, ready-to-use digital circuit development platform based on the latest AMD Artix™ 7 Field Programmable Gate Array (FPGA) from AMD. With its large, high-capacity FPGA, generous external memories, and collection of USB, Ethernet, and other ports, the Nexys A7 can host designs ranging from introductory combinational circuits to powerful embedded processors. Several built-in peripherals, including an accelerometer, temperature sensor, MEMs digital microphone, a speaker amplifier, and several I/O devices allow the Nexys A7 to be used for a wide range of designs without needing any other components.
### Nexys A7 50t board:
<img width="600" height="434" alt="nexys-a7" src="./img/readme_pics/nexys-a7.png" />


## VHDL componenty:

- **[Stopwatch_ctrl](docs/stopwatch_ctrl.md):**

- **[Time_counter](docs/time_counter.md):**

- **[Lap_ctrl](docs/lap_ctrl.md):**

- **[Display_switch](docs/display_switch.md):**

- **[Display_driver](docs/display_driver.md):**
