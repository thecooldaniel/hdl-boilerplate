# Directories to look for files
set src_dirs [
    dict create \
    "interfaces"    "src/interfaces" \
    "packages"      "src/packages" \
    "modules"       "src/modules" \
    "tests"         "test"
]

set src_ext {
    "*.v"
    "*.sv"
    "*.hdl"
    "*.vhdl"
}