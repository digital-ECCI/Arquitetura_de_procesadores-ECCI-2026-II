# Lab04: ALU, banco registro y UART.

### Contenido:

- [Lab04: ALU, banco registro y UART.](#lab04-alu-banco-registro-y-uart)
    - [Contenido:](#contenido)
  - [1. Objetivos de aprendizaje](#1-objetivos-de-aprendizaje)
  - [2. Fundamento teórico](#2-fundamento-teórico)
    - [2.1 ALU](#21-alu)
    - [2.2 Banco Registro](#22-banco-registro)
    - [2.3 UART](#23-uart)
      - [Principio de operación](#principio-de-operación)
  - [3. Procedimiento](#3-procedimiento)
  - [4. Entregables](#4-entregables)


## 1. Objetivos de aprendizaje

* Comprender el funcionamiento de la Unidad Aritmético-Lógica (ALU) y el banco de registros como bloques fundamentales en la microarquitectura de un procesador.

* Implementar un módulo de banco de registros para almacenar operandos y resultados, facilitando el flujo de datos.

* Desarrollar un sistema de visualización para monitorear los datos almacenados en el banco de registros, permitiendo analizar el comportamiento interno del procesador.

* Corroborar el funcionamiento del proyecto mediante implementación sobre la FPGA.


## 2. Fundamento teórico

### 2.1 ALU

Una ALU es el bloque dentro del procesador encargado de realizar las operaciones matemáticas y lógicas básicas sobre los datos. En la microarquitectura de un procesador, la ALU es un bloque dentro del datapath conectado a los registros y se encarga de realizar operaciones aritméticas como suma, resta, multiplicación simple y división básica, operaciones lógicas como AND, OR, XOR, NOT y desplazamientos. 


![Alu](/labs/figs/lab5/ALU.png)



### 2.2 Banco Registro

El banco registro, es un conjunto de registros que permite almacenar temporalmente datos y resultados intermedios de las operaciones realizadas por la ALU. El banco registro facilita el acceso rápido a los datos necesarios para las operaciones, mejorando la eficiencia del procesador. En sistemas digitales, tanto la ALU como el banco registro son fundamentales para la ejecución de instrucciones y el procesamiento de información, ya que permiten realizar cálculos, tomar decisiones lógicas y gestionar el flujo de datos dentro del sistema.

![bancoRegistro](/labs/figs/lab5/bancoRegistro.png)

### 2.3 UART


UART (Universal Asynchronous Receiver-Transmitter) es un protocolo de comunicación serial asíncrona ampliamente utilizado en sistemas embebidos, microcontroladores y dispositivos de comunicación. Su origen se remonta a los años 60 con los sistemas de teleprocesamiento, y hoy sigue siendo uno de los estándares más fundamentales en electrónica digital.


#### Principio de operación


A diferencia de los protocolos síncronos (SPI, I²C), UART no requiere una señal de reloj compartida entre emisor y receptor. La sincronización se logra mediante un acuerdo previo sobre la velocidad de transmisión (baud rate), expresada en baudios (bits por segundo). Valores típicos son 9600, 115200 y 1 Mbps.

La transmisión ocurre sobre dos líneas unidireccionales:

TX (Transmit): línea de salida del emisor
RX (Receive): línea de entrada del receptor

La comunicación es full-duplex, permitiendo envío y recepción simultáneos.


![imagen](/labs/figs/lab5/UART_TX.png)


## 3. Procedimiento



1. Implemente un modulo banco registro que permita almacenar los operandos y resultado de las operaciones realizadas por la ALU.

2. Implemente un modulo que permita realizar la visualización de los datos guardados en el banco registro, ya sean los operandos o el resultado (Opcional: la dirección de memoria).

3. Integrar los módulos necesarios en un modulo `top`.

4. Cree el testbench para realizar la respectiva simulación.

5. Una vez corroboré el comportamiento esperado en simulación, cree un proyecto en quartus y realice la respectiva implementación utilizando switches y el protocolo UART para visualización en CMD del PC o un software de comunicación serial.



## 4. Entregables

1. Comprenda cada línea del código HDL de cada archivo que se encuentra en la carpera [src](./src) y comente si es necesario en su respectivo archivo ```README.md```.

2. Realice cada uno de los pasos descritos en [Procesdimiento](#3-procedimiento) y muestre las respectivas evidencias en clase.

3. Adjunte las evidencias en su respectivo repositorio en Github classroom.