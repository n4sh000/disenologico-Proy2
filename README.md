

# Instituto Tecnológico de Costa Rica  
## Escuela de Ingeniería Electrónica  

### EL-3307 Diseño Lógico  
### I Semestre 2026  

---

# Proyecto Corto II  
## Diseño digital sincrónico en HDL  

### Implementación de un sistema de captura y suma de datos utilizando FPGA TangNano

---

### Integrantes

- David Ignacio Araya Mora
- Nicolás Castro Sánchez  
- Sebastián Fallas Mora

---

### Profesor  
Dr.-Ing. Alfonso Chacón-Rodríguez  

---

### Fecha de entrega  
12 de Mayo del 2026  

---

# 1. Introducción

El presente proyecto consiste en el diseño e implementación de un sistema digital sincrónico utilizando SystemVerilog sobre una FPGA TangNano. El objetivo principal es desarrollar un circuito capaz de capturar dos números enteros positivos de hasta tres dígitos decimales mediante un teclado hexadecimal, realizar la suma aritmética de ambos valores y desplegar los resultados en dispositivos de 7 segmentos.

Para el desarrollo del sistema se aplicaron conceptos fundamentales de diseño digital sincrónico, incluyendo sincronización de señales externas, eliminación de rebotes mecánicos, diseño de máquinas de estados finitos (FSM), multiplexación de displays y validación mediante simulaciones funcionales. Además, se utilizó un flujo de diseño basado en herramientas EDA y lenguajes de descripción de hardware, permitiendo implementar y verificar el funcionamiento del sistema directamente en la FPGA.

---

# 2. Definición del problema, objetivos y especificaciones

El problema planteado consiste en desarrollar un sistema digital capaz de recibir entradas numéricas desde un teclado hexadecimal mecánico y procesarlas de forma sincrónica dentro de una FPGA. El sistema debe permitir al usuario ingresar dos números decimales positivos de hasta tres dígitos, almacenarlos correctamente, realizar la suma aritmética correspondiente y mostrar tanto los datos ingresados como el resultado en cuatro displays de 7 segmentos.

Para lograr este objetivo, el diseño debe resolver diferentes desafíos asociados al manejo de señales externas, principalmente la sincronización con el reloj interno de la FPGA y la eliminación de rebotes generados por las teclas mecánicas. Asimismo, el sistema debe implementar una lógica de control que determine el momento adecuado para capturar cada número y ejecutar la operación aritmética.

Las principales especificaciones establecidas para el proyecto son las siguientes:

- Implementar el sistema utilizando SystemVerilog.
- Utilizar únicamente un reloj principal de 27 MHz proporcionado por la FPGA TangNano.
- Diseñar un subsistema de lectura para el teclado hexadecimal con sincronización y debounce.
- Implementar la suma aritmética de los datos ingresados.
- Mostrar los valores y resultados mediante displays de 7 segmentos multiplexados.
- Diseñar el sistema siguiendo principios de diseño digital sincrónico.
- Verificar el funcionamiento mediante simulaciones RTL y pruebas posteriores a síntesis.

---

# 3. Descripción general del funcionamiento del circuito y de cada subsistema

El sistema completo se divide en tres subsistemas principales: lectura del teclado hexadecimal, suma aritmética y despliegue en displays de 7 segmentos. Cada uno de estos bloques trabaja de manera sincronizada utilizando el reloj principal de 27 MHz de la FPGA.

## 3.1 Subsistema de lectura del teclado hexadecimal

Este subsistema se encarga de detectar las teclas presionadas en el teclado hexadecimal y convertirlas en datos digitales válidos para el sistema. Debido a que las teclas mecánicas producen rebotes eléctricos al ser presionadas, se implementa una etapa de *debounce* y sincronización para garantizar lecturas estables.

El sistema realiza un barrido periódico de filas y columnas del teclado para identificar la tecla activa. Posteriormente, una máquina de estados finitos (FSM) controla el proceso de captura de datos, determinando cuándo se está ingresando el primer número, el segundo número y cuándo debe ejecutarse la suma.

Los dígitos ingresados se almacenan temporalmente en registros internos dentro de la FPGA para ser utilizados por el subsistema aritmético.

## 3.2 Subsistema de suma aritmética

El subsistema aritmético toma los dos números almacenados y realiza la suma binaria correspondiente utilizando operadores aritméticos de SystemVerilog. La operación se ejecuta de manera completamente sincrónica y el resultado es almacenado en un registro de salida para evitar problemas de temporización.

El diseño permite trabajar con números de hasta tres dígitos decimales, generando un resultado compatible con el rango soportado por el sistema de despliegue.

## 3.3 Subsistema de despliegue en 7 segmentos

Este subsistema recibe los datos binarios y controla los displays de 7 segmentos encargados de mostrar los números ingresados y el resultado de la suma.

Debido a que varios displays comparten líneas de segmentos, se utiliza una técnica de multiplexación para refrescar cada display de manera secuencial a alta velocidad, generando la percepción visual de iluminación simultánea. Además, el sistema incluye lógica de decodificación para convertir los datos binarios a los patrones correspondientes de cada dígito decimal mostrado en los displays.

---

# 4. Diagramas de bloques de cada subsistema y su funcionamiento fundamental

---

# 5. Diagramas de estado de todas las FSM diseñadas

---

# 6. Ejemplo y análisis de una simulación funcional del sistema completo

---

# 7. Análisis de consumo de recursos en la FPGA (LUTs, FFs, etc.) y del consumo de potencia que reporta
las herramientas.

---

# 8. Reporte de velocidades máximas de reloj posibles en el diseño

---

# 9. Análisis de principales problemas hallados durante el trabajo y de las soluciones aplicadas.

---

# 10. Ejercicios 

## 10.1 Contadores sincrónicos

## 10.2 Construcción de un cerrojo Set-Reset con compuertas NAND

