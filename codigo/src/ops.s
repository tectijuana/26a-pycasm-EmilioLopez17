// ops.s - Rutinas optimizadas en ARM64 (AArch64)
// Autor: Medina Lopez Emilio Ignacio 
// Descripción: Operaciones básicas optimizadas para integración con C/Python

.text

// ========================================
// int add(int a, int b)
// ========================================
.global add
.type add, %function

add:
    // x0 = a, x1 = b
    add x0, x0, x1   // x0 = x0 + x1
    ret


// ========================================
// int sub(int a, int b)
// ========================================
.global sub
.type sub, %function

sub:
    sub x0, x0, x1
    ret


// ========================================
// int mul(int a, int b)
// ========================================
.global mul
.type mul, %function

mul:
    mul x0, x0, x1
    ret


// ========================================
// int max(int a, int b)
// ========================================
.global max
.type max, %function

max:
    cmp x0, x1        // compara a vs b
    csel x0, x0, x1, gt  // if (a > b) x0 = a else x0 = b
    ret


// ========================================
// int min(int a, int b)
// ========================================
.global min
.type min, %function

min:
    cmp x0, x1
    csel x0, x0, x1, lt  // if (a < b)
    ret


// ========================================
// int sum_array(int* arr, int n)
// x0 = puntero
// x1 = tamaño
// ========================================
.global sum_array
.type sum_array, %function

sum_array:
    mov x2, #0        // suma = 0
    mov x3, #0        // i = 0

loop_sum:
    cmp x3, x1
    b.ge end_sum

    ldr w4, [x0, x3, LSL #2]  // arr[i]
    add x2, x2, x4

    add x3, x3, #1
    b loop_sum

end_sum:
    mov x0, x2
    ret


// ========================================
// int count_even(int* arr, int n)
// ========================================
.global count_even
.type count_even, %function

count_even:
    mov x2, #0    // contador
    mov x3, #0    // i

loop_even:
    cmp x3, x1
    b.ge end_even

    ldr w4, [x0, x3, LSL #2]

    and x5, x4, #1
    cmp x5, #0
    b.ne skip_inc

    add x2, x2, #1

skip_inc:
    add x3, x3, #1
    b loop_even

end_even:
    mov x0, x2
    ret


// ========================================
// int dot_product(int* a, int* b, int n)
// x0 = a
// x1 = b
// x2 = n
// ========================================
.global dot_product
.type dot_product, %function

dot_product:
    mov x3, #0    // i
    mov x4, #0    // resultado

loop_dot:
    cmp x3, x2
    b.ge end_dot

    ldr w5, [x0, x3, LSL #2]
    ldr w6, [x1, x3, LSL #2]

    mul x7, x5, x6
    add x4, x4, x7

    add x3, x3, #1
    b loop_dot

end_dot:
    mov x0, x4
    ret
