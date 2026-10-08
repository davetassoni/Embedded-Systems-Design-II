# Embedded-Systems-Design-II

Coursework from **RIT CPET-563, Embedded Systems Design II** (Spring 2021), the capstone course of the Computer Engineering Technology program. The course is project based: four individual labs on image processing for embedded vision, then a team project taken from product idea through design reviews to a working prototype. Class projects from this course are showcased by RIT's Ravven Lab: [ravvenlabs.com](https://www.ravvenlabs.com/).

**Hardware:** Snickerdoodle (Xilinx Zynq-7000) development kit, plus the Fusion 2 platform for Lab 4
**Tools:** Vivado, MATLAB/Simulink (HDL Coder, 2019b), ModelSim, Python (OpenCV, PyQt), Unity

## Labs (individual work)

Each lab folder holds `src/` (code) and `doc/` (the tech memo I wrote for it).

| Lab | What I built |
|-----|--------------|
| [1](Lab/1) | Tennis ball tracker in Python, PyQt and OpenCV: load an image, pick blue or green, load detection parameters from a file, and show the ball's centroid |
| [2](Lab/2) | Extended a VHDL image-processing testbench to threshold TIF images on min/max red, green and blue values, simulated in ModelSim |
| [3](Lab/3) | Modified a Simulink 3x3 convolution (Sobel) model into an RGB / YCbCr colour filter with limits read from a setup file and a switch between the two modes |
| [4](Lab/4) | Took that Simulink RGB/YCbCr filter onto the Fusion 2 hardware, with a GUI to visualise the filtering (`fusion2_vivado/` holds the Vivado IP and the Python servers that run on the board) |

## Vivado projects

[Vivado_Projects](Vivado_Projects) has the introductory Zynq work: a custom `blink` IP block on the Zynq processing system, and an AXI version (`blinkAXI`) accessed from Linux on the board with a small memory-access program and Python script. Only the sources, block designs and constraints are tracked; Vivado's generated output is not.

## Final project: Tharros, an AprilTag table tennis tracker (team project)

A team project with **Brian ([@brianzarzuela](https://github.com/brianzarzuela))**. The system tracks a ball in 3D from a Snickerdoodle stereo camera pair and uses an AprilTag for the camera's pose. The required features were camera calibration, system accuracy analysis, coefficient of restitution, LED visualisation, the AprilTag tracker and camera motion errors.

- **The shared team code** lives in Brian's own repository and isn't included here; this repo has my parts of the project
- [Final_Project/Docs](Final_Project/Docs) has the PDR and CDR presentations and my individual final tech memo (the tech memos are individual work, not team work)
- [Final_Project/Code/dave-pose-detect-local](Final_Project/Code/dave-pose-detect-local) is my part of the code: MATLAB stereo camera calibration (`stereoParams.mat`, `poseDetect.m`) from twenty sets of calibration images
- [Final_Project/Code/Unity](Final_Project/Code/Unity) and the loose Python scripts next to it were used to visualise the ball's position

## Layout

```
Lab/                  labs 1-4: src/ and doc/
Vivado_Projects/      introductory Zynq projects
Final_Project/
  Docs/               design reviews, tech memo, time tracking
  Code/               my pose-detection work, Unity visualisation, helper scripts
```

Course lectures, recordings and instructor-supplied assignment sheets are kept out of this repo, as is generated tool output (see `.gitignore`).
