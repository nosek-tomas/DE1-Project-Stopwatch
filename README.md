# DE1-Project-Stopwatch

Semestrální projekt z předmětu BPC-DE1 - VHDL StopWatch

Členové týmu
Matěj Berger
Tomáš Nosek
Eduard Josefík

Digitalní stopky s funkci lap
Cílem projektu je v rámci předmětu DE1 navrhnout a implementovat digitální stopky s funkcí uložení mezi času (lap). K realizaci projektu je použita deska Arty A7 50, která slouží jako hlavní řídící jednotka. Projekt je složen z několika bloků: clk_en pro generování časových pulzů, counter jako binarního čitače, reg_lap jako registru pro ukládání mezičasu, disp_driver jako budiče sedmisegmentového displeye, který zajišťuje zobrazení uložených lap časů. 
K ovládání stopek slouží integrovaná tlačítka desky pro funkce start/stop, reset a uložení mezičasu.
Zdrojový kod je v jazyce VHDL, testovací prostředí a simulace vytvořeny pomocí programu Vivado.
<img width="1349" height="606" alt="IMG_0178" src="https://github.com/user-attachments/assets/0b7e4dfb-99b2-4364-b262-5a2a3b8f0625" />
