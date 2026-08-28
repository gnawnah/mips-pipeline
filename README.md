## Related
[approx-mult](https://github.com/gnawnah/approx-mult) — approximate multiplier

# mips-pipeline
This project is inspired by COMPSYS304: Computer Architecture.

Commands:
1. Compile:
iverilog -g2012 -o regfile_sim rtl/regfile.sv tb/regfile_tb.sv
2. Run:
vvp regfile_sim
3. View waveform
gtkwave regfile.vcd