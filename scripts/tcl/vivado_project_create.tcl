source scripts/tcl/vivado_project_create.tcl

# set top_module "boilerplate"

add_files -fileset constrs_1 -force -norecurse config/constraints.xdc

# launch_simulation

# update_compile_order -fileset sources_1
# set_property top $top_module [get_filesets sources_1]

# launch_runs synth_1
# wait_on_runs synth_1

# open_run synth_1 -name netlist_1

# report_timing_summary -delay_type max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file sim/syn_timing.rpt
# report_power -file sim/syn_power.rpt

# add_files -fileset sim_1 [get_files -of_objects [get_filesets sources_1]]
# set_property top ${top_module}_tb [get_filesets sim_1]
# launch_sim -simset [get_filesets sim_1]

# xelab -debug typical $top_module -s sim_snapshot

# xsim sim_snapshot -runall

# launch_runs impl_1 -to_step write_bitstream
# wait_on_run impl_1

# open_run impl_1
# report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -file sim/imp_timing.rpt
# report_power -file sim/imp_power.rpt

quit