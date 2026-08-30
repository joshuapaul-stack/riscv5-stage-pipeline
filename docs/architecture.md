# RV32I 5-Stage Pipeline Architecture

## Pipeline

IF -> ID -> EX -> MEM -> WB

## IF - Instruction Fetch

- Program counter
- Instruction fetch
- PC + 4

## ID - Instruction Decode

- Instruction decoder
- Register file read
- Immediate generation
- Control generation

## EX - Execute

- ALU
- Branch comparison
- Branch target calculation
- Forwarding selection

## MEM - Memory

- Load
- Store
- Memory address handling

## WB - Write Back

- ALU result writeback
- Load data writeback

## Pipeline Registers

### IF/ID

- PC
- PC + 4
- Instruction

### ID/EX

- PC
- Register operands
- Immediate
- rs1
- rs2
- rd
- Control signals

### EX/MEM

- ALU result
- Store data
- rd
- Branch information
- Control signals

### MEM/WB

- Memory data
- ALU result
- rd
- Control signals

## Hazard Handling

### Data Hazards

- EX/MEM forwarding
- MEM/WB forwarding

### Load-Use Hazard

- Stall pipeline for one cycle

### Control Hazards

- Branch resolution in EX
- Flush younger instructions on taken branch

## Initial RV32I Scope

- ADD
- SUB
- AND
- OR
- XOR
- SLT
- ADDI
- LW
- SW
- BEQ
- BNE
- JAL