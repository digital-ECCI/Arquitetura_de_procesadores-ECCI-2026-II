# Lab02: Decodificador BCD a 7 segmentos

Contenido:

1. [Objetivos de aprendizaje](#1-objetivos-de-aprendizaje)

2. [Fundamento teórico](#2-fundamento-teórico)

3. [Procedimiento](#3-procedimiento)

4. [Entregables](#4-entregables)


## 1. Objetivos de aprendizaje

1. Diseñar e implementar un controlador para display 7 segmentos teniendo en cuenta el tipo de display (ánodo/cátodo común), la tabla de verdad completa para representación hexadecimal y el respectivo mapeo de pines .

2. Desarrollar la descripción de hardware para convertir números binarios  2 dígitos BCD (unidades y decenas) y 1 bit de signo (0 = positivo, 1 = negativo).

3. Visualizar el resultado de un sumador/restador de $4$ bits en los display $7$ segmentos que vienen en la tarjeta de desarrollo.

## 2. Fundamento teórico

### 2.1 BCD (Binary Coded Decimal): 
-------------------------------

BCD significa Décimal Codificado en Binario y representa el sistema de numeración digital en el que podemos representar cada número décimal utilizando 4 bits de números binarios.


Como sabemos hay 10 dígitos en el sistema décimal, para representarlos necesitamos 10 combinaciones de 4 bits binarios.

<p align="center">

|   Dígito  |   Bit $_3$  |  Bit $_2$ |   Bit $_1$  |   Bit $_0$  |
|-----------|-------------|-----------|-------------|-------------|
|     0     |      0      |     0     |      0      |      0      |
|     1     |      0      |     0     |      0      |      1      |
|     2     |      0      |     0     |      1      |      0      |
|     3     |      0      |     0     |      1      |      1      | 
|     4     |      0      |     1     |      0      |      0      |
|     5     |      0      |     1     |      0      |      1      |
|     6     |      0      |     1     |      1      |      0      |
|     7     |      0      |     1     |      1      |      1      | 
|     8     |      1      |     0     |      0      |      0      | 
|     9     |      1      |     0     |      0      |      1      | 
</p>

Ahora bien, también es posible representar de forma binaria los números décimales del 10 al 15 pero empleando su correspondiente representación en el sistema hexadécimal:

<p align="center">

|   Dígito  |   Bit $_3$  |  Bit $_2$ |   Bit $_1$  |   Bit $_0$  |
|-----------|-------------|-----------|-------------|-------------|
|     A     |      1      |     0     |      1      |      0      |
|     B     |      1      |     0     |      1      |      1      |
|     C     |      1      |     0     |      0      |      0      |
|     D     |      1      |     1     |      0      |      1      | 
|     E     |      1      |     1     |      1      |      0      |
|     F     |      1      |     1     |      1      |      1      |
</p>


### 2.2 Display de 7 segmentos:
-------------------------------


El display de siete segmentos es un dispositivo electrónico que consta de siete diodos emisores de luz (LED) dispuestos en un patrón definido; encender una combinación particular de éstos permite representar un dígito décimal o hexadécimal Existen dos tipos de display LED de siete segmentos:

* Tipo de cátodo común: en este tipo de display, todos los cátodos de los siete LEDs están conectados entre sí a tierra o $-Vcc$ (por lo tanto, cátodo común) y el LED muestra dígitos cuando se suministra un nivel alto a los ánodos individuales.
    
* Tipo de ánodo común: en este tipo de display, todos los ánodos de los siete LEDs están conectados a $+Vcc$ (por lo tanto, ánodo común) y el LED muestra dígitos cuando se suministra un nivel al bajo a los cátodos individuales.


En las siguientes figuras se muestra cómo se distribuyen los 7 segmentos en el display cuando se tiene una configuración de ánodo común:

<p align="center">
 <img src="/labs/figs/lab03/segm.png" alt="alt text" width=500 >
</p>


<p align="center">
 <img src="https://exploreembedded.com/wiki/images/1/1a/0SevenSegment.gif" alt="alt text" width=400 >
</p>

## 3. Procedimiento

### Primera parte: Diseño BCD a 7seg

Realizar el diseño, sintentización e implementación del display de $7$ segmentos, que permita visualizar números en representación hexadécimal en uno de los displays de la tarjeta de desarrollo. 


Pasos a seguir:

1. Definir el bloque funcional del diseño:

    <p align="center">
        <img src="/labs/figs/lab03/Sseg.png" alt="alt text" width=350 >
    </p>


    Como se evidencia, el bloque tiene un puerto de entrada  llamado ```BCD``` de 4 bits y un puerto de salida llamado ```Sseg``` de 7 bits, lo que concuerda con lo mencionado anteriormente.

2.  Definir la descripción funcional del diseño: Tablas de verdad.

3. Describir usando HDL el comportamiento del diseño. 

4. Simular el diseño: Implemente un *testbench* para este fin. 

5. Implementación: en la tarjeta correspondiente implemente y valide el funcionamiento.

### Segunda parte: Visualización dinámica en 3 displays de 7 segmentos

Realizar la integración  del módulo implementado en el ítem anterior con el sumador/restador del [lab02](/labs/02_lab02/README.md), siguiento los mismo pasos descritos anteriormente. A continuación se muestra el bloque funcional que deben implementar:


<p align="center">
        <img src="/labs/figs/lab03/all.png" alt="alt text" width=750 >
    </p>


#### Algoritmo double dabble

El algoritmo Double Dabble (shift-and-add-3) es un método para convertir números binarios a su representación en BCD (Binary Coded Decimal) usando únicamente desplazamientos y sumas simples.

#### ¿Qué es?

El algoritmo **Double Dabble** convierte un número binario a su representación en BCD sin usar divisiones ni multiplicaciones. Es ampliamente usado en hardware digital (FPGAs, displays de 7 segmentos, microcontroladores) por su eficiencia en circuitos lógicos.

#### Regla fundamental

Antes de cada desplazamiento a la izquierda, se revisa cada grupo de 4 bits del registro BCD:

> **Si algún nibble (grupo de 4 bits) ≥ 5 → sumarle 3 antes de desplazar.**

Esto se hace porque sumar 3 antes del shift equivale a sumar 6 después, produciendo el acarreo correcto al siguiente dígito decimal (ya que BCD codifica cada dígito del 0 al 9 en 4 bits).


---

## Pasos del algoritmo

1. Inicializar el registro BCD en `0`.
2. Para cada bit del número binario (del más al menos significativo):
   - **Verificar** cada grupo de 4 bits del registro BCD.
   - Si algún grupo ≥ 5, **sumarle 3**.
   - **Desplazar** todo el registro un bit a la izquierda, introduciendo el siguiente bit del número original.
3. Repetir hasta procesar todos los bits.
4. Los grupos de 4 bits del registro contienen los **dígitos decimales** del resultado.


---

## Ejemplo paso a paso: `1110₂ = 14₁₀`

El número tiene 4 bits, por lo que se necesitan **4 iteraciones**.  
El registro BCD tiene 2 grupos: `[Decenas | Unidades]`

```
Inicio:       BCD = 0000 | 0000      Binario restante: 1 1 1 0
```

### Iteración 1 — bit entrante: `1`

```
Verificar:    0000 = 0  →  sin cambio
              0000 = 0  →  sin cambio
Desplazar ←: 0000 | 0001      (entra el bit 1)
```

### Iteración 2 — bit entrante: `1`

```
Verificar:    0000 = 0  →  sin cambio
              0001 = 1  →  sin cambio
Desplazar ←: 0000 | 0011      (entra el bit 1)
```

### Iteración 3 — bit entrante: `1`

```
Verificar:    0000 = 0  →  sin cambio
              0011 = 3  →  sin cambio
Desplazar ←: 0000 | 0111      (entra el bit 0)
```

### Iteración 4 — bit entrante: `0`

```
Verificar:    0000 = 0  →  sin cambio
              0111 = 7  ≥ 5  →  +3  →  0111 + 0011 = 1010
Desplazar ←: 0001 | 0100      (entra el bit 1)
```

### Resultado

```
Registro BCD final:  0001 | 0100
                      ↓       ↓
Dígito decimal:       1       4    →   14 ✓
```

---

## Tabla resumen

| Paso | Acción | Decenas (nibble) | Unidades (nibble) | Bit entrante |
|------|--------|:-----------------:|:-----------------:|:------------:|
| Inicio | Init | `0000` (0) | `0000` (0) | — |
| Iter 1 | ← shift | `0000` (0) | `0001` (1) | 1 |
| Iter 2 | ← shift | `0000` (0) | `0011` (3) | 1 |
| Iter 3 | ← shift | `0000` (0) | `0110` (6) | 0 |
| Iter 4 | **+3** en unidades, ← shift | `0001` (1) | `0011` (3) | 1 |

---

## Ejemplo adicional: `10111001₂ = 185₁₀`

8 bits → 8 iteraciones. Registro BCD con 3 grupos: `[Centenas | Decenas | Unidades]`

| Paso | Acción | Centenas | Decenas | Unidades | Bit |
|------|--------|:--------:|:-------:|:--------:|:---:|
| Inicio | Init | 0000 | 0000 | 0000 | — |
| Iter 1 | ← shift | 0000 | 0000 | 0001 | 1 |
| Iter 2 | ← shift | 0000 | 0000 | 0010 | 0 |
| Iter 3 | ← shift | 0000 | 0000 | 0101 | 1 |
| Iter 4 | **+3** unid, ← shift | 0000 | 0001 | 0000 | 1 |
| Iter 5 | ← shift | 0000 | 0010 | 0001 | 1 |
| Iter 6 | ← shift | 0000 | 0100 | 0010 | 0 |
| Iter 7 | ← shift | 0000 | 1000 | 0101 | 0 |
| Iter 8 | **+3** unid, ← shift | 0001 | 1000 | 0101 → **+3** → 1000 → shift | 1 |

```
Resultado:  0001 | 1000 | 0101
              1      8      5   →  185 ✓
```

---



## 4. Entregables

1. Descripción de hardware del sumador/restador.

2. Documentación del ítem anterior en su respectivo archivo ```README.md```.

3. Realice la respectiva simulaciones y muestre evidencias en su archivo ```README.md```.

4. Implemente la descripción HDL en la tarjeta de desarrollo, empleando la ```IDE Quartus``` y muestre en el laboratorio el funcionamiento, empleando los periféricos que requiera.

