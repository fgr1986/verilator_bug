mkdir -p bin
verilator --timing --timing -Wall --trace -cc  ./src/main_module.sv ./src/derived_module.sv ./tb/tb_top.sv --top tb_top --exe ../..//./tb/tb_main.cpp -Mdir ./bin/obj_dir
./bin/obj_dir/Vtb_top
