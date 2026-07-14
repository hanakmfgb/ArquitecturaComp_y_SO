# -*- coding: utf-8 -*-
"""
Created on Sun Jul 12 23:21:26 2026

@author: MARCELOFGB
"""

# =====================================================================
# EJEMPLO 3: HEXADECIMAL - TRADUCTOR Y GENERADOR DE COLORES RGB
# =====================================================================

def visualizar_color_hex(hex_str):
    # Limpiamos el formato del input
    hex_str = hex_str.lstrip('#').upper()
    if len(hex_str) != 6 or not all(c in '0123456789ABCDEF' for c in hex_str):
        print("Error: Introduce un código hexadecimal de color de 6 caracteres (ej. #3498DB)")
        return
    
    # Segmentamos el hexadecimal en porciones de 1 byte (2 caracteres hex)
    hex_rojo = hex_str[0:2]
    hex_verde = hex_str[2:4]
    hex_azul = hex_str[4:6]
    
    # Convertimos de base 16 (Hexadecimal) a base 10 (Decimal)
    int_rojo = int(hex_rojo, 16)
    int_verde = int(hex_verde, 16)
    int_azul = int(hex_azul, 16)
    
    print("\n" + "="*60)
    print(f"  DECODIFICADOR DE VIDEO Y TARJETA GRÁFICA: HEX #{hex_str}")
    print("="*60)
    
    print(" Canales de Memoria de la GPU (Bytes):")
    print(f"   🔴 Rojo (R)  : Hexadecimal \033[91m0x{hex_rojo}\033[0m  -->  Decimal {int_rojo:<3} (Intensidad)")
    print(f"   🟢 Verde (G) : Hexadecimal \033[92m0x{hex_verde}\033[0m  -->  Decimal {int_verde:<3} (Intensidad)")
    print(f"   🔵 Azul (B)  : Hexadecimal \033[94m0x{hex_azul}\033[0m  -->  Decimal {int_azul:<3} (Intensidad)")
    
    # Dibujar la muestra física de color usando True Color ANSI en la terminal
    # Secuencia ANSI: \033[48;2;R;G;Bm crea un fondo con ese color RGB específico
    ansi_color = f"\033[48;2;{int_rojo};{int_verde};{int_azul}m"
    reset_color = "\033[0m"
    
    print("\nMuestra de color renderizada por la GPU:")
    print("  ┌" + "─"*30 + "┐")
    for _ in range(4): # Creamos un bloque de 4 líneas de alto
        print(f"  │{ansi_color}{' '*30}{reset_color}│")
    print("  └" + "─"*30 + "┘")

# Entrada del alumno (pueden probar con 'FF5733', '3498DB', '2ECC71', 'F1C40F')
codigo_hexadecimal = "A298DA"
visualizar_color_hex(codigo_hexadecimal)