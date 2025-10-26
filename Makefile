# Makefile for Operating Systems Worksheet 1
# Builds all assembly programs for Tasks 1 and 2

# Compiler and flags
NASM = nasm
GCC = gcc
NASM_FLAGS = -f elf -i src/
GCC_FLAGS = -m32

# Source directory
SRC_DIR = src

# All executable targets
ALL_TARGETS = task1.1 task1.2 task2.1 task2.2 task2.3 task2.4

# Default target - builds all programs
all: $(ALL_TARGETS)

# Task 1.1 - Simple addition
task1.1: $(SRC_DIR)/driver.o $(SRC_DIR)/task1.1.o $(SRC_DIR)/asm_io.o
	$(GCC) $(GCC_FLAGS) $(SRC_DIR)/driver.o $(SRC_DIR)/task1.1.o $(SRC_DIR)/asm_io.o -o task1.1

# Task 1.2 - Interactive addition
task1.2: $(SRC_DIR)/driver.o $(SRC_DIR)/task1.2.o $(SRC_DIR)/asm_io.o
	$(GCC) $(GCC_FLAGS) $(SRC_DIR)/driver.o $(SRC_DIR)/task1.2.o $(SRC_DIR)/asm_io.o -o task1.2

# Task 2.1 - Prime number finder
task2.1: $(SRC_DIR)/driver.o $(SRC_DIR)/task2.1.o $(SRC_DIR)/asm_io.o
	$(GCC) $(GCC_FLAGS) $(SRC_DIR)/driver.o $(SRC_DIR)/task2.1.o $(SRC_DIR)/asm_io.o -o task2.1

# Task 2.2 - Welcome message
task2.2: $(SRC_DIR)/driver.o $(SRC_DIR)/task2.2.o $(SRC_DIR)/asm_io.o
	$(GCC) $(GCC_FLAGS) $(SRC_DIR)/driver.o $(SRC_DIR)/task2.2.o $(SRC_DIR)/asm_io.o -o task2.2

# Task 2.3 - Array sum
task2.3: $(SRC_DIR)/driver.o $(SRC_DIR)/task2.3.o $(SRC_DIR)/asm_io.o
	$(GCC) $(GCC_FLAGS) $(SRC_DIR)/driver.o $(SRC_DIR)/task2.3.o $(SRC_DIR)/asm_io.o -o task2.3

# Task 2.4 - Range sum
task2.4: $(SRC_DIR)/driver.o $(SRC_DIR)/task2.4.o $(SRC_DIR)/asm_io.o
	$(GCC) $(GCC_FLAGS) $(SRC_DIR)/driver.o $(SRC_DIR)/task2.4.o $(SRC_DIR)/asm_io.o -o task2.4

# Compile assembly files to object files
$(SRC_DIR)/%.o: $(SRC_DIR)/%.asm
	$(NASM) $(NASM_FLAGS) $< -o $@

# Compile C driver to object file
$(SRC_DIR)/driver.o: $(SRC_DIR)/driver.c
	$(GCC) $(GCC_FLAGS) -c $< -o $@

# Clean up object files and executables
clean:
	rm -f $(SRC_DIR)/*.o $(ALL_TARGETS)

# Phony targets (not actual files)
.PHONY: all clean