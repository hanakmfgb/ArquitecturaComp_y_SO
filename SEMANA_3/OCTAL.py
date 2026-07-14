# -*- coding: utf-8 -*-
"""
Created on Sun Jul 12 23:23:45 2026

@author: MARCELOFGB
"""

# =====================================================================
# EJEMPLO 2: OCTAL - VISUALIZADOR DE PERMISOS LINUX (chmod)
# =====================================================================

def decodificar_permisos_octales(octal_str):
    if len(octal_str) != 3 or not all(c in '01234567' for c in octal_str):
        print("Error: Introduce un número octal de permisos de 3 dígitos (0-7)")
        return
    
    roles = ["Propietario (User)", "Grupo (Group)", "Otros (Others)"]
    simbolos = ["r", "w", "x"]
    
    print("\n" + "="*60)
    print(f"  ANALIZADOR DE SEGURIDAD DEL S.O. - PERMISOS OCTALES: {octal_str}")
    print("="*60)
    
    matriz_final = ""
    
    # Procesamos cada dígito octal
    for i, digito in enumerate(octal_str):
        valor_decimal = int(digito)
        # Convertimos el dígito octal a un binario de 3 bits exactos
        binario = format(valor_decimal, '03b')
        
        # Mapeamos los bits a r, w, x
        permiso_texto = ""
        for j, bit in enumerate(binario):
            if bit == '1':
                # Verde para activo
                permiso_texto += f"\033[92m{simbolos[j]}\033[0m"
            else:
                # Rojo o guion para inactivo
                permiso_texto += "\033[90m-\033[0m"
        
        matriz_final += permiso_texto
        
        print(f" Rol: {roles[i]:<20} | Octal: {digito} | Binario: {binario} | Permisos: [{permiso_texto}]")
    
    # Dibujar la terminal simulada de Linux
    print("\nRepresentación en consola de comandos ($ ls -l):")
    print(f"  \033[93m- {matriz_final} \033[0m archivo_clase.txt")

# Entrada del alumno (pueden probar con 755, 644, 700, etc.)
permisos_octal = "570"
decodificar_permisos_octales(permisos_octal)