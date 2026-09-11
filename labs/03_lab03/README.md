# Lab03: Multiplicador de 3 bits usando Máquina de Estados

### Contenido:

1. [Objetivos de aprendizaje](#1-objetivos-de-aprendizaje)

2. [Fundamento teórico](#2-fundamento-teórico)

3. [Procedimiento](#3-procedimiento)

4. [Descripción del HDL base](#4-descripción-del-hdl-base-en-github-classroom)

5. [Entregables](#5-entregables)

## 1. Objetivos de aprendizaje

* Implementar un multiplicador secuencial de 3 bits utilizando una Máquina de Estados Algorítmica (ASM).

+ Comprender el funcionamiento interno de una multiplicación secuencial mediante productos parciales y desplazamientos.

* Sintetizar e implementar el diseño en la tarjeta de desarrollo usando una descripción en HDL.

* Validar el funcionamiento del diseño implementado mediante simulación y pruebas en hardware.


## 2. Fundamento teórico
### 2.1 Multiplicación secuencial

En la multiplicación secuencial, los operandos se procesan bit a bit a lo largo de varios ciclos de reloj. A cada ciclo se realiza una operación parcial (suma o desplazamiento), acumulando el resultado hasta obtener el producto final. Este método es eficiente en términos de área y recursos de hardware, aunque requiere más ciclos de reloj que una multiplicación combinacional.

El módulo diseñado multiplica dos operandos de 3 bits (Multiplicando: MD, Multiplicador: MR). El resultado se acumula en un registro de productos parciales (pp) de 6 bits. Una señal de control (done) indica cuando la operación ha finalizado.


### 2.2 Máquina de Estados Algorítmica (ASM)

Una Máquina de Estados Algorítmica (ASM) es un modelo de computación secuencial en el que el sistema puede encontrarse en un estado a la vez y cambia de estado en respuesta a una entrada o evento, típicamente sincronizado con un reloj.

En este diseño, la ASM se encarga de coordinar:

* La carga de operandos.

* La generación de productos parciales.

* El desplazamiento y acumulación del resultado.

* La finalización del proceso de multiplicación.

Este enfoque ordenado facilita el diseño modular y el control explícito de cada etapa del algoritmo.

### 2.3 Lógica secuencial

La lógica secuencial usa elementos de almacenamiento (como flip-flops) para mantener el estado actual. El próximo estado depende tanto de las entradas actuales como del estado anterior. Esto la diferencia de la lógica combinacional, en donde las salidas dependen únicamente de las entradas presentes.


## 3. Procedimiento

1. Clone el respositorio de entrega, en Github Classroom.

2. Realice la descripción de hardware correspondiente al multiplicador de 4 bits en el archivo ```mult.v``` en la carpeta ```src```.

3. Cree el testbench para realizar la respectiva simulación.

4. Una vez corroboré el comportamiento esperado en simulación, cree un proyecto en Quartus y realice la respectiva implementación.

5. Integre la descripción de hardware necesaria para poder visualizar el resultado en los 7 segmentos de la tarjeta de desarrollo.

6. Empiece la contrucción de la ALU con las operaciones que tiene a la fecha.


## 4. Descripción del HDL base (en Github Classroom)

La descripción HDL que encontrarán implementa un multiplicador secuencial de 3 bits utilizando una máquina de estados algortimica (ASM) para controlar el proceso de multiplicación basado en el algoritmo de productor parciales. En la siguiente figura se muestra el bloque funcional del multiplicador.

 <p align="center">
 <img src="../figs/lab4/bloques_mul.png" alt="alt text" width=390 >
</p>


### 4.1 Funcionamiento

El módulo multiplicador realiza la multiplicación de dos números de 3 bits cada uno (```MR``` y ```MD```) de forma **secuencial**, donde los productos parciales se suman y desplazan a lo largo de varios ciclos de reloj. El resultado final se almacena en ```pp``` (producto parcial de 6 bits) y la señal ```done``` indica que la multiplicación finalizó.

 La multiplicación secuencial implica que el módulo procesa los bits de los operandos uno a uno, acumulando los productos parciales y desplazándolos hasta obtener el resultado final. Cada ciclo de reloj corresponde a una operación específica, como sumar un producto parcial o desplazar los registros involucrados.

 A continuación podrán encontrar el diagrama de flujo del multiplicador:

 <p align="center">
 <img src="../figs/lab4/flujo_mult.jpeg" alt="alt text" width=330 >
</p>

### Unidad de Control del bloque multplicador: Máquina de estados

 <p align="center">
 <img src="../figs/lab4/FSM_mult.jpeg" alt="alt text" width=410 >
</p>


## 5. Entregables

1. Comprenda cada línea del código HDL de cada archivo que se encuentra en la carpera [src](./src) y comente si es necesario en su respectivo archivo ```README.md```.

2. Realice cada uno de los pasos descritos en [Procedimiento](#3-procedimiento) y muestre las respectivas evidencias en clase.

3. Adjunte las evidencias en su respectivo repositorio en Github classroom.

<!-- 
## Registros y Señales Internas

* Registros:
    * ```sh```: Controla si los registros A y B se desplazan.
        
    * ```rst```: Resetea los registros A y B.
        
    * ```add```: Controla si se suma el producto parcial al acumulador pp.
        
    * ```A```: Registro de 6 bits para almacenar el multiplicador desplazado.
        
    * ```B```: Registro de 3 bits para almacenar el multiplicando desplazado.
        
    * ```status```: Almacena el estado actual de la FSM.
   
* Señal interna:
        
    * ```z```: Indicador de que B ha llegado a 0, lo que señala el fin de la multiplicación.

### Máquina de Estados Finita

La FSM tiene cinco estados:

* ```START```: Inicializa las señales y espera que ```init``` sea activa para comenzar la multiplicación.

* ```CHECK```: Verifica el bit menos significativo de ```B```. Si es 1, procede  a la suma (estado ```ADD```), si no, pasa directamente al desplazamiento (estado ```SHIFT```).

* ```ADD```: Suma el valor de A al producto parcial pp si el bit menos significativo de ```B``` es *1*.

* ```SHIFT```: Desplaza ```A``` y ```B``` para procesar el siguiente bit del multiplicando. Si ```B``` ha alcanzado *0* (```z``` *== 1*), la FSM pasa al estado ```END1```.

* ```END1```: Señala que la multiplicación ha terminado, activando ```done```, y vuelve al estado ```START```.

### Funcionamiento

* **Inicialización**: Cuando init es activa, la FSM se mueve de ```START``` a ```CHECK```, iniciando la multiplicación.

* **Suma condicional**: Si el bit menos significativo de ```B``` es 1, se añade ```A``` al acumulador ```pp```.

* **Desplazamiento**: Después de la suma (o si el bit es 0), los registros ```A``` y ```B``` se desplazan.

* **Finalización**: Cuando ```B``` llega a 0, la FSM indica que la multiplicación ha finalizado y mantiene el resultado en ```pp```. -->