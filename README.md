# 2-bit ALU in Verilog

A simple 2-bit Arithmetic Logic Unit (ALU) implemented in Verilog.

## Module: `alu_2bit`

### Ports

| Port     | Direction | Width | Description              |
|----------|-----------|-------|--------------------------|
| `A`      | input     | 2     | First operand            |
| `B`      | input     | 2     | Second operand           |
| `opcode` | input     | 3     | Operation select         |
| `result` | output    | 3     | Operation result (3-bit to capture carry/borrow) |
| `zero`   | output    | 1     | High when result is zero |

### Supported Operations

| opcode | Operation | Description         |
|--------|-----------|---------------------|
| `000`  | AND       | A AND B             |
| `001`  | OR        | A OR B              |
| `010`  | ADD       | A + B; MSB of result = carry-out  |
| `011`  | SUB       | A - B; MSB of result = borrow     |
| `100`  | XOR       | A XOR B             |
| `101`  | NOT       | NOT A               |
| `110`  | NAND      | A NAND B            |
| `111`  | NOR       | A NOR B             |

## Files

- `alu_2bit.v` — ALU module
- `tb_alu_2bit.v` — Testbench

## Simulation

Using [Icarus Verilog](http://iverilog.icarus.com/):

```bash
iverilog -o alu_sim alu_2bit.v tb_alu_2bit.v
vvp alu_sim
```