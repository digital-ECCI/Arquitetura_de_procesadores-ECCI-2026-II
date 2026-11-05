# Lab05: Set de instrucciones y unidad de control

### Contenido:

1. [Objetivos de aprendizaje](#1-objetivos-de-aprendizaje)
2. [Fundamento teórico](#2-fundamento-teórico)
3. [Diseño propuesto](#3-diseño-propuesto)
4. [Procedimiento](#4-procedimiento)
5. [Entregables](#5-entregables)

## 1. Objetivos de aprendizaje

- Comprender qué es un **set de instrucciones (ISA)** y su papel como "contrato" entre el software y la microarquitectura de un procesador.
- Diseñar un conjunto reducido de instrucciones que operen sobre el **banco de registros** y la **ALU** construidos en laboratorios anteriores.
- Diseñar e implementar una **unidad de control** que busque, decodifique y ejecute instrucciones, generando las señales que gobiernan el *datapath*.
- Integrar en un único sistema los módulos ya desarrollados (banco de registros, ALU, multiplicador, divisor y UART) bajo el mando de la unidad de control.
- Ejecutar un pequeño **programa** sobre la FPGA y verificar su resultado.

## 2. Fundamento teórico

### 2.1 Set de instrucciones (ISA)

El *Instruction Set Architecture* es el conjunto de instrucciones que un procesador es capaz de ejecutar. Define, entre otras cosas, qué operaciones existen, cuántos registros hay y cómo se codifica cada instrucción en bits. Es la frontera entre **qué** se quiere hacer (el programa) y **cómo** lo ejecuta el *hardware* (el *datapath* y la unidad de control).

Cada instrucción es una palabra binaria dividida en **campos**. El campo principal es el **código de operación (opcode)**, que indica qué hacer; los demás campos indican sobre qué datos operar (direcciones de registro, una constante inmediata, etc.).

### 2.2 Formato de instrucción

En este laboratorio se trabajará con instrucciones de **ancho fijo**, lo que simplifica la decodificación. Se proponen dos formatos:

- **Tipo R (registro-registro):** operaciones de la ALU entre dos registros fuente, con el resultado en un registro destino.
- **Tipo I (inmediato):** cargan una constante o trabajan con un valor embebido en la instrucción.

### 2.3 Unidad de control

La unidad de control (UC) es el bloque que **decide qué hacer y cuándo**, mientras que el *datapath* es el que **ejecuta**. Es exactamente la misma separación control/camino de datos que ya se aplicó en el multiplicador y el divisor secuenciales: aquí simplemente se lleva a la escala de un procesador.

La UC se modela como una **máquina de estados** que recorre el ciclo clásico:

- **Fetch (búsqueda):** lee de la memoria de instrucciones la instrucción apuntada por el contador de programa (PC) y luego incrementa el PC.
- **Decode (decodificación):** separa los campos de la instrucción (opcode, registros, inmediato) y lee del banco de registros los operandos.
- **Execute (ejecución):** ordena a la ALU (o al módulo correspondiente) realizar la operación.
- **Writeback (escritura):** guarda el resultado en el registro destino.

Un punto clave de integración: algunas operaciones de la ALU son **combinacionales** (suma, resta, lógicas) y terminan en un ciclo, pero **multiplicación y división son secuenciales** (tienen su propia FSM y una señal `done`). Por lo tanto, la unidad de control debe **sincronizarse** con esos submódulos mediante un *handshake* `start`/`done`: lanza la operación, **espera** a que `done` se active, y solo entonces continúa. Es el mismo protocolo que ya conocen del `start`/`done` del multiplicador y el divisor.

### 2.4 Datapath integrado

El *datapath* conecta los bloques que ya se tienen. La unidad de control genera las señales que los coordinan:

- **Banco de registros** ← direcciones de lectura/escritura y `we` (desde los campos de la instrucción).
- **ALU** ← selector de operación (`alu_sel`), derivado del opcode.
- **Multiplicador / divisor** ← señales `start`, y entregan `done` de vuelta a la UC.
- **UART** ← `start` de transmisión para enviar datos al exterior.
- **Multiplexor de escritura** ← selecciona qué fuente se escribe en el registro destino (resultado de la ALU, inmediato, o resultado de mult/div).

## 3. Diseño propuesto

> Los anchos y la cantidad de instrucciones son una **propuesta base**; cada grupo puede ajustarlos justificando su decisión.

**Parámetros base:**

- Instrucción de **16 bits**.
- **8 registros** de propósito general (`R0`–`R7`), direccionables con 3 bits. Se sugiere que `R0` esté cableado a 0 (convención RISC).
- Datos de **8 bits** (coherente con el banco de registros del Lab 05).

**Formatos:**

```
Tipo R:   | opcode (4) | rd (3) | rs (3) | rt (3) | --- (3) |
Tipo I:   | opcode (4) | rd (3) |        inmediato (9)       |
```

**Set de instrucciones propuesto:**

| opcode | Mnemónico | Tipo | Operación |
|:------:|:----------|:----:|:----------|
| 0000 | `ADD`  | R | `rd = rs + rt` |
| 0001 | `SUB`  | R | `rd = rs - rt` |
| 0010 | `AND`  | R | `rd = rs & rt` |
| 0011 | `OR`   | R | `rd = rs \| rt` |
| 0100 | `XOR`  | R | `rd = rs ^ rt` |
| 0101 | `CMP`  | R | compara `rs` y `rt` (actualiza banderas) |
| 0110 | `MUL`  | R | `rd = rs * rt`  (usa el multiplicador secuencial) |
| 0111 | `DIV`  | R | `rd = rs / rt`  (usa el divisor secuencial) |
| 1000 | `LI`   | I | `rd = inmediato`  (cargar constante) |
| 1001 | `MOV`  | R | `rd = rs` |
| 1010 | `OUT`  | R | transmite `rs` por UART |
| 1111 | `HALT` | — | detiene la ejecución |

Se sugiere que los bits del opcode de las operaciones aritmético-lógicas coincidan con el selector `alu_sel` de la ALU del Lab 05, para que la decodificación de esas instrucciones sea casi directa.

**Programa de ejemplo** (para probar la integración): calcular `(5 + 3) * 5` y enviarlo por UART.

```
LI   R1, 5      ; R1 = 5
LI   R2, 3      ; R2 = 3
ADD  R3, R1, R2 ; R3 = 8
MUL  R4, R3, R1 ; R4 = 40   (ejercita el handshake start/done)
OUT  R4         ; envía 40 por UART
HALT
```

## 4. Procedimiento

1. **Defina el ISA:** fije el formato de instrucción y complete la tabla de opcodes (puede partir de la propuesta anterior y ajustarla).
2. **Implemente la memoria de instrucciones:** una ROM que contenga el programa de ejemplo (o cárguelo como un arreglo de instrucciones).
3. **Implemente la unidad de control** como una máquina de estados (fetch–decode–execute–writeback) que:
   - Genere las direcciones del banco de registros a partir de los campos de la instrucción.
   - Genere `alu_sel` a partir del opcode.
   - Maneje el *handshake* `start`/`done` para `MUL` y `DIV` (estado de espera).
   - Seleccione la fuente del dato de escritura y active `we` en el momento correcto.
   - Controle la transmisión por UART en `OUT`.
4. **Integre todo en un módulo `top`:** unidad de control + banco de registros + ALU (con multiplicador y divisor) + UART.
5. **Cree el testbench** y realice la simulación funcional, verificando la ejecución completa del programa de ejemplo.
6. Una vez corroborado en simulación, cree el proyecto en la IDE e **implemente en la FPGA MAX 10**, visualizando el resultado en los periféricos disponibles (7 segmentos / LED) y/o por UART en una terminal serial.

## 5. Entregables

1. Diagrama de **caja negra** del procesador (entradas, salidas y buses).
2. Tabla del **set de instrucciones** diseñado y descripción del formato.
3. Diagrama **ASM de la unidad de control** (estados, transiciones y señales de control que activa en cada estado).
4. Descripción completa en **Verilog** de la unidad de control y del módulo `top` integrado.
5. **Testbench** funcional con la evidencia de simulación de la ejecución del programa.
6. **Diagrama RTL** generado por la herramienta.
7. Evidencia de **implementación en la FPGA MAX 10**.
8. Documentación en el `README.md` del repositorio, comentando el HDL de cada archivo.

> **Importante:** No se recibirá la presentación del funcionamiento en la FPGA si antes no se ha presentado la respectiva simulación. La simulación funcional es requisito previo e indispensable para la sustentación en *hardware*.

Entregue el trabajo por medio de GitHub Classroom, subiendo el código fuente, los *testbench* y el `README.md` documentado.