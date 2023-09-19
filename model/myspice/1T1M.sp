1T1M testbench
.temp 25
.option post ingold=1
$.option
$+    ARTIST=2
$+    INGOLD=2
$+    PARHIER=LOCAL
$+    PSF=2

.include '32nm_bulk.pm'
.hdl 'MTJcad.va'

.param rise_time=100ps                           $ rise time
.param fall_time = 100ps                         $ fall time
.param VWL=0.7V                                 $ word line
.param VBL=0.8V                                 $ bit line
.param pulse_delay=2ns                          $ pulse delay
.param pulse_width=5ns                         $ pulse width
.param end_time='pulse_delay+pulse_width+10n'   $ total simulation time

X1 Node BL MTJmodel                             $ MTJ    
M1 Node WL SL 0 nmos W=100n L=32n                $ Transistor

.pat vbl = b100000
.pat vsl = b000000
.pat vwl = b100000
V_BL BL 0 pat 1.2 0 0 0.1e-9 0.1e-9 pulse_width vbl
V_SL SL 0 pat 1.2 0 0 0.1e-9 0.1e-9 pulse_width vsl
V_WL WL 0 pat 1.2 0 0 0.1e-9 0.1e-9 pulse_width vwl
$V_BL BL 0 PULSE(0V VBL pulse_delay rise_time fall_time pulse_width end_time)
$V_BL BL 0 DC VBL
$V_WL WL 0 DC VWL
$V_SL SL 0 DC 0V

.tran 1ps 30ns$end_time
.print V(BL) V(Node) V(BL,Node) V(SL)
.print V(X1.mz) V(X1.I_MTJ) V(X1.V_MTJ) V(X1.R_out)
.end