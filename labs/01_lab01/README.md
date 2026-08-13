# Lab 01: Sumador de 1 bit y sumador de 4 bits

Contenido:

- [Lab 01: Sumador de 1 bit y sumador de 4 bits](#lab-01-sumador-de-1-bit-y-sumador-de-4-bits)
  - [1. Objetivos de aprendizaje](#1-objetivos-de-aprendizaje)
  - [2. Fundamento teórico](#2-fundamento-teórico)
    - [2.1 Parte 1: Sumador de 1 bit](#21-parte-1-sumador-de-1-bit)
      - [Implementación en HDL](#implementación-en-hdl)
    - [2.2 Parte 2: Sumador de 4 bits](#22-parte-2-sumador-de-4-bits)
      - [Funcionamiento](#funcionamiento)
      - [Implementación en HDL](#implementación-en-hdl-1)
  - [2.3 Parte 3: Sumador/restador de 4 bits](#23-parte-3-sumadorrestador-de-4-bits)
    - [2.3.1 Fundamento teórico](#231-fundamento-teórico)
      - [Operación complemento a 2.](#operación-complemento-a-2)
        - [Ejemplo:](#ejemplo)
      - [¿Cómo se ve el complemento a 2 a nivel de circuito?](#cómo-se-ve-el-complemento-a-2-a-nivel-de-circuito)
  - [3. Entregables](#3-entregables)



## 1. Objetivos de aprendizaje

- Diseñar y construir sistemas digitales basados en lógica combinacional, enfocándose en la implementación de sumadores.
- Diseñar, construir e instanciar módulos utilizando lenguajes de descripción de *hardware* (HDL)
- Familiarizarse con el flujo completo de diseño e implementación en *hardware*, desde la especificación inicial hasta la síntesis e implementación en FPGA.
- Aprender a verificar y validar el funcionamiento del diseño en un entorno de simulación, identificando y corrigiendo errores antes de la implementación física en *hardware*.
- Explorar la implementación de diseños digitales en tarjeta de desearrollo basadas en FPGAs.

## 2. Fundamento teórico

### 2.1 Parte 1: Sumador de 1 bit

En diseño digital, un sumador de 1 bit es un circuito combinacional que realiza la suma de dos bits junto con un bit de acarreo de entrada. Es uno de los bloques fundamentales en la construcción de sumadores de mayor tamaño, que son esenciales en operaciones aritméticas dentro de procesadores y sistemas digitales. También se conoce como sumador completo.  A continuación se muestra su respectivo bloque funcional:

<p align="center">
 <img src="/labs/figs/lab1/1bit.png" alt="alt text" width=300 >
</p>
<p align="center">
 Figura 1
</p>

El sumador de 1 bit toma tres entradas: los dos bits que se desean sumar (```A``` y ```B```) y un bit de acarreo de entrada (```Ci```) que puede provenir de una posición menos significativa en un sumador más grande. El circuito produce dos salidas: el bit de suma (```So```) y el bit de acarreo de salida (```Co```).


A continuación se presenta la tabla de verdad del sumador completo de 1 bit.

<p align="center">

|   A  |   B  |  Ci |   Co  |   So  |
|------|------|-----|-------|-------|
|   0  |   0  |  0  | **0** | **0** |
|   0  |   0  |  1  | **0** | **1** |
|   0  |   1  |  0  | **0** | **1** |
|   0  |   1  |  1  | **1** | **0** | 
|   1  |   0  |  0  | **0** | **1** |
|   1  |   0  |  1  | **1** | **0** |
|   1  |   1  |  0  | **1** | **0** |
|   1  |   1  |  1  | **1** | **1** | 
</p>


A partir de la tabla de verdad, mediante **mapas de Karnaugh**, se obtienen las expresiones que definen el sumador de 1 bit, las cuales son:

<p align="center">
<img src="/labs/figs/lab1/karnaugh.png" alt="alt text" width=800 >
</p>

A partir de las expresiones obtenidas se puede construir el siguiente circuito:

<p align="center">
<img src="/labs/figs/lab1/Circuito_sumador.png" alt="alt text" width=600 >
</p>
<p align="center">
 Figura 2
</p>

#### Implementación en HDL

En la descripción de *hardware*, los sumadores de 1 bit pueden implementarse utilizando diferentes enfoques, según el nivel de abstracción deseado.

  * **Implementación estructural**:

    Se definen explícitamente los componentes individuales (AND, OR, XOR) necesarios para calcular la salida de suma (```So```) y el acarreo (```Co```) según las ecuaciones lógicas obtenidas de la tabla de verdad. Esto se puede realizar de dos formas:

    1. Usando operadores lógicos

        * Descripción: Los operadores lógicos son símbolos o funciones que representan operaciones lógicas sobre las señales. En HDL, estos operadores se usan para crear expresiones que definen cómo las señales de entrada se combinan para obtener una salida. Los operadores lógicos más comunes incluyen AND (```&```), OR (```|```), NOT (```~```), XOR (```^```), etc.

        * Ejemplo:
        
          ```
          assign salida = A & B;  // Operador AND
          ```

        * Características:
        Son más abstractos y concisos.
        Se usan dentro de las expresiones lógicas para realizar combinaciones entre señales.
        Pueden operar sobre señales o vectores de bits.
        No están ligados a ninguna implementación física específica. El sintetizador de hardware es el que decide cómo implementarlos en puertas lógicas (AND, OR, etc.) en función de la optimización.

    2. Usando primitivas

        * Descripción: Las primitivas son elementos de hardware básicos predefinidos en un lenguaje de descripción de hardware (HDL). Estos pueden ser puertas lógicas (como AND, OR, NOT), flip-flops, multiplexores, entre otros. En lugar de escribir operaciones lógicas en forma de expresiones, se utilizan estos bloques como componentes predefinidos y directos de un diseño.

        * Ejemplo:

          ```
          and (salida, A, B);  // Primitiva AND
          ```


        * Características:

          Las primitivas son más cercanas al hardware real, pues cada primitiva corresponde a un bloque o componente físico específico.
          Permiten una descripción explícita del diseño usando componentes predefinidos (puertas, registros, etc.).
          En muchos HDL (como Verilog), las primitivas están predefinidas en la biblioteca y pueden ser más eficientes para la síntesis, ya que el sintetizador ya sabe cómo mapearlas a los recursos del hardware físico.


### 2.2 Parte 2: Sumador de 4 bits


Para crear un sumador de 4 bits, se utilizan cuatro sumadores de 1 bit conectados en serie. Así, el acarreo de salida de un sumador de 1 bit se convierte en el acarreo de entrada del siguiente sumador. Cada bit de los dos números que se están sumando se procesa de manera paralela. 

Para construir un sumador de 4 bits utilizando el sumador de 1 bit como módulo base, se debe **instanciar** varios módulos del sumador de 1 bit y conectar sus entradas y salidas de manera que manejen el acarreo entre cada bit.

Un sumador de 4 bits suma dos números de 4 bits (```[3:0] A``` y ```[3:0] B```) y produce una suma de 4 bits (```[3:0] So```) y un acarreo de salida (```Co```). Para lograr esto, se utilizan 4 sumadores de 1 bit, cada uno manejando una posición de la salida ```So``` (0 a 3) y el acarreo hacia la siguiente posición.  A continuación se muestra su respectivo bloque funcional:

![fpga](/labs/figs/lab1/4bit.png)
<p align="center">
 Figura 3
</p>


La implementación del sumador de 4 bits utilizando instancias del sumador de 1 bit es un ejemplo de diseño estructural en HDL, en donde se utiliza el sumador de 1 bit para construir un sumador de 4 bits de manera modular.

#### Funcionamiento

* Cada instancia del sumador de 1 bit toma 1 bits de las entradas ```A``` y ```B```, y un acarreo de entrada Ci. Calcula la suma de estos bits y produce una suma de un bit ```So``` y un acarreo de salida ```Co```.

* El acarreo de salida de un sumador de 1 bit se usa como acarreo de entrada para el siguiente sumador de 1 bit en la cadena.

* El sumador de 4 bits produce una salida final ```So``` de 4 bits y un acarreo de salida final ```Co```.

#### Implementación en HDL

1. **Concepto de instancia**

    En el contexto de diseño digital y descripción HDL, una instancia se refiere a la creación de un módulo a partir de una definición previamente definida. Instanciar un módulo significa utilizar el módulo definido anteriormente como un bloque en un diseño más grande, proporcionando conexiones específicas para las entradas y salidas del módulo.

    En Verilog podemos utilizar la siguiente sintaxis:

    ```
    module_name instance_name(.port_0(signal_0),..,.port_n(signal_n))
    ```


    donde: 

      * ```module_name```: Es el nombre del módulo que queremos instanciar.

      * ```instance_name```: Es el nombre de la instancia que vamos a generar a nivel local.

      * ```port_0``` ... ```port_1```: Representa al nombre del puerto o variable declarada como entrada o salida del módulo que queremos instanciar, es decir, los nombres de los puertos que aparecen en el prototipo de dicho módulo.

      * ```signal_0``` ... ```signal_n```: Corresponde al nombre de las señales que tenemos en el módulo en el cual nos encontramos trabajando y que nos servirán para interactuar con otros del diseño dentro de dicho módulo.


## 2.3 Parte 3: Sumador/restador de 4 bits

### 2.3.1 Fundamento teórico

#### Operación complemento a 2.

En sistemas digitales, las operaciones aritméticas con números negativos requieren una representación eficiente. El complemento a 2 resuelve este problema al permitir:

1. Codificar números positivos y negativos en binario.

2. Convertir restas en sumas, simplificando el diseño de circuitos.

Al aplicar complemento a 2 a un número $B$, la resta $A−B$ se transforma en una suma:

  $$A−B=A+(∼B+1)$$


donde $∼B$ es la inversión bit a bit (complemento a 1) y $+1$ completa la conversión.

En este laboratorio, aprovecharemos esta propiedad para construir un **sumador/restador** de 4 bits reutilizando un sumador existente, añadiendo solo compuertas ```XOR ```y una señal de control (```Sel```). El bit de acarreo final (```Co```) indicará automáticamente si el resultado es positivo o negativo.


El complemento a 2 se cálcula como sigue:   

* ##### Paso 1: Inversión de Bits

    Invertir todos los bits del número. Por ejemplo, si el número binario es $1101_2$​, su inversión de bits será $0010_2$​.


* ##### Paso 2: Paso 1 + 1:

    Se suma 1 al número binario invertido. Continuando con el ejemplo anterior, $0010_2+1 = 0011_2$​.


    El resultado final, $0011_2$​, es el complemento a 2 de $1101_2$​, que representa el número $−3$ en décimal.


##### Ejemplo:

Ejemplo: Se requiere calcular $7−5$.

1. Se debe convertir el número $5$ en $-5$ usando estos pasos:

    * **Paso 1**: Invertir los bits de $5$ (complemento a 1):

        $$0101→1010$$

    * **Paso 2**: Sumar $1$ al resultado (complemento a 2):

        $$1010+1=1011 \rightarrow$$ Esto representa un $-5$.

    * Ahora se debe sumar en lugar de restar:

        $$0111_2 (7) +1011_2 (−5) = 10010_2$$ 
    
    * Sin tener en cuenta el bit de acarreo, es decir, el ```MSB```: $$0010_2=2$$.

 #### ¿Cómo se ve el complemento a 2 a nivel de circuito?

1. Compuertas ```XOR```:

    * Cuando ```Sel = 1```, actúan como un interruptor que invierte los bits de $B$ (Paso 1).

    * Si ```Sel = 0```, dejan pasar $B$ sin cambios (para suma).

2. El bit ```Sel``` hace dos cosas:

    * Controla las ```XOR``` (Paso 1).

    * Se conecta al acarreo inicial (```Cin```) para sumar el $1$ del Paso 2.

3. El resultado final:

    * Si el acarreo final (```Co```) es $1$: El resultado es positivo (como el 2 del ejemplo).

    * Si es $0$: El resultado es negativo (está en  complemento a $2$).

        Ejemplo: $3−7=1100$ → $-4$ en complemento a $2$.

A continuación se muestra el circuito del complemento a $2$:

<p align="center">
 <img src="/labs/figs/lab2/Restador.png" alt="alt text" width=700 >
</p>

Para realizar la operación de resta, el circuito presenta el siguiente comportamiento: 

1. **Complemento a 1**: Al fijar la entrada ```Sel = 1```, las compuertas ```XOR``` invierten los bits de ```B``` (el sustraendo de la operación) obteniendo así el complemento a 1 de la entrada ```B```. 

2. **Complemento a 2**: Cuando ```Sel = 1```, también sucede que el acarreo de entrada del primer sumador de 1 bit es 1, lo que conlleva a que se sume el complemento a 1  de ```B```en su con 1 lo que representa el complemento a 2.

3. **Resultado final**: El circuito adicionalmente suma ```A``` (el minuendo de la operación) con el complemento a 2 de ```B```, obtenido en el paso anterior, representando la operación  $A−B$. Al igual que en la suma, el acarreo de salida se propaga de un bloque a otro.

Cuando la entrada ```Sel = 0``` la salida de las compuertas ```XOR``` es simplemente la misma entrada ```B```, por lo tanto se ejecuta la operación de suma $A+B$.


## 3. Entregables

1. Realice la descripción de hardware en Verilog de las tres partes del laboratorio: el sumador de 1 bit (Parte 1), el sumador de 4 bits construido de forma estructural instanciando el módulo de 1 bit (Parte 2) y el sumador/restador de 4 bits (Parte 3).

2. Elabore un testbench para cada módulo y realice la simulación funcional correspondiente. Verifique que los resultados coincidan con las tablas de verdad y las operaciones esperadas.

3. Documenten todo el proceso en el archivo README.md del repositorio, incluyendo: una breve descripción de cada diseño, las decisiones de implementación y las evidencias de simulación (formas de onda y/o salidas de consola).

4. Implemente la descripción HDL en la tarjeta de desarrollo FPGA MAX 10 utilizando la IDE Quartus y presente su funcionamiento en el laboratorio, empleando los periféricos que considere necesarios (interruptores, LED, displays, etc.).

    ```Importante: No se recibirá la presentación del funcionamiento en la FPGA si antes no se ha presentado la respectiva simulación. La simulación funcional es requisito previo e indispensable para la sustentación en hardware.```

5. Entregue el trabajo por medio de GitHub Classroom, asegurándose de subir el código fuente, los testbench y el archivo README.md documentado.




