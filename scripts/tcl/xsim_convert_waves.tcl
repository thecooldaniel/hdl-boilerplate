set wdbs  [glob *.wdb]
foreach wdb $wdbs {
    open_wave_database $wdb
    wave_export_vcd -all [concat [file rootname $wdb] ".vcd"]
}

exit