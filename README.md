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

<img width="1366" height="840" alt="image" src="https://github.com/user-attachments/assets/b3782d05-1113-4544-9083-74cf049cc5c7" />


**y[n] = b₀·x[n] + b₁·x[n-1] + b₂·x[n-2] + ... + b₈·x[n-8]**

Coefficients (scaled by 128): `[0, 1, 7, 15, 19, 15, 7, 1, 0]`

---

## Repository Structure

<img width="1366" height="830" alt="image" src="https://github.com/user-attachments/assets/9f5d6586-8852-41a1-96a0-0abbe4520bc2" />

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

## MATLAB generated signal

<img width="785" height="415" alt="Sine wave generated in MATLAB after addition of noise" src="https://github.com/user-attachments/assets/89af9f80-51b1-4070-aba4-59880a267280" />

---

## Circuit Daigram

<img width="785" height="431" alt="Circuit diagram to implement FIR Filter" src="https://github.com/user-attachments/assets/2732dafc-377d-480f-8d32-2ac76f94f8e1" />


---

### Device Utilisation Summary (Post-Synthesis)

<img width="785" height="323" alt="Device_utilization summary" src="https://github.com/user-attachments/assets/1a9f4f0e-3887-49e8-8f73-0c549fd685a8" />

| Resource | Utilisation |
|---|---|
| LUT | ~1% |
| Flip-Flops | ~1% |
| IO | ~9% |
| BUFG | ~3% |

---

## Key Results

<img width="785" height="282" alt="Result" src="https://github.com/user-attachments/assets/6606c543-ce84-45bb-831c-89e9525b393d" />

-  RTL simulation confirmed correct noise attenuation — filtered output closely matches the clean sine wave
-  Design synthesized on Xilinx Artix-7 with **zero critical timing violations**
-  Resource utilisation: **LUT ~1%, FF ~1%, IO ~9%** — highly area-efficient



## References

1. Jagadale et al., *"Implementation of FIR Filter using VHDL"*, IJERT ICONET 2014
2. Xiaoyan Jiang and Yujun Bao, *"FIR filter design based on FPGA"*, ICCASM 2010, doi: [10.1109/ICCASM.2010.5622482](https://doi.org/10.1109/ICCASM.2010.5622482)
3. M. B. Trimale and Chilveri, *"A review: FIR filter implementation"*, IEEE RTEICT 2017, doi: [10.1109/RTEICT.2017.8256573](https://doi.org/10.1109/RTEICT.2017.8256573)

---

## Author

**Hari Kumar** (2022UGEC018)
B.Tech (Hons.) — Electronics & Communication Engineering,
National Institute of Technology Jamshedpur; 
harikumaroct2001@gmail.com

**Supervisor:** Dr. Basanta Bhowmik, Assistant Professor, Dept. of ECE, NIT Jamshedpur

---

<div align="center">
<i>If you found this helpful, consider giving it a ⭐</i>
</div>
