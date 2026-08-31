test:
	iverilog -g2012 -o sim rtl/*.sv tb/datapath_tb.sv && vvp sim
clean:
	rm -f sim *.vcd