# RISC-V CORE


### What is RISCV
    RISC-V is an open source instruction set architecture. Every processor are in simplistic view are set of logic elements connected together. To accomplish high level tasks such as video editting, browsing on the internet or simulating complicated mechanical designs, we would need a a lot easier interface to be able to do anything. Graphical user interface is a simple interface to the code, code is a simple interface to the machine. Machine can only understand binary information which means the code must be transformed to the binary data. That data must be in such order that desired task can be accomplished by the logic gates. Instruction set architectures define those binaries for a specific architectures. It is not the only instruction set but the only prevailed full open source instruction set. The binaries genereted according to those instruction sets can opperate on any RISC-V processor. It is also possible to extend the architecture by your own designs. Those extensions may not opperate on every hardware depening on the compiler configurations. This repository represent a processor that have minumum requirements of a RISC-V arcitechture. The purpose of this design is to share a simple to understand example of the most basic processor design.

=========================================================================

![core_rlt][core_rlt]


## What code contains

=========================================================================

This repository is a RISC-V coore project implemented with hardware description language **verilog** which means that if you have an fpga board available you can compile my code with the rigth software for your specific chip. Although I would recomand you to test my code with open source verifaction tests such as [COCOTB][cocotb] if you are going to use in real life applications. Doing the complete verification is one of my plans for the future as well as extending the RISC-V instruction set also adding branch prediction, pipline and cache memory.

## About This Repository

=========================================================================

## This repository offers:

+ +Easy to understand RISCV processor

+ +Intuative verification method with assembly code 
(as it turns out it is impracticle method for real life applications and verification is not a simple for even basic cores)

This module does not contain:

- -No cache memory

- -No pipline structure

- -No branch prediction

- -Not fully verified

[cocotb]: https://www.cocotb.org/  "cocotb"
[core_rlt]: https://github.com/EnesErcin/Single_Cycle_RISCV_Core/tree/main/Report/core_rtl.png  "core_rtl"