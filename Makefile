# Makefile

# Define the source folders
VERILOG_SRC_FOLDER := ./src
VERILOG_TB_FOLDER := ./tb

# Define the source files
VERILOG_SRCS := main_module.sv derived_module.sv

CPP_FOLDER = ./tb
CPP_TB = tb_main.cpp

# Define the Verilator executable
VERILATOR = verilator --timing
VFLAGS = --timing -Wall --trace -cc 
# -std=c++20

# Define the top module
TOP_MODULE = tb_top
VERILOG_MAIN_TB := tb_top.sv

# Prepend the folder paths to the file names
VERILOG_TB_FILES := $(addprefix $(VERILOG_TB_FOLDER)/, $(VERILOG_MAIN_TB))
VERILOG_SRC_FILES := $(addprefix $(VERILOG_SRC_FOLDER)/, $(VERILOG_SRCS))
# Combine the source and testbench files
VERILOG_FILES := $(VERILOG_SRC_FILES) $(VERILOG_TB_FILES)

# Define the output directory
OBJ_DIR = ./bin/obj_dir
OBJ_DIR_2_TB = ../../

# Define the target executable
TARGET = $(OBJ_DIR)/V$(TOP_MODULE)

# Phony targets
.PHONY: all clean run compile_commands.json build

# Default target
all: $(TARGET)

# Clean the output directory
clean:
	rm -rf $(OBJ_DIR)
	rm -rf $(VERILOG_TB_FOLDER)/$(VERILOG_MAIN_TB);
	rm -f compile_commands.json
	rm -f *.vcd


.PHONY:lint
lint:
	verilator --lint-only $(filter %/$(MODULE).sv, $(VERILOG_FILES))

# Generate compile_commands.json
compile_commands.json:
	bear -- make all

# Ensure the output directory exists
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# Run Verilator to generate the makefile and simulation files
$(OBJ_DIR)/V$(TOP_MODULE).mk: $(VERILOG_FILES) $(CPP_FOLDER)/$(CPP_TB) | $(OBJ_DIR)
	$(VERILATOR) $(VFLAGS) $(VERILOG_FILES) --top $(TOP_MODULE) --exe $(OBJ_DIR_2_TB)/$(CPP_FOLDER)/$(CPP_TB) -Mdir $(OBJ_DIR)

# Compile the generated simulation files
$(TARGET): $(OBJ_DIR)/V$(TOP_MODULE).mk
	cp $(CPP_FOLDER)/$(CPP_TB) $(OBJ_DIR)  # Copy the testbench file to obj_dir
	make -j  `nproc` -C $(OBJ_DIR) -f V$(TOP_MODULE).mk V$(TOP_MODULE)

# Run the simulation
run: all
	echo ""
	echo "Simulating $(VERILOG_TB)"
	echo ""
	$(TARGET)

