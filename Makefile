# Makefile - Proyecto ARM64 Python + C + Assembly
# Compila librería compartida para ctypes

CC = gcc
AS = gcc

TARGET = build/libops.so

SRC_C = src/bridge.c
SRC_S = src/ops.s

CFLAGS = -fPIC -O2 -Wall
ASFLAGS = -fPIC

all: $(TARGET)

# ======================================
# Construcción de librería compartida
# ======================================
$(TARGET): $(SRC_C) $(SRC_S)
	@mkdir -p build
	$(CC) $(CFLAGS) -c $(SRC_C) -o build/bridge.o
	$(AS) $(ASFLAGS) -c $(SRC_S) -o build/ops.o
	$(CC) -shared build/bridge.o build/ops.o -o $(TARGET)

# ======================================
# Limpieza
# ======================================
clean:
	rm -rf build/*.o $(TARGET)

# ======================================
# Rebuild completo
# ======================================
rebuild: clean all
