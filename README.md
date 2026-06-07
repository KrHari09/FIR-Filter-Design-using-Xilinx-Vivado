# FIR Filter Design & Implementation on FPGA

<div align="center">

![FPGA](https://img.shields.io/badge/Platform-FPGA%20%7C%20Xilinx%20Artix--7-blue?style=for-the-badge)
![Language](https://img.shields.io/badge/Language-Verilog%20HDL-orange?style=for-the-badge)
![Tool](https://img.shields.io/badge/Tool-Xilinx%20Vivado-red?style=for-the-badge)
![MATLAB](https://img.shields.io/badge/Tool-MATLAB%202018b-yellow?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)

</div>

---

An **8th-order Finite Impulse Response (FIR) Low-Pass Filter** designed and implemented in **Verilog HDL**, synthesized on a **Xilinx Artix-7 FPGA** using Xilinx Vivado. Filter coefficients were computed in MATLAB using the **Hamming window method** and the design was verified through RTL simulation — confirming correct noise attenuation on a 16-bit fixed-point signal.

The complete flow — MATLAB coefficient design → Verilog RTL → FPGA synthesis — was built and validated end-to-end with zero critical timing violations.

---

## Filter Specifications

| Parameter | Value |
|---|---|
| Filter Type | Low-Pass FIR |
| Filter Order | 8 |
| Design Method | Hamming Window |
| Cut-off Frequency | 5 KHz |
| Pass-band Frequency | 1.5 KHz |
| Sampling Frequency | 8 KHz |
| Data Width | 16-bit signed fixed-point |
| Coefficient Scaling | 128 (2⁷) |

---

## Architecture

The filter uses the **Direct Form structure** — input passes through a chain of D Flip-Flop delay elements (z⁻¹), each delayed sample is multiplied by its corresponding Hamming window coefficient, and all products are summed to produce the output.

```
x[n] ──► [z⁻¹] ──► [z⁻¹] ──► [z⁻¹] ──► ... ──► [z⁻¹]
           │           │           │                  │
          ×b₁         ×b₂         ×b₃               ×b₈
           │           │           │                  │
           └───────────┴───────────┴──── Σ ───────────┘──► y[n]
```

**y[n] = b₀·x[n] + b₁·x[n-1] + b₂·x[n-2] + ... + b₈·x[n-8]**

Coefficients (scaled by 128): `[0, 1, 7, 15, 19, 15, 7, 1, 0]`

---

## Repository Structure

```
FIR-Filter-Design-using-Xilinx-Vivado/
│
├── src/
│   ├── fir_filter.v        # Main FIR filter RTL module
│   └── dff.v               # D Flip-Flop module (z⁻¹ delay element)
│
├── sim/
│   ├── tb_fir_filter.v     # Testbench — reads signal.data, drives DUT
│   └── signal.data         # 32-sample binary input signal (from MATLAB)
│
├── matlab/
│   └── signal_gen.m        # MATLAB: sine + noise generation → signal.data
│
└── README.md
```

---

## Key Results

- ✅ RTL simulation confirmed correct noise attenuation — filtered output closely matches the clean sine wave
- ✅ Design synthesized on Xilinx Artix-7 with **zero critical timing violations**
- ✅ Resource utilisation: **LUT ~1%, FF ~1%, IO ~9%** — highly area-efficient

### Device Utilisation Summary (Post-Synthesis)

| Resource | Utilisation |
|---|---|
| LUT | ~1% |
| Flip-Flops | ~1% |
| IO | ~9% |
| BUFG | ~3% |

---

## Tools Used

| Tool | Purpose |
|---|---|
| **Verilog HDL** | RTL design of FIR filter and DFF modules |
| **Xilinx Vivado** | Synthesis, simulation, device utilisation |
| **MATLAB 2018b** | Coefficient design (FDATool), test signal generation |
| **Xilinx Artix-7** | Target FPGA (xc7k70tfbv676-1) |

---

## How to Run

### Prerequisites
- Xilinx Vivado 2018 or later
- MATLAB 2018b or later

### Step 1 — Generate Input Signal (MATLAB)
```matlab
% Run in MATLAB — generates signal.data in current directory
run('matlab/signal_gen.m')
```
Copy the generated `signal.data` into the `sim/` folder.

### Step 2 — Set Up Vivado Project
1. Create a new RTL project in Vivado
2. Add `src/fir_filter.v` and `src/dff.v` as **design sources**
3. Add `sim/tb_fir_filter.v` as **simulation source**
4. Copy `sim/signal.data` into the Vivado simulation working directory

### Step 3 — Run Simulation
- Set `tb_fir_filter` as the top simulation module
- Run **Behavioral Simulation**
- Observe `data_in` (noisy) vs `data_out` (filtered) in the waveform viewer

### Step 4 — Synthesize
- Target: `xc7k70tfbv676-1`
- Run **Synthesis** → check utilisation summary

---

## References

1. Jagadale et al., *"Implementation of FIR Filter using VHDL"*, IJERT ICONET 2014
2. Xiaoyan Jiang and Yujun Bao, *"FIR filter design based on FPGA"*, ICCASM 2010, doi: [10.1109/ICCASM.2010.5622482](https://doi.org/10.1109/ICCASM.2010.5622482)
3. M. B. Trimale and Chilveri, *"A review: FIR filter implementation"*, IEEE RTEICT 2017, doi: [10.1109/RTEICT.2017.8256573](https://doi.org/10.1109/RTEICT.2017.8256573)

---

## Author

**Hari Kumar** (2022UGEC018)
B.Tech (Hons.) — Electronics & Communication Engineering
National Institute of Technology Jamshedpur

**Supervisor:** Dr. Basanta Bhowmik, Assistant Professor, Dept. of ECE, NIT Jamshedpur

---

<div align="center">
<i>If you found this helpful, consider giving it a ⭐</i>
</div>
