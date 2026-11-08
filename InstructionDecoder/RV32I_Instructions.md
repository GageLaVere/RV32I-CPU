# RV32I Instruction Encoding Map

## Index

| Opcode [6:0] | Family | Format | Instructions in this map |
|---|---|---|---:|
| [`0000011`](#opcode-0000011) | LOAD | I | 5 |
| [`0001111`](#opcode-0001111) | MISC-MEM | I (fence) | 3 |
| [`0010011`](#opcode-0010011) | OP-IMM | I | 9 |
| [`0010111`](#opcode-0010111) | AUIPC | U | 1 |
| [`0100011`](#opcode-0100011) | STORE | S | 3 |
| [`0110011`](#opcode-0110011) | OP | R | 10 |
| [`0110111`](#opcode-0110111) | LUI | U | 1 |
| [`1100011`](#opcode-1100011) | BRANCH | B | 6 |
| [`1100111`](#opcode-1100111) | JALR | I | 1 |
| [`1101111`](#opcode-1101111) | JAL | J | 1 |
| [`1110011`](#opcode-1110011) | SYSTEM | I (system) | 2 |

## Complete 32-bit field map

### Opcode 0000011 — LOAD

| Instruction | Format | `funct7` key | `funct3` key | **31–25** (7) | **24–20** (5) | **19–15** (5) | **14–12** (3) | **11–7** (5) | **6–0** (7) |
|---|---|---|---|---|---|---|---|---|---|
| **LB** | I | — | `000` | `imm[11:5]` | `imm[4:0]` | `rs1[4:0]` | `000` | `rd[4:0]` | `0000011` |
| **LH** | I | — | `001` | `imm[11:5]` | `imm[4:0]` | `rs1[4:0]` | `001` | `rd[4:0]` | `0000011` |
| **LW** | I | — | `010` | `imm[11:5]` | `imm[4:0]` | `rs1[4:0]` | `010` | `rd[4:0]` | `0000011` |
| **LBU** | I | — | `100` | `imm[11:5]` | `imm[4:0]` | `rs1[4:0]` | `100` | `rd[4:0]` | `0000011` |
| **LHU** | I | — | `101` | `imm[11:5]` | `imm[4:0]` | `rs1[4:0]` | `101` | `rd[4:0]` | `0000011` |

### Opcode 0001111 — MISC-MEM

`FENCE.TSO` and `PAUSE` are separately displayed named encodings of the `FENCE` space. See notes below.

| Instruction | Format | `funct7` key | `funct3` key | **31–25** (7) | **24–20** (5) | **19–15** (5) | **14–12** (3) | **11–7** (5) | **6–0** (7) |
|---|---|---|---|---|---|---|---|---|---|
| PAUSE † | I (fence) | — | `000` | `0000000` | `10000` | `00000` | `000` | `00000` | `0001111` |
| FENCE.TSO † | I (fence) | — | `000` | `1000001` | `10011` | `00000` | `000` | `00000` | `0001111` |
| **FENCE** | I (fence) | — | `000` | `fm[3:0]` + `pred[3:1]` | `pred[0]` + `succ[3:0]` | `00000` | `000` | `00000` | `0001111` |

### Opcode 0010011 — OP-IMM

| Instruction | Format | `funct7` key | `funct3` key | **31–25** (7) | **24–20** (5) | **19–15** (5) | **14–12** (3) | **11–7** (5) | **6–0** (7) |
|---|---|---|---|---|---|---|---|---|---|
| **SLLI** | I | `0000000`* | `001` | `0000000` | `shamt[4:0]` | `rs1[4:0]` | `001` | `rd[4:0]` | `0010011` |
| **SRLI** | I | `0000000`* | `101` | `0000000` | `shamt[4:0]` | `rs1[4:0]` | `101` | `rd[4:0]` | `0010011` |
| **SRAI** | I | `0100000`* | `101` | `0100000` | `shamt[4:0]` | `rs1[4:0]` | `101` | `rd[4:0]` | `0010011` |
| **ADDI** | I | — | `000` | `imm[11:5]` | `imm[4:0]` | `rs1[4:0]` | `000` | `rd[4:0]` | `0010011` |
| **SLTI** | I | — | `010` | `imm[11:5]` | `imm[4:0]` | `rs1[4:0]` | `010` | `rd[4:0]` | `0010011` |
| **SLTIU** | I | — | `011` | `imm[11:5]` | `imm[4:0]` | `rs1[4:0]` | `011` | `rd[4:0]` | `0010011` |
| **XORI** | I | — | `100` | `imm[11:5]` | `imm[4:0]` | `rs1[4:0]` | `100` | `rd[4:0]` | `0010011` |
| **ORI** | I | — | `110` | `imm[11:5]` | `imm[4:0]` | `rs1[4:0]` | `110` | `rd[4:0]` | `0010011` |
| **ANDI** | I | — | `111` | `imm[11:5]` | `imm[4:0]` | `rs1[4:0]` | `111` | `rd[4:0]` | `0010011` |

### Opcode 0010111 — AUIPC

| Instruction | Format | `funct7` key | `funct3` key | **31–25** (7) | **24–20** (5) | **19–15** (5) | **14–12** (3) | **11–7** (5) | **6–0** (7) |
|---|---|---|---|---|---|---|---|---|---|
| **AUIPC** | U | — | — | `imm[31:25]` | `imm[24:20]` | `imm[19:15]` | `imm[14:12]` | `rd[4:0]` | `0010111` |

### Opcode 0100011 — STORE

| Instruction | Format | `funct7` key | `funct3` key | **31–25** (7) | **24–20** (5) | **19–15** (5) | **14–12** (3) | **11–7** (5) | **6–0** (7) |
|---|---|---|---|---|---|---|---|---|---|
| **SB** | S | — | `000` | `imm[11:5]` | `rs2[4:0]` | `rs1[4:0]` | `000` | `imm[4:0]` | `0100011` |
| **SH** | S | — | `001` | `imm[11:5]` | `rs2[4:0]` | `rs1[4:0]` | `001` | `imm[4:0]` | `0100011` |
| **SW** | S | — | `010` | `imm[11:5]` | `rs2[4:0]` | `rs1[4:0]` | `010` | `imm[4:0]` | `0100011` |

### Opcode 0110011 — OP

| Instruction | Format | `funct7` key | `funct3` key | **31–25** (7) | **24–20** (5) | **19–15** (5) | **14–12** (3) | **11–7** (5) | **6–0** (7) |
|---|---|---|---|---|---|---|---|---|---|
| **ADD** | R | `0000000` | `000` | `0000000` | `rs2[4:0]` | `rs1[4:0]` | `000` | `rd[4:0]` | `0110011` |
| **SLL** | R | `0000000` | `001` | `0000000` | `rs2[4:0]` | `rs1[4:0]` | `001` | `rd[4:0]` | `0110011` |
| **SLT** | R | `0000000` | `010` | `0000000` | `rs2[4:0]` | `rs1[4:0]` | `010` | `rd[4:0]` | `0110011` |
| **SLTU** | R | `0000000` | `011` | `0000000` | `rs2[4:0]` | `rs1[4:0]` | `011` | `rd[4:0]` | `0110011` |
| **XOR** | R | `0000000` | `100` | `0000000` | `rs2[4:0]` | `rs1[4:0]` | `100` | `rd[4:0]` | `0110011` |
| **SRL** | R | `0000000` | `101` | `0000000` | `rs2[4:0]` | `rs1[4:0]` | `101` | `rd[4:0]` | `0110011` |
| **OR** | R | `0000000` | `110` | `0000000` | `rs2[4:0]` | `rs1[4:0]` | `110` | `rd[4:0]` | `0110011` |
| **AND** | R | `0000000` | `111` | `0000000` | `rs2[4:0]` | `rs1[4:0]` | `111` | `rd[4:0]` | `0110011` |
| **SUB** | R | `0100000` | `000` | `0100000` | `rs2[4:0]` | `rs1[4:0]` | `000` | `rd[4:0]` | `0110011` |
| **SRA** | R | `0100000` | `101` | `0100000` | `rs2[4:0]` | `rs1[4:0]` | `101` | `rd[4:0]` | `0110011` |

### Opcode 0110111 — LUI

| Instruction | Format | `funct7` key | `funct3` key | **31–25** (7) | **24–20** (5) | **19–15** (5) | **14–12** (3) | **11–7** (5) | **6–0** (7) |
|---|---|---|---|---|---|---|---|---|---|
| **LUI** | U | — | — | `imm[31:25]` | `imm[24:20]` | `imm[19:15]` | `imm[14:12]` | `rd[4:0]` | `0110111` |

### Opcode 1100011 — BRANCH

| Instruction | Format | `funct7` key | `funct3` key | **31–25** (7) | **24–20** (5) | **19–15** (5) | **14–12** (3) | **11–7** (5) | **6–0** (7) |
|---|---|---|---|---|---|---|---|---|---|
| **BEQ** | B | — | `000` | `imm[12]` + `imm[10:5]` | `rs2[4:0]` | `rs1[4:0]` | `000` | `imm[4:1]` + `imm[11]` | `1100011` |
| **BNE** | B | — | `001` | `imm[12]` + `imm[10:5]` | `rs2[4:0]` | `rs1[4:0]` | `001` | `imm[4:1]` + `imm[11]` | `1100011` |
| **BLT** | B | — | `100` | `imm[12]` + `imm[10:5]` | `rs2[4:0]` | `rs1[4:0]` | `100` | `imm[4:1]` + `imm[11]` | `1100011` |
| **BGE** | B | — | `101` | `imm[12]` + `imm[10:5]` | `rs2[4:0]` | `rs1[4:0]` | `101` | `imm[4:1]` + `imm[11]` | `1100011` |
| **BLTU** | B | — | `110` | `imm[12]` + `imm[10:5]` | `rs2[4:0]` | `rs1[4:0]` | `110` | `imm[4:1]` + `imm[11]` | `1100011` |
| **BGEU** | B | — | `111` | `imm[12]` + `imm[10:5]` | `rs2[4:0]` | `rs1[4:0]` | `111` | `imm[4:1]` + `imm[11]` | `1100011` |

### Opcode 1100111 — JALR

| Instruction | Format | `funct7` key | `funct3` key | **31–25** (7) | **24–20** (5) | **19–15** (5) | **14–12** (3) | **11–7** (5) | **6–0** (7) |
|---|---|---|---|---|---|---|---|---|---|
| **JALR** | I | — | `000` | `imm[11:5]` | `imm[4:0]` | `rs1[4:0]` | `000` | `rd[4:0]` | `1100111` |

### Opcode 1101111 — JAL

| Instruction | Format | `funct7` key | `funct3` key | **31–25** (7) | **24–20** (5) | **19–15** (5) | **14–12** (3) | **11–7** (5) | **6–0** (7) |
|---|---|---|---|---|---|---|---|---|---|
| **JAL** | J | — | — | `imm[20]` + `imm[10:5]` | `imm[4:1]` + `imm[11]` | `imm[19:15]` | `imm[14:12]` | `rd[4:0]` | `1101111` |

### Opcode 1110011 — SYSTEM

| Instruction | Format | `funct7` key | `funct3` key | **31–25** (7) | **24–20** (5) | **19–15** (5) | **14–12** (3) | **11–7** (5) | **6–0** (7) |
|---|---|---|---|---|---|---|---|---|---|
| **ECALL** | I (system) | — | `000` | `0000000` | `00000` | `00000` | `000` | `00000` | `1110011` |
| **EBREAK** | I (system) | — | `000` | `0000000` | `00001` | `00000` | `000` | `00000` | `1110011` |


## Instruction definitions


### 0000011 — LOAD

| Instruction | Full name | Definition |
|---|---|---|
| **LB** | Load Byte | Read 8 bits from memory at the base address plus the immediate offset; sign-extend to 32 bits. |
| **LH** | Load Halfword | Read 16 bits from memory at the base address plus the immediate offset; sign-extend to 32 bits. |
| **LW** | Load Word | Read 32 bits from memory at the base address plus the immediate offset. |
| **LBU** | Load Byte Unsigned | Read 8 bits from memory at the base address plus the immediate offset; zero-extend to 32 bits. |
| **LHU** | Load Halfword Unsigned | Read 16 bits from memory at the base address plus the immediate offset; zero-extend to 32 bits. |

### 0001111 — MISC-MEM

| Instruction | Full name | Definition |
|---|---|---|
| **PAUSE** | Pause Hint | Hint that the CPU is in a waiting loop; does not change program-visible state. |
| **FENCE.TSO** | Fence — Total Store Ordering | Enforce the specified ordering of memory reads and writes under total store ordering. |
| **FENCE** | Memory Fence | Order memory reads and writes according to the instruction’s predecessor and successor flags. |

### 0010011 — OP-IMM

| Instruction | Full name | Definition |
|---|---|---|
| **SLLI** | Shift Left Logical Immediate | Shift the source register left by the amount in instruction bits 24–20; fill with zeros. |
| **SRLI** | Shift Right Logical Immediate | Shift the source register right by the amount in instruction bits 24–20; fill with zeros. |
| **SRAI** | Shift Right Arithmetic Immediate | Shift the source register right by the amount in instruction bits 24–20; copy the sign bit into vacated positions. |
| **ADDI** | Add Immediate | Add the sign-extended immediate to the source register; save the result. |
| **SLTI** | Set Less Than Immediate | Write 1 if the source register is less than the sign-extended immediate (signed comparison); otherwise 0. |
| **SLTIU** | Set Less Than Immediate Unsigned | Write 1 if the source register is less than the sign-extended immediate when both are compared as unsigned; otherwise 0. |
| **XORI** | Exclusive OR Immediate | Bitwise exclusive OR of the source register and sign-extended immediate. |
| **ORI** | OR Immediate | Bitwise OR of the source register and sign-extended immediate. |
| **ANDI** | AND Immediate | Bitwise AND of the source register and sign-extended immediate. |

### 0010111 — AUIPC

| Instruction | Full name | Definition |
|---|---|---|
| **AUIPC** | Add Upper Immediate to Program Counter | Add the upper immediate (with 12 low zero bits) to the current instruction address; save the result. |

### 0100011 — STORE

| Instruction | Full name | Definition |
|---|---|---|
| **SB** | Store Byte | Write the low 8 bits of the data register to memory at the base address plus the immediate offset. |
| **SH** | Store Halfword | Write the low 16 bits of the data register to memory at the base address plus the immediate offset. |
| **SW** | Store Word | Write all 32 bits of the data register to memory at the base address plus the immediate offset. |

### 0110011 — OP

| Instruction | Full name | Definition |
|---|---|---|
| **ADD** | Add | Add two source-register values; save the result. |
| **SLL** | Shift Left Logical | Shift the first source-register value left by the low five bits of the second; fill with zeros. |
| **SLT** | Set Less Than | Write 1 if the first source-register value is less than the second as signed numbers; otherwise 0. |
| **SLTU** | Set Less Than Unsigned | Write 1 if the first source-register value is less than the second as unsigned numbers; otherwise 0. |
| **XOR** | Exclusive OR | Bitwise exclusive OR of two source-register values. |
| **SRL** | Shift Right Logical | Shift the first source-register value right by the low five bits of the second; fill with zeros. |
| **OR** | OR | Bitwise OR of two source-register values. |
| **AND** | AND | Bitwise AND of two source-register values. |
| **SUB** | Subtract | Subtract the second source-register value from the first; save the result. |
| **SRA** | Shift Right Arithmetic | Shift the first source-register value right by the low five bits of the second; copy the sign bit into vacated positions. |

### 0110111 — LUI

| Instruction | Full name | Definition |
|---|---|---|
| **LUI** | Load Upper Immediate | Put the 20-bit immediate in the upper 20 bits of the destination register; set the lower 12 bits to zero. |

### 1100011 — BRANCH

| Instruction | Full name | Definition |
|---|---|---|
| **BEQ** | Branch if Equal | Jump by the immediate offset if the two source-register values are equal. |
| **BNE** | Branch if Not Equal | Jump by the immediate offset if the two source-register values differ. |
| **BLT** | Branch if Less Than | Jump by the immediate offset if the first value is less than the second (signed). |
| **BGE** | Branch if Greater Than or Equal | Jump by the immediate offset if the first value is greater than or equal to the second (signed). |
| **BLTU** | Branch if Less Than Unsigned | Jump by the immediate offset if the first value is less than the second (unsigned). |
| **BGEU** | Branch if Greater Than or Equal Unsigned | Jump by the immediate offset if the first value is greater than or equal to the second (unsigned). |

### 1100111 — JALR

| Instruction | Full name | Definition |
|---|---|---|
| **JALR** | Jump and Link Register | Save the next instruction address, then jump to the source register plus immediate offset, clearing address bit 0. |

### 1101111 — JAL

| Instruction | Full name | Definition |
|---|---|---|
| **JAL** | Jump and Link | Save the next instruction address, then jump by the immediate offset relative to the current instruction address. |

### 1110011 — SYSTEM

| Instruction | Full name | Definition |
|---|---|---|
| **ECALL** | Environment Call | Request a service from the execution environment by raising an exception. |
| **EBREAK** | Environment Breakpoint | Raise a breakpoint exception, typically for debugging. |

`PAUSE` and `FENCE.TSO` are named encodings in the `FENCE` space, listed in addition to the 40 base instructions.

## Bit-by-bit view (all 32 positions)

This second view shows the **individual bit positions 31 down to 0** for every encoding, in the same opcode/upper-field/`funct3` order. Fixed `0`/`1` cells are literal encoding requirements.

| Instruction | `31` | `30` | `29` | `28` | `27` | `26` | `25` | `24` | `23` | `22` | `21` | `20` | `19` | `18` | `17` | `16` | `15` | `14` | `13` | `12` | `11` | `10` | `9` | `8` | `7` | `6` | `5` | `4` | `3` | `2` | `1` | `0` |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| LB | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `i4` | `i3` | `i2` | `i1` | `i0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `0` | `0` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `0` | `0` | `0` | `1` | `1` |
| LH | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `i4` | `i3` | `i2` | `i1` | `i0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `0` | `1` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `0` | `0` | `0` | `1` | `1` |
| LW | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `i4` | `i3` | `i2` | `i1` | `i0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `1` | `0` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `0` | `0` | `0` | `1` | `1` |
| LBU | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `i4` | `i3` | `i2` | `i1` | `i0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `0` | `0` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `0` | `0` | `0` | `1` | `1` |
| LHU | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `i4` | `i3` | `i2` | `i1` | `i0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `0` | `1` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `0` | `0` | `0` | `1` | `1` |
| PAUSE | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `1` | `1` | `1` | `1` |
| FENCE.TSO | `1` | `0` | `0` | `0` | `0` | `0` | `1` | `1` | `0` | `0` | `1` | `1` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `1` | `1` | `1` | `1` |
| FENCE | `f3` | `f2` | `f1` | `f0` | `p3` | `p2` | `p1` | `p0` | `q3` | `q2` | `q1` | `q0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `1` | `1` | `1` | `1` |
| SLLI | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `s4` | `s3` | `s2` | `s1` | `s0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `0` | `1` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `1` | `0` | `0` | `1` | `1` |
| SRLI | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `s4` | `s3` | `s2` | `s1` | `s0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `0` | `1` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `1` | `0` | `0` | `1` | `1` |
| SRAI | `0` | `1` | `0` | `0` | `0` | `0` | `0` | `s4` | `s3` | `s2` | `s1` | `s0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `0` | `1` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `1` | `0` | `0` | `1` | `1` |
| ADDI | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `i4` | `i3` | `i2` | `i1` | `i0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `0` | `0` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `1` | `0` | `0` | `1` | `1` |
| SLTI | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `i4` | `i3` | `i2` | `i1` | `i0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `1` | `0` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `1` | `0` | `0` | `1` | `1` |
| SLTIU | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `i4` | `i3` | `i2` | `i1` | `i0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `1` | `1` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `1` | `0` | `0` | `1` | `1` |
| XORI | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `i4` | `i3` | `i2` | `i1` | `i0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `0` | `0` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `1` | `0` | `0` | `1` | `1` |
| ORI | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `i4` | `i3` | `i2` | `i1` | `i0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `1` | `0` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `1` | `0` | `0` | `1` | `1` |
| ANDI | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `i4` | `i3` | `i2` | `i1` | `i0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `1` | `1` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `1` | `0` | `0` | `1` | `1` |
| AUIPC | `i31` | `i30` | `i29` | `i28` | `i27` | `i26` | `i25` | `i24` | `i23` | `i22` | `i21` | `i20` | `i19` | `i18` | `i17` | `i16` | `i15` | `i14` | `i13` | `i12` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `0` | `1` | `0` | `1` | `1` | `1` |
| SB | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `0` | `0` | `i4` | `i3` | `i2` | `i1` | `i0` | `0` | `1` | `0` | `0` | `0` | `1` | `1` |
| SH | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `0` | `1` | `i4` | `i3` | `i2` | `i1` | `i0` | `0` | `1` | `0` | `0` | `0` | `1` | `1` |
| SW | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `1` | `0` | `i4` | `i3` | `i2` | `i1` | `i0` | `0` | `1` | `0` | `0` | `0` | `1` | `1` |
| ADD | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `0` | `0` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `1` | `1` | `0` | `0` | `1` | `1` |
| SLL | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `0` | `1` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `1` | `1` | `0` | `0` | `1` | `1` |
| SLT | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `1` | `0` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `1` | `1` | `0` | `0` | `1` | `1` |
| SLTU | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `1` | `1` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `1` | `1` | `0` | `0` | `1` | `1` |
| XOR | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `0` | `0` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `1` | `1` | `0` | `0` | `1` | `1` |
| SRL | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `0` | `1` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `1` | `1` | `0` | `0` | `1` | `1` |
| OR | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `1` | `0` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `1` | `1` | `0` | `0` | `1` | `1` |
| AND | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `1` | `1` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `1` | `1` | `0` | `0` | `1` | `1` |
| SUB | `0` | `1` | `0` | `0` | `0` | `0` | `0` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `0` | `0` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `1` | `1` | `0` | `0` | `1` | `1` |
| SRA | `0` | `1` | `0` | `0` | `0` | `0` | `0` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `0` | `1` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `1` | `1` | `0` | `0` | `1` | `1` |
| LUI | `i31` | `i30` | `i29` | `i28` | `i27` | `i26` | `i25` | `i24` | `i23` | `i22` | `i21` | `i20` | `i19` | `i18` | `i17` | `i16` | `i15` | `i14` | `i13` | `i12` | `d4` | `d3` | `d2` | `d1` | `d0` | `0` | `1` | `1` | `0` | `1` | `1` | `1` |
| BEQ | `i12` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `0` | `0` | `i4` | `i3` | `i2` | `i1` | `i11` | `1` | `1` | `0` | `0` | `0` | `1` | `1` |
| BNE | `i12` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `0` | `1` | `i4` | `i3` | `i2` | `i1` | `i11` | `1` | `1` | `0` | `0` | `0` | `1` | `1` |
| BLT | `i12` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `0` | `0` | `i4` | `i3` | `i2` | `i1` | `i11` | `1` | `1` | `0` | `0` | `0` | `1` | `1` |
| BGE | `i12` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `0` | `1` | `i4` | `i3` | `i2` | `i1` | `i11` | `1` | `1` | `0` | `0` | `0` | `1` | `1` |
| BLTU | `i12` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `1` | `0` | `i4` | `i3` | `i2` | `i1` | `i11` | `1` | `1` | `0` | `0` | `0` | `1` | `1` |
| BGEU | `i12` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `b4` | `b3` | `b2` | `b1` | `b0` | `a4` | `a3` | `a2` | `a1` | `a0` | `1` | `1` | `1` | `i4` | `i3` | `i2` | `i1` | `i11` | `1` | `1` | `0` | `0` | `0` | `1` | `1` |
| JALR | `i11` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `i4` | `i3` | `i2` | `i1` | `i0` | `a4` | `a3` | `a2` | `a1` | `a0` | `0` | `0` | `0` | `d4` | `d3` | `d2` | `d1` | `d0` | `1` | `1` | `0` | `0` | `1` | `1` | `1` |
| JAL | `i20` | `i10` | `i9` | `i8` | `i7` | `i6` | `i5` | `i4` | `i3` | `i2` | `i1` | `i11` | `i19` | `i18` | `i17` | `i16` | `i15` | `i14` | `i13` | `i12` | `d4` | `d3` | `d2` | `d1` | `d0` | `1` | `1` | `0` | `1` | `1` | `1` | `1` |
| ECALL | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `1` | `1` | `1` | `0` | `0` | `1` | `1` |
| EBREAK | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `0` | `1` | `1` | `1` | `0` | `0` | `1` | `1` |

### Legend

`iN` = immediate bit N; `aN` = rs1 bit N; `bN` = rs2 bit N; `dN` = rd bit N; `sN` = shift-amount bit N; `fN` = fence mode bit N; `pN` = fence predecessor bit N; `qN` = fence successor bit N. `0` and `1` are fixed binary values. Bits are ordered from **31 (left) to 0 (right)**. Example: `i11` in column 31 means instruction bit 31 carries immediate bit 11.

## References

- [RISC-V RV32I Base Integer Instruction Set, Version 2.1](https://docs.riscv.org/reference/isa/v20260120/unpriv/rv32.html)
- [RISC-V Instruction Set Listings — RV32I Base Instruction Set](https://docs.riscv.org/reference/isa/v20260120/unpriv/rv-32-64g.html)


