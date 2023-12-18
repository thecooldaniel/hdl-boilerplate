A boilerplate for HDL projects. Meant to be used with VSCode, make, and Python, with a few recommended VSCode plugins. Currently only supports the Xilinx binaries xvlog, xelab, and xsim. Emphasis on SystemVerilog.

# Getting Started
1. Pull down the repo
2. Edit scripts/setup/project_settings.json
3. From the root of the project execute `python scripts/setup/setup.py`
4. From the root of the project execute `make setup`

After setup, `make` can be called as usual. To view waves in Vivado, use `make vivado_waves`. To view waves in GTKWave, use `make gtkwave` 
