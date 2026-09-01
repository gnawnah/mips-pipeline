## Related projects
[approx-mult](https://github.com/gnawnah/approx-mult) — approximate multiplier

# mips-pipeline

A single-cycle MIPS processor implemented in SystemVerilog, verified with self-checking testbenches.

## About

This project implements the single-cycle MIPS datapath taught in COMPSYS 304
(Computer Architecture) at the University of Auckland, built from scratch in
SystemVerilog as a set of independently-tested modules. All ten supported
instructions execute correctly and are verified by an integration test that
runs a program exercising every instruction and checks the final register and
memory state.

Pipelining (a 5-stage implementation with hazard detection and forwarding) is
planned as the next phase.

## Supported instructions

- **R-type:** `add`, `sub`, `and`, `or`, `slt`
- **I-type:** `addi`, `lw`, `sw`, `beq`
- **J-type:** `j`

## Architecture

The datapath is split into small, single-purpose modules, each with its own
testbench:

| Module | Role |
|--------|------|
| `alu` | Performs the arithmetic/logic operations; outputs a zero flag for `beq` |
| `alu_control` | Decodes `ALUOp` (from main control) and the funct field into the ALU control code |
| `main_control` | Decodes the instruction opcode into the datapath control signals |
| `regfile` | 32 x 32-bit register file, dual read ports, one write port |
| `imem` | Instruction memory, preloaded with the program via `$readmemh` |
| `dmem` | Data memory, read/write, for `lw`/`sw` |
| `sign_extend` | Sign-extends the 16-bit immediate to 32 bits (I-type) |
| `pc` | Program counter register |
| `adder` | Adds two 32-bit values (used for PC+4 and the branch target) |
| `mux` | Parameterised 2-to-1 multiplexer, reused throughout the datapath |
| `datapath` | Top-level: wires all modules into the single-cycle CPU |

## Build & run

Requires [Icarus Verilog](http://iverilog.icarus.com/) (and optionally GTKWave
for waveforms).

    make test      # compile and run the integration test
    make clean     # remove build artifacts

The integration test loads `program.hex` into instruction memory, runs it to
completion, and checks the final register and memory state against expected
values.

## Testing

Each module has its own self-checking testbench under `tb/`. The top-level
integration test (`tb/datapath_tb.sv`) runs a program that exercises all ten
instructions — including a taken branch and a jump that must skip over
"poison" instructions — and verifies the resulting state, so a passing run
confirms the whole datapath end to end.