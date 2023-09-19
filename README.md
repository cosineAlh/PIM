# Process In-Memory (PIM) Simulation Framework
STT-MRAM based PIM array simulation framework.

## Description
The present framework provides the design and software tools to simulate the hybrid circuit programming of PIM based on STT-MRAM.

This architecture/methodology aims to construct a digital-analog hybrid simulation framework to automatically test the STT-MRAM and digital peripheral circuit. The STT-MRAM model is constructed using Verilog-A by solving LLG dynamically. The source code of STT-MRAM model is in `model/myspice/`.

Valid for 1T1M schemes, provide the configurable circuit design and post-simulation scripts to easily program MRAM cells into the desired value.

# Requirements
* Linux is recommended
* CMOS PDK:
    * NCSU Free PDK 45 nm. (https://eda.ncsu.edu/freepdk/freepdk45/)
* iverilog (https://github.com/steveicarus/iverilog)
* HSPICE
* Python 3.5+
* GNU Make
* Cadence (not neccessary, only for design stage)

# Simulation
## Start
Run `make` under folder `/bin`, it will automatically generate inputs, then use `make test` to check your results. It will show `"PASSED!"` if all the results are correct, otherwise is `"FAILED!"`

## Specifiy Parameters
You can specify the parameters like
```
make kernal = 3 channel = 10 IMG_H = 8 IMG_W = 8 system = 0
```

## Clean
It is recommended to run `make clean` before every simulation.

## Tips
- Can modify `/tools/testcases.py` to change the input image size.
- Can modify `/test/test.py` to get the output results and correct answer.
- Default is a $9\times 10$ array, 9 is the kernal size, 10 is the number of channels.
- testcases and the correct answers will be generated in `/tools`

# Directory
```
|-- README.md              # README file
|-- /bin                   # Folder of start files
    `-- Makefile
|-- /build                 # Folder of the generated file of iverilog
|-- /docs                  # Folder of documents
|-- /lib                   # Folder of technical libraries
|-- /model                 # Folder of CMOS/MRAM PDK models
    |-- /MTJ
    |-- /MTJ_P
    |-- /myspice
    |-- NMOS_VTL.inc
    `-- PMOS_VTL.inc
|-- /src                   # Folder of CMOS/MRAM models
    |-- /logs              # Folder of HSPICE logs
    |-- /sp                # Folder of SPICE files
    `-- /vsrc              # Folder of verilog files
|-- /templates             # Folder of templates
|-- /test                  # Folder of test scripts
`-- /tools                 # Folder of useful scripts
```

# Future Plan
- Present version can only realize convolution process, need to realize the whole process of CNN then apply on some applications.
  - Only design for initialized memory, write control need to be realized.
  - CNN circuit.
  - ...
- Design for $9\times 10$ array, still needs to be manually modified, automatic is needed.
- All the data are 1-bit, multi-bits is needed.
- Hard to get the energy and area of the system.

# References
## MRAM model:
1. https://github.com/ARM-software/mram_simulation_framework
2. https://github.com/zhuzibn/ODE_LLG_integral

## Framework:
3. https://github.com/akashlevy/pyxbar

