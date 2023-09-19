** Generated for: hspiceD
** Design library name: PIM
** Design cell name: test

.TEMP 25.0

*.INCLUDE "/public/home/anlh/PDKs/FreePDK45/ncsu_basekit/models/hspice/tran_models/models_nom/PMOS_VTL.inc"
*.INCLUDE "/public/home/anlh/PDKs/FreePDK45/ncsu_basekit/models/hspice/tran_models/models_nom/NMOS_VTL.inc"
.INCLUDE "../../model/PMOS_VTL.inc"
.INCLUDE "../../model/NMOS_VTL.inc"

.global vdd gnd

** Library name: PIM
** Cell name: MRAM_cell
.subckt MRAM_cell bl gnd sl wl
xi0 net7 bl MTJ 
m0 net7 wl sl gnd NMOS_VTL L=50e-9 W=90e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
.ends MRAM_cell
** End of subcircuit definition.

** Library name: PIM
** Cell name: MRAM_cell_P
.subckt MRAM_cell_P bl gnd sl wl
xi3 net7 bl MTJ_P
**m0 net7 wl sl gnd NMOS_VTL L=50e-9 W=90e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
.ends MRAM_cell_P
** End of subcircuit definition.

** Library name: PIM
** Cell name: 2_1MUX
.subckt PIM_2_1MUX gnd i0 i1 out s vdd
m13 sn s vdd vdd PMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m17 net017 sn net025 vdd PMOS_VTL L=50e-9 W=360e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m18 out net017 vdd vdd PMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m15 net024 i0 vdd vdd PMOS_VTL L=50e-9 W=360e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m14 net025 i1 vdd vdd PMOS_VTL L=50e-9 W=360e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m16 net017 s net024 vdd PMOS_VTL L=50e-9 W=360e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m6 out net017 gnd gnd NMOS_VTL L=50e-9 W=90e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m4 net017 i0 net014 gnd NMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m1 net014 sn gnd gnd NMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m5 net017 s net014 gnd NMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m2 sn s gnd gnd NMOS_VTL L=50e-9 W=90e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m0 net014 i1 gnd gnd NMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
.ends PIM_2_1MUX
** End of subcircuit definition.

** Library name: PIM
** Cell name: NAND
.subckt NAND a b gnd out vdd
m4 net17 b gnd gnd NMOS_VTL L=50e-9 W=90e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m2 out a net17 gnd NMOS_VTL L=50e-9 W=90e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m3 out b vdd vdd PMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m0 out a vdd vdd PMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
.ends NAND
** End of subcircuit definition.

** Library name: PIM
** Cell name: inverter
.subckt inverter gnd in out vdd
m0 out in gnd gnd NMOS_VTL L=50e-9 W=90e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m1 out in vdd vdd PMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
.ends inverter
** End of subcircuit definition.

** Library name: PIM
** Cell name: buffer
.subckt buffer gnd in out vdd
xi1 gnd net11 out vdd inverter
xi0 gnd in net11 vdd inverter
.ends buffer
** End of subcircuit definition.

** Library name: PIM
** Cell name: TG
.subckt TG en gnd in out vdd
m0 in en out gnd NMOS_VTL L=50e-9 W=90e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m1 in net15 out vdd PMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
xi0 gnd en net15 vdd inverter
.ends TG
** End of subcircuit definition.

** Library name: PIM
** Cell name: SenseAp
.subckt SenseAp en gnd pec vdata vdd vo1 vo2 vref
m1 vo2 vo1 vdd vdd PMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m0 vo1 vo2 vdd vdd PMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m7 vo2 pec vo1 vdd PMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m2 vo1 vdata net10 gnd NMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m5 net013 vo2 net10 gnd NMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m6 net018 vo1 net013 gnd NMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m4 net018 vref vo2 gnd NMOS_VTL L=50e-9 W=180e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
m3 net013 en gnd gnd NMOS_VTL L=50e-9 W=90e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
.ends SenseAp
** End of subcircuit definition.

** Library name: PIM
** Cell name: Reference_Gen
.subckt Reference_Gen gnd rw0 vdd vref
r4 vref vdd 20e3
r2 net17 vref 2.2e3
m2 net17 rw0 gnd gnd NMOS_VTL L=50e-9 W=90e-9 AD=9.45e-15 AS=9.45e-15 PD=300e-9 PS=300e-9 M=1
.ends Reference_Gen
** End of subcircuit definition.

** Library name: PIM
** Cell name: Col_control
.subckt Col_control bl bl_in en gnd out out_b pec rw sl_in vdd
xi0 gnd gnd net031 out_b and_out vdd PIM_2_1MUX
xi153 gnd gnd net29 out and_out vdd PIM_2_1MUX
xi152 bl_in pec gnd and_out vdd NAND
xi16 gnd net25 net29 vdd buffer
xi1 gnd net30 net031 vdd buffer
xi142 bl gnd bl bl_in vdd TG
xi137 sl_in gnd gnd bl_in vdd TG
xi2 en gnd pec bl_in vdd net30 net25 net017 SenseAp
xi121 gnd rw vdd net017 Reference_Gen
.ends Col_control
** End of subcircuit definition.

** Library name: PIM
** Cell name: array
.subckt array bl_0 bl_1 bl_2 bl_3 bl_4 bl_5 bl_6 bl_7 en gnd out0 out1 out2 out3 out4 out5 out6 out7 out_b0 out_b1 out_b2 out_b3 out_b4 out_b5 out_b6 out_b7 pec rw sl0 sl1 sl2 sl3 sl4 sl5 sl6 sl7 vdd wl0 wl1 wl2 wl3 wl4 wl5 wl6 wl7 wl8
xi216 bl0 gnd sl0 wl0 MRAM_cell
xi217 bl0 gnd sl0 wl1 MRAM_cell_P
xi29 bl0 gnd sl0 wl2 MRAM_cell_P
xi45 bl0 gnd sl0 wl3 MRAM_cell
xi218 bl0 gnd sl0 wl4 MRAM_cell
xi85 bl0 gnd sl0 wl5 MRAM_cell_P
xi219 bl0 gnd sl0 wl6 MRAM_cell_P
xi81 bl0 gnd sl0 wl7 MRAM_cell_P
xi134 bl0 gnd sl0 wl8 MRAM_cell
xi220 bl1 gnd sl1 wl0 MRAM_cell
xi221 bl1 gnd sl1 wl1 MRAM_cell
xi225 bl1 gnd sl1 wl2 MRAM_cell
xi226 bl1 gnd sl1 wl3 MRAM_cell_P
xi227 bl1 gnd sl1 wl4 MRAM_cell_P
xi248 bl1 gnd sl1 wl5 MRAM_cell_P
xi228 bl1 gnd sl1 wl6 MRAM_cell_P
xi244 bl1 gnd sl1 wl7 MRAM_cell
xi246 bl1 gnd sl1 wl8 MRAM_cell
xi47 bl2 gnd sl2 wl0 MRAM_cell_P
xi222 bl2 gnd sl2 wl1 MRAM_cell
xi229 bl2 gnd sl2 wl2 MRAM_cell_P
xi230 bl2 gnd sl2 wl3 MRAM_cell
xi37 bl2 gnd sl2 wl4 MRAM_cell_P
xi236 bl2 gnd sl2 wl5 MRAM_cell
xi237 bl2 gnd sl2 wl6 MRAM_cell
xi245 bl2 gnd sl2 wl7 MRAM_cell_P
xi73 bl2 gnd sl2 wl8 MRAM_cell_P
xi48 bl3 gnd sl3 wl0 MRAM_cell
xi18 bl3 gnd sl3 wl1 MRAM_cell
xi231 bl3 gnd sl3 wl2 MRAM_cell_P
xi32 bl3 gnd sl3 wl3 MRAM_cell
xi235 bl3 gnd sl3 wl4 MRAM_cell_P
xi238 bl3 gnd sl3 wl5 MRAM_cell
xi239 bl3 gnd sl3 wl6 MRAM_cell_P
xi247 bl3 gnd sl3 wl7 MRAM_cell_P
xi249 bl3 gnd sl3 wl8 MRAM_cell
xi223 bl4 gnd sl4 wl0 MRAM_cell
xi21 bl4 gnd sl4 wl1 MRAM_cell_P
xi224 bl4 gnd sl4 wl2 MRAM_cell
xi233 bl4 gnd sl4 wl3 MRAM_cell_P
xi241 bl4 gnd sl4 wl4 MRAM_cell
xi240 bl4 gnd sl4 wl5 MRAM_cell
xi63 bl4 gnd sl4 wl6 MRAM_cell
xi71 bl4 gnd sl4 wl7 MRAM_cell
xi250 bl4 gnd sl4 wl8 MRAM_cell
xi50 bl5 gnd sl5 wl0 MRAM_cell_P
xi22 bl5 gnd sl5 wl1 MRAM_cell_P
xi232 bl5 gnd sl5 wl2 MRAM_cell_P
xi234 bl5 gnd sl5 wl3 MRAM_cell
xi242 bl5 gnd sl5 wl4 MRAM_cell
xi243 bl5 gnd sl5 wl5 MRAM_cell_P
xi62 bl5 gnd sl5 wl6 MRAM_cell
xi72 bl5 gnd sl5 wl7 MRAM_cell
xi78 bl5 gnd sl5 wl8 MRAM_cell
xi49 bl6 gnd sl6 wl0 MRAM_cell_P
xi19 bl6 gnd sl6 wl1 MRAM_cell_P
xi25 bl6 gnd sl6 wl2 MRAM_cell
xi33 bl6 gnd sl6 wl3 MRAM_cell_P
xi254 bl6 gnd sl6 wl4 MRAM_cell
xi255 bl6 gnd sl6 wl5 MRAM_cell_P
xi55 bl6 gnd sl6 wl6 MRAM_cell
xi69 bl6 gnd sl6 wl7 MRAM_cell
xi75 bl6 gnd sl6 wl8 MRAM_cell_P
xi251 bl7 gnd sl7 wl0 MRAM_cell
xi252 bl7 gnd sl7 wl1 MRAM_cell
xi26 bl7 gnd sl7 wl2 MRAM_cell
xi253 bl7 gnd sl7 wl3 MRAM_cell
xi40 bl7 gnd sl7 wl4 MRAM_cell
xi256 bl7 gnd sl7 wl5 MRAM_cell
xi61 bl7 gnd sl7 wl6 MRAM_cell
xi257 bl7 gnd sl7 wl7 MRAM_cell
xi258 bl7 gnd sl7 wl8 MRAM_cell_P
r7 bl4 vdd 20e3
r6 bl5 vdd 20e3
r5 bl7 vdd 20e3
r4 bl6 vdd 20e3
r2 bl2 vdd 20e3
r1 bl3 vdd 20e3
r0 bl1 vdd 20e3
r3 bl0 vdd 20e3
xi206 bl_4 bl4 en gnd out4 out_b4 pec rw sl4 vdd Col_control
xi199 bl_5 bl5 en gnd out5 out_b5 pec rw sl5 vdd Col_control
xi198 bl_6 bl6 en gnd out6 out_b6 pec rw sl6 vdd Col_control
xi154 bl_0 bl0 en gnd out0 out_b0 pec rw sl0 vdd Col_control
xi182 bl_3 bl3 en gnd out3 out_b3 pec rw sl3 vdd Col_control
xi187 bl_7 bl7 en gnd out7 out_b7 pec rw sl7 vdd Col_control
xi173 bl_2 bl2 en gnd out2 out_b2 pec rw sl2 vdd Col_control
xi170 bl_1 bl1 en gnd out1 out_b1 pec rw sl1 vdd Col_control
.ends array
** End of subcircuit definition.

*.hdl "/public/home/anlh/PIM/MTJ/veriloga/veriloga.va"
*.hdl "/public/home/anlh/PIM/MTJ_P/veriloga/veriloga.va"
.hdl "../../model/MTJ/veriloga/veriloga.va"
.hdl "../../model/MTJ_P/veriloga/veriloga.va"
