# app.py - Interfaz de pruebas y benchmarking
# Python → ctypes → C → Assembly ARM64

import ctypes
import time
import os

# =========================================
# Cargar librería compartida
# =========================================
lib_path = os.path.abspath("build/libops.so")
lib = ctypes.CDLL(lib_path)

# =========================================
# Definir tipos de retorno/argumentos
# =========================================
lib.c_add.argtypes = [ctypes.c_int, ctypes.c_int]
lib.c_add.restype = ctypes.c_int

lib.c_sub.argtypes = [ctypes.c_int, ctypes.c_int]
lib.c_sub.restype = ctypes.c_int

lib.c_mul.argtypes = [ctypes.c_int, ctypes.c_int]
lib.c_mul.restype = ctypes.c_int

lib.c_max.argtypes = [ctypes.c_int, ctypes.c_int]
lib.c_max.restype = ctypes.c_int

lib.c_min.argtypes = [ctypes.c_int, ctypes.c_int]
lib.c_min.restype = ctypes.c_int

# =========================================
# Helpers para arrays
# =========================================
def to_c_array(py_list):
    return (ctypes.c_int * len(py_list))(*py_list)

lib.c_sum_array.argtypes = [ctypes.POINTER(ctypes.c_int), ctypes.c_int]
lib.c_sum_array.restype = ctypes.c_int

lib.c_count_even.argtypes = [ctypes.POINTER(ctypes.c_int), ctypes.c_int]
lib.c_count_even.restype = ctypes.c_int

lib.c_dot_product.argtypes = [
    ctypes.POINTER(ctypes.c_int),
    ctypes.POINTER(ctypes.c_int),
    ctypes.c_int
]
lib.c_dot_product.restype = ctypes.c_int

# =========================================
# PRUEBAS FUNCIONALES
# =========================================
print("\n===== PRUEBAS FUNCIONALES =====")

print("ADD:", lib.c_add(10, 5))
print("SUB:", lib.c_sub(10, 5))
print("MUL:", lib.c_mul(10, 5))
print("MAX:", lib.c_max(10, 5))
print("MIN:", lib.c_min(10, 5))

arr = [1, 2, 3, 4, 5, 6]

print("SUM ARRAY:", lib.c_sum_array(to_c_array(arr), len(arr)))
print("COUNT EVEN:", lib.c_count_even(to_c_array(arr), len(arr)))

a = [1, 2, 3]
b = [4, 5, 6]

print("DOT PRODUCT:", lib.c_dot_product(to_c_array(a), to_c_array(b), len(a)))

# =========================================
# BENCHMARK SIMPLE
# =========================================
print("\n===== BENCHMARK =====")

def benchmark(func, *args, repeat=100000):
    start = time.perf_counter()
    for _ in range(repeat):
        func(*args)
    end = time.perf_counter()
    return end - start

t_py = benchmark(lambda x, y: x + y, 10, 20)
t_c = benchmark(lib.c_add, 10, 20)

print(f"Python time: {t_py:.6f}s")
print(f"C/ASM time:  {t_c:.6f}s")

# =========================================
# RESULTADO FINAL
# =========================================
print("\nProyecto ARM64 ejecutado correctamente")
