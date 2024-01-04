source scripts/tcl/src_dirs.tcl

proc getFiles {key dirs exts} {
    set temp {}
    foreach ext $exts {
        lappend temp [glob -nocomplain [dict get $dirs $key]/$ext]
        lappend temp [glob -nocomplain [dict get $dirs $key]/**/$ext]
    }
    return $temp
}

proc removeEmptyPaths {list} {
    set temp [lrange $list 0 end]
    while {[lsearch -exact $temp ""] >= 0} {
        set temp [lreplace $temp [lsearch -exact $temp ""] [lsearch -exact $temp ""]]
    }
    return $temp
}

# Get all files
set files_interfaces [getFiles "interfaces" $src_dirs $src_ext]
set files_packages [getFiles "packages" $src_dirs $src_ext]
set files_modules [getFiles "modules" $src_dirs $src_ext]
set files_tests [getFiles "tests" $src_dirs $src_ext]

# Remove empty indexes
set files_interfaces [removeEmptyPaths $files_interfaces]
set files_packages [removeEmptyPaths $files_packages]
set files_modules [removeEmptyPaths $files_modules]
set files_tests [removeEmptyPaths $files_tests]

puts $files_interfaces
puts $files_packages
puts $files_modules
puts $files_tests

