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
