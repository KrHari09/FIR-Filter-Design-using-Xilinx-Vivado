 # FIR Filter Design & Implementation
### Digital Signal Processing on FPGA using Verilog HDL & Xilinx Vivado

<div align="center">

![FPGA](https://img.shields.io/badge/Platform-FPGA%20%7C%20Xilinx%20Artix--7-blue?style=for-the-badge&logo=xilinx)
![Verilog](https://img.shields.io/badge/Language-Verilog%20HDL-orange?style=for-the-badge)
![MATLAB](https://img.shields.io/badge/Tool-MATLAB%202018b-red?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Institute](https://img.shields.io/badge/Institute-NIT%20Jamshedpur-purple?style=for-the-badge)

</div>

---

##  Overview

This project presents the **design and hardware implementation of an 8th-order Finite Impulse Response (FIR) Low-Pass Filter** using **Verilog HDL** synthesized on a **Xilinx Artix-7 FPGA** via Xilinx Vivado. Filter coefficients were derived using MATLAB's FDATool with the **Hamming window method**, and the design was validated through RTL simulation against MATLAB-generated reference outputs.

The complete pipeline — from mathematical filter design in MATLAB to synthesized hardware on an FPGA — was built and verified end-to-end, with simulation results confirming correct noise attenuation behaviour.

---

##  Key Highlights

-  **End-to-end DSP pipeline**: MATLAB coefficient design → Verilog RTL → FPGA synthesis
-  **16-bit fixed-point** data representation for hardware-efficient arithmetic
-  **Direct form FIR structure** implemented using D Flip-Flop shift registers for time delay
-  **Hamming window** used for filter coefficient computation (minimised side-lobe ripple)
-  **RTL simulation** verified against MATLAB output — confirmed signal noise attenuation
-  Synthesis completed with **zero critical timing violations** on Xilinx Artix-7 (xc7k70tfbv676-1)
-  Resource utilisation: **LUT ~1%, FF ~1%, IO ~9%** — highly efficient design

---

##  Tech Stack

| Tool / Technology | Purpose |
|---|---|
| **Verilog HDL** | RTL design of FIR filter and D Flip-Flop modules |
| **Xilinx Vivado** | Synthesis, elaboration, simulation and device utilisation |
| **MATLAB 2018b** | Filter coefficient design (FDATool), test signal generation |
| **Xilinx Artix-7** | Target FPGA device (xc7k70tfbv676-1) |

---

##  Filter Specifications

| Parameter | Value |
|---|---|
| Filter Type | Low-Pass FIR |
| Filter Order | 8 |
| Design Method | Hamming Window |
| Cut-off Frequency | 5 KHz |
| Pass-band Frequency | 1.5 KHz |
| Sampling Frequency | 8 KHz |
| Data Width | 16-bit fixed-point (signed) |
| Scaling Factor | 128 (2⁷) |

---

##  System Architecture

The FIR filter is implemented using the **Direct Form structure** — the simplest and most straightforward realisation of an FIR filter:

<img width="549" height="289" alt="ch007-f001" src="https://github.com/user-attachments/assets/ba8f7e74-e51c-4e25-aaa5-f30e352c8ca5" />


**Building blocks used:**
- `D Flip-Flop (DFF)` modules — create unit time delays (z⁻¹ blocks)
- Fixed-point multipliers — scale input samples by filter coefficients
- Fixed-point adders — accumulate the weighted products

**Mathematical operation:**

<img width="274" height="58" alt="Picture2" src="https://github.com/user-attachments/assets/1e194129-6f2b-4ba8-853c-a39623884ebf" />
