MAKEFILE_DIR = $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

$(warning Remember to configure the project in scripts/setup/project_settings.json!)
$(warning Remember to run 'make setup'!)

# Check if config/make/project.mk exists,
# include it if so
ifeq ($(wildcard config/make/project.mk),)
    $(warning config/make/project.mk does not exist! Run 'make setup NAME=<project name>')
else
    include config/make/project.mk
endif

# Check if config/make/vivado_params.mk exists,
# include it if so
ifeq ($(wildcard config/make/vivado_params.mk),)
    $(error config/make/vivado_params.mk does not exist!)
else
    include config/make/vivado_params.mk
endif

default: xsim

setup: reset project_file

project_file:
	cd scripts/setup && \
	python setup.py --root_dir "$(MAKEFILE_DIR)"

$(VIVADO_PRJ): project_file

xvlog: $(VIVADO_PRJ)
	cd sim && \
	xvlog $(XVLOG_PARAMS) --prj $(VIVADO_PRJ)

xelab: xvlog
	cd sim && \
	xelab $(XELAB_PARAMS)

xsim: xelab
	cd sim && \
	xsim $(XSIM_PARAMS) $(SNAPSHOT) && \
	mv dump.vcd $(SNAPSHOT).vcd

vivado_waves: $(MAKEFILE_DIR)sim/$(SNAPSHOT).wdb
	cd sim && \
	xsim --gui $(SNAPSHOT).wdb

gtkwave: $(MAKEFILE_DIR)sim/$(SNAPSHOT).vcd
	cd sim && \
	gtkwave -T $(MAKEFILE_DIR)scripts/tcl/gtkwave_load_all_signals.tcl $(SNAPSHOT).vcd

clean:
	find sim -type f ! -name '*.prj' | xargs rm -f && \
	rm -rf xsim.dir && \
	rm -rf ./**/xsim.dir && \
	rm -rf sim/.Xil


reset: clean
	rm -rf sim/*
	rm -f config/project.mk
