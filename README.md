

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

# 6. Ejemplo y análisis de una simulación funcional del sistema completo.

---

# 7. Análisis de consumo de recursos en la FPGA (LUTs, FFs, etc.) y del consumo de potencia que reporta las herramientas.

---

# 8. Reporte de velocidades máximas de reloj posibles en el diseño

---

# 9. Análisis de principales problemas hallados durante el trabajo y de las soluciones aplicadas.

---

# 10. Ejercicios 

## 10.1 Contadores sincrónicos

Para este ejercicio se utilizaron dos contadores síncronos **74HCT163** conectados en cascada, siguiendo el circuito indicado en la guía del proyecto. Inicialmente se intentó utilizar el modelo 74LS163 indicado en el enunciado; sin embargo, fue necesario reemplazarlo por el 74HCT163 debido a problemas de compatibilidad lógica con los niveles de voltaje de la FPGA TangNano.

La señal de reloj fue generada desde la FPGA, ajustando la frecuencia lo más cercana posible a la especificada en la guía. El funcionamiento del sistema fue verificado utilizando el osciloscopio Keysight DSO-X2002A en modo analizador lógico, observando las señales de salida de ambos contadores y la propagación del acarreo entre ellos.

### Cambio del 74LS163 al 74HCT163

A la hora de conseguir los materiales para esta parte del proyecto no fue posible conseguir el modelo 74LS163 requerido, por esta razón, se decidió reemplazar el dispositivo por un **74HCT163**, el cual mantiene el mismo funcionamiento lógico del contador síncrono original, pero posee compatibilidad mejorada con señales CMOS y niveles de voltaje más adecuados para la FPGA TangNano.

### Funcionamiento general del contador en cascada

#### Diagrama del circuito (Modelo 74LS163)

<img width="685" height="379" alt="image" src="https://github.com/user-attachments/assets/939f3866-db19-445a-9c72-188d93113517" />

#### Circuito utilizado para las mediciones

<img width="1939" height="1455" alt="ContadorSincronicoCircuito" src="https://github.com/user-attachments/assets/8eb1faeb-8232-4457-932a-47b69baf0cbd" />

El 74HCT163 es un contador binario síncrono de 4 bits con capacidad de carga paralela y reset síncrono. Al conectar dos dispositivos en cascada se obtiene un contador de 8 bits, donde el contador menos significativo genera una señal de acarreo hacia el contador más significativo.

Durante las pruebas experimentales se verificó que ambos contadores incrementaban correctamente su valor binario en cada flanco positivo del reloj. El contador menos significativo realizaba el conteo principal mientras que el contador más significativo avanzaba únicamente cuando el primero completaba un ciclo completo de conteo.

### ¿Qué hace la salida RCO en un 74HCT163?

La salida **RCO** (*Ripple Carry Output*) corresponde a la señal de acarreo del contador. Esta salida se activa cuando el contador alcanza su valor máximo (`1111`) y las entradas de habilitación permiten continuar el conteo.

La función principal de esta señal es permitir la conexión en cascada de múltiples contadores, de manera que un contador pueda habilitar el incremento del siguiente.

### Explicación de la conexión entre RCO y T

La salida **RCO** del contador menos significativo se conecta a la entrada de habilitación **T** (o ENT) del contador más significativo para permitir el conteo en cascada.

Cuando el contador menos significativo llega a su valor máximo (`1111`), la señal RCO se activa y habilita el siguiente contador. De esta manera, el contador más significativo únicamente cambia de estado cuando el primero completa un ciclo completo de conteo.

Gracias a esta conexión, ambos dispositivos funcionan como un único contador de mayor tamaño, manteniendo la sincronización mediante el mismo reloj.

### Diferencia entre las entradas T y P del 74HCT163

Las entradas **T** y **P** corresponden a señales de habilitación del contador.

- **P (ENP)**: habilita el conteo interno del dispositivo.
- **T (ENT)**: habilita tanto el conteo como la generación de la señal de acarreo RCO.

Para que el contador funcione correctamente, ambas señales deben encontrarse activas. Sin embargo, la entrada T tiene una función adicional relacionada con la propagación del acarreo entre contadores conectados en cascada.

### Tiempo de cambio de estado después del flanco positivo

Durante las mediciones realizadas con el osciloscopio, se observó que las salidas del contador no cambian instantáneamente después del flanco positivo del reloj. Existe un pequeño retardo de propagación asociado al tiempo interno de conmutación de los flip-flops del circuito integrado.

Este retardo corresponde al tiempo que tarda la salida en estabilizarse luego del flanco activo del reloj y depende de las características internas del dispositivo y de la carga conectada a las salidas.

### ¿Importa cuál bit de salida se escoja para medir?

Sí. El tiempo de propagación puede variar ligeramente dependiendo del bit observado.

Los bits menos significativos cambian de estado con mayor frecuencia, mientras que los bits más significativos dependen de múltiples transiciones internas antes de cambiar su valor. Debido a esto, algunos bits pueden presentar retardos ligeramente distintos o evidenciar con mayor claridad ciertos efectos transitorios.

Por esta razón, seleccionar diferentes bits puede producir observaciones distintas durante la medición experimental.

### Observación de fallas en la salida RCO

Se utilizó la opción de captura de fallas del osciloscopio para observar posibles pulsos espurios o glitches en la salida RCO del contador menos significativo.

Durante las pruebas fue posible observar pequeñas perturbaciones temporales en ciertos cambios de estado. Estas fallas ocurren debido a diferencias en los tiempos de propagación internos de los flip-flops y la lógica combinacional del contador.

Los glitches son más probables durante transiciones donde múltiples bits cambian simultáneamente, especialmente en cambios cercanos al desbordamiento del contador. Debido a que estas perturbaciones son extremadamente cortas, resultan difíciles de detectar y requieren herramientas de captura rápida o visualización analógica para ser observadas correctamente.

### Conclusiones del ejercicio

La práctica permitió comprender el funcionamiento de los contadores síncronos y el mecanismo de propagación de acarreo utilizado para conectar múltiples dispositivos en cascada. Además, se analizaron fenómenos reales asociados a retardos de propagación y glitches temporales presentes en circuitos digitales físicos.

El uso del osciloscopio como analizador lógico permitió verificar experimentalmente el comportamiento del contador y relacionar los resultados obtenidos con la teoría estudiada durante el curso.


## 10.2 Construcción de un cerrojo Set-Reset con compuertas NAND

