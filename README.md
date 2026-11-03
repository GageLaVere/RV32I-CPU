# Overview

A RV32I compliant CPU, implemented in VHDL.

Currently a work in progress, once it's completely functional under Risc-V I'll freeze the repo and fork from there.

# Roadmap

Currently only have ALU and RegisterFile. Next is instruction decoding, under InstructionHandler directory.

This repo will be finished when:

All RV32I instructions are functional
CPU executes programs correctly

# Hardware / toolchain

I'm currently using the ULX3S development kit, which has the ECP5-85F FPGA onboard. 
I'm using Lattice Diamond to synthesize, with GHDL and GTKWave to verify design / debug.