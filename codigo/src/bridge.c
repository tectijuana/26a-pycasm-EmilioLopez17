// bridge.c - Interfaz entre Python y Assembly ARM64
// Compila a librería compartida (.so)

#include <stdio.h>
#include <stdint.h>

// =====================================
// Declaración de funciones en assembly
// =====================================
extern int add(int a, int b);
extern int sub(int a, int b);
extern int mul(int a, int b);
extern int max(int a, int b);
extern int min(int a, int b);

extern int sum_array(int* arr, int n);
extern int count_even(int* arr, int n);
extern int dot_product(int* a, int* b, int n);

// =====================================
// Wrappers (exportados a Python)
// =====================================

// suma
int c_add(int a, int b) {
    return add(a, b);
}

// resta
int c_sub(int a, int b) {
    return sub(a, b);
}

// multiplicación
int c_mul(int a, int b) {
    return mul(a, b);
}

// máximo
int c_max(int a, int b) {
    return max(a, b);
}

// mínimo
int c_min(int a, int b) {
    return min(a, b);
}

// suma de arreglo
int c_sum_array(int* arr, int n) {
    return sum_array(arr, n);
}

// conteo de pares
int c_count_even(int* arr, int n) {
    return count_even(arr, n);
}

// producto punto
int c_dot_product(int* a, int* b, int n) {
    return dot_product(a, b, n);
}
