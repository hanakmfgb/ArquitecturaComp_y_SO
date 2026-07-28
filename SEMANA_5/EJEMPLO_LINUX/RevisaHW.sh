#!/bin/bash

# Detectar el Sistema Operativo (Linux o Darwin/macOS)
OS="$(uname -s)"

# Variable de control del bucle
x=0

# Función equivalente a 'preguntar'
# Recibe dos argumentos: 
# $1 = Tipo de componente (cpu, board, bios)
# $2 = Nombre legible para mostrar
preguntar() {
    componente=$1
    titulo=$2
    
    clear
    echo "¿Que quieres ver de $titulo?"
    echo "1. Nombre / Versión"
    echo "2. Fabricante"
    echo "3. Detallada"
    
    read -p "Elige una opción: " opcion
    
    echo ""
    echo "--- Resultado ---"

    # Lógica para LINUX (Ubuntu)
    if [ "$OS" = "Linux" ]; then
        # Nota: dmidecode requiere permisos de root (sudo) para placa y bios
        if [ "$componente" = "cpu" ]; then
            if [ "$opcion" -eq 1 ]; then lscpu | grep "Model name"; fi
            if [ "$opcion" -eq 2 ]; then lscpu | grep "Vendor ID"; fi
            if [ "$opcion" -eq 3 ]; then lscpu; fi
        elif [ "$componente" = "board" ]; then
            if [ "$opcion" -eq 1 ]; then sudo dmidecode -t baseboard | grep "Product Name"; fi
            if [ "$opcion" -eq 2 ]; then sudo dmidecode -t baseboard | grep "Manufacturer"; fi
            if [ "$opcion" -eq 3 ]; then sudo dmidecode -t baseboard; fi
        elif [ "$componente" = "bios" ]; then
            if [ "$opcion" -eq 1 ]; then sudo dmidecode -t bios | grep "Version"; fi
            if [ "$opcion" -eq 2 ]; then sudo dmidecode -t bios | grep "Vendor"; fi
            if [ "$opcion" -eq 3 ]; then sudo dmidecode -t bios; fi
        fi

    # Lógica para MACOS (Darwin)
    elif [ "$OS" = "Darwin" ]; then
        if [ "$componente" = "cpu" ]; then
            if [ "$opcion" -eq 1 ]; then sysctl -n machdep.cpu.brand_string; fi
            if [ "$opcion" -eq 2 ]; then sysctl -n machdep.cpu.vendor; fi
            if [ "$opcion" -eq 3 ]; then sysctl machdep.cpu; fi
        elif [ "$componente" = "board" ]; then
            # En Mac la "placa base" es propietaria, mostramos el identificador del modelo
            if [ "$opcion" -eq 1 ]; then system_profiler SPHardwareDataType | grep "Model Identifier"; fi
            if [ "$opcion" -eq 2 ]; then echo "Fabricante: Apple Inc."; fi
            if [ "$opcion" -eq 3 ]; then system_profiler SPHardwareDataType; fi
        elif [ "$componente" = "bios" ]; then
            # En Mac equivale a la ROM de arranque o Firmware
            if [ "$opcion" -eq 1 ]; then system_profiler SPHardwareDataType | grep "System Firmware"; fi
            if [ "$opcion" -eq 2 ]; then echo "Fabricante: Apple Inc."; fi
            if [ "$opcion" -eq 3 ]; then system_profiler SPHardwareDataType; fi
        fi
    fi
}

# Inicio del menú principal
while [ $x -ne 4 ]
do
    clear
    echo "Información de Hw y Sw ($OS)"
    echo ""
    echo "1. Procesador"
    echo "2. Placa Base"
    echo "3. BIOS"
    echo "4. Salir"
    
    read -p "Seleccione opción: " x

    if [ "$x" -eq 1 ]; then preguntar "cpu" "Procesador"; fi
    if [ "$x" -eq 2 ]; then preguntar "board" "Placa Base"; fi
    if [ "$x" -eq 3 ]; then preguntar "bios" "BIOS"; fi
    
    if [ "$x" -ne 4 ]; then
        echo ""
        read -p "Pulsa Enter para continuar..." dummy
    fi
done
