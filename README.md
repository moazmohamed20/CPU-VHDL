# CPU Design

## Description

The example is a small, 16-bit microprocessor.

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/moazmohamed20/CPU-VHDL/assets/48488390/35adec20-cc8b-401c-a21a-c94c987950b8">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/moazmohamed20/CPU-VHDL/assets/48488390/f603bc39-0981-497d-a752-2975a6cf4924">
  <img alt="CPU-Diagram" src="https://github.com/moazmohamed20/CPU-VHDL/assets/48488390/35adec20-cc8b-401c-a21a-c94c987950b8" title="CPU-Diagram">
</picture>

The processor contains a number of basic pieces. There is a register
array of eight 16-bit registers, an ALU (Arithmetic Logic Unit), a shifter,
a program counter, an instruction register, a comparator, an address register, and a control unit. All of these units communicate through a common, 16-bit tristate data bus.

## References

![VHDL Programming by Example - Douglas L. Perry](https://github.com/moazmohamed20/CPU-VHDL/assets/48488390/1786dc7b-a482-4f44-a3fd-9339f7fe5be9 "VHDL Programming by Example - Douglas L. Perry")

- [VHDL Programming by Example - PDF Book](https://github.com/moazmohamed20/CPU-VHDL/files/14318779/VHDL.Programming.by.Example.pdf)
