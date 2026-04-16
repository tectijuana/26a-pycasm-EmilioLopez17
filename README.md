# Proyecto ARM64: Python + C + Assembly Optimizado

## Descripción

Este proyecto implementa una librería de alto rendimiento en arquitectura **ARM64 (AArch64)** utilizando una integración de tres lenguajes:

- Python (interfaz y pruebas)
- C (capa de enlace / bridge)
- Assembly ARM64 (optimización de bajo nivel)

El objetivo es analizar el rendimiento y la interacción entre estos niveles de abstracción, además de demostrar el uso de optimización a nivel de hardware.

---

## Arquitectura del sistema

```text
Python (app.py)
    ↓ ctypes
C (bridge.c)
    ↓ linking
Assembly ARM64 (ops.s)
    ↓
libops.so
