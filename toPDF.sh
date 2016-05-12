a2ps --pretty-print=Verilog --columns=1 --rows=1 -R VerilogWorkSheet.sv -o VerilogWorkSheet.ps
ps2pdf VerilogWorkSheet.ps
rm VerilogWorkSheet.ps
