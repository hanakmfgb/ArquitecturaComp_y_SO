# -*- coding: utf-8 -*-
"""
Created on Sun Jul 12 23:26:23 2026

@author: MARCELOFGB
"""

# =====================================================================
# EJEMPLO 1: BINARIO - SIMULADOR DE REGISTRO DE ESTADO DE LA CPU
# =====================================================================

def analizar_registro_cpu(byte_binario):
    # Definimos el significado físico de cada bit en el registro
    banderas = [
        ("N", "Negative (Resultado negativo)"),
        ("Z", "Zero (Resultado igual a cero)"),
        ("C", "Carry (Acarreo en la operación)"),
        ("O", "Overflow (Desbordamiento de memoria)"),
        ("I", "Interrupt (Interrupciones habilitadas)"),
        ("D", "Direction (Dirección de procesamiento)"),
        ("S", "Sign (Signo del resultado)"),
        ("A", "Auxiliary Carry (Acarreo auxiliar)")
    ]
    
    # Validar entrada binaria
    byte_binario = byte_binario.replace("0b", "")
    if len(byte_binario) != 8 or not all(c in '01' for c in byte_binario):
        print("Error: Introduce un byte válido de 8 bits (ej. 10100100)")
        return

    print("\n" + "="*50)
    print("  VISUALIZADOR GRÁFICO DEL REGISTRO DE CPU (8 BITS)  ")
    print("="*50)
    
    # Dibujar el chip del registro de forma gráfica
    print("  ┌───┬───┬───┬───┬───┬───┬───┬───┐")
    print("  │ " + " │ ".join(list(byte_binario)) + " │  <- Bits de Datos")
    print("  ├───┼───┼───┼───┼───┼───┼───┼───┤")
    print("  │ " + " │ ".join([b[0] for b in banderas]) + " │  <- Banderas de la CPU")
    print("  └───┴───┴───┴───┴───┴───┴───┴───┘")
    
    print("\nEstado de las Compuertas Físicas:")
    for i, bit in enumerate(byte_binario):
        estado = "\033[92m[ACTIVO - 1]\033[0m" if bit == '1' else "\033[91m[INACTIVO - 0]\033[0m"
        print(f"  Bit {7-i} -> {banderas[i][0]} ({banderas[i][1]}): {estado}")

# Entrada del alumno (pueden cambiar el número binario aquí)
numero_binario = "10010100" 
analizar_registro_cpu(numero_binario)