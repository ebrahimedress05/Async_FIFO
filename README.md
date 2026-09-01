# Async_FIFO — Asynchronous FIFO

> 🚧 **Work in progress** — this repository is being built incrementally. See the checklist below for current status.

A dual-clock asynchronous FIFO (2-port memory) implemented in Verilog, using Gray-code pointer synchronization to safely cross write/read pointers between the two clock domains.

## About the Design

An asynchronous FIFO connects two clock domains: a **write side** (`W_CLK`) and a **read side** (`R_CLK`). Each side keeps its own pointer into a shared dual-port memory. To compare pointers safely across domains without metastability risk, both pointers are encoded in **Gray code** (only one bit changes per increment) before being synchronized into the other domain through a double-flop synchronizer.

Planned top-level ports (`ASYNC_FIFO`):

| Signal     | Direction | Width           | Description                     |
|------------|-----------|-----------------|-----------------------------------|
| `W_CLK`    | input     | 1               | Write (source) domain clock       |
| `W_RST`    | input     | 1               | Write domain async reset          |
| `W_INC`    | input     | 1               | Write enable                      |
| `R_CLK`    | input     | 1               | Read (destination) domain clock   |
| `R_RST`    | input     | 1               | Read domain async reset           |
| `R_INC`    | input     | 1               | Read enable                       |
| `WR_DATA`  | input     | `DATA_WIDTH`    | Write data bus                    |
| `RD_DATA`  | output    | `DATA_WIDTH`    | Read data bus                     |
| `FULL`     | output    | 1               | FIFO full flag                    |
| `EMPTY`    | output    | 1               | FIFO empty flag                   |

Parameter: `DATA_WIDTH` (default 8).

## Sub-modules (planned)

- [x] **FIFO_wptr** – generates the write address, the Gray-coded write pointer, and the `FULL` flag by comparing against the synchronized read pointer
- [ ] **FIFO_rptr** – generates the read address, the Gray-coded read pointer, and the `EMPTY` flag by comparing against the synchronized write pointer
- [ ] **DF_SYNC** – double-flop synchronizer used to safely pass each Gray-coded pointer into the other clock domain
- [ ] **FIFO_MEM_CNTRL** – the dual-port memory array itself (write on `W_CLK`, read on `R_CLK`)
- [ ] **ASYNC_FIFO** – top-level module wiring the above together
- [ ] Testbench (100 MHz write / 40 MHz read, 9 data bytes, sized to avoid overflow)

## Repository Structure

```
rtl/            → design source files
tb/             → testbench (pending)
```

## Tools Used

- Simulation: ModelSim/QuestaSim (pending)
