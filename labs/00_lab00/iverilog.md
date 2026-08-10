# Instalación de Icarus-Verilog


## En Windows:

1. Descargar el instalador de Icarus Verilog en https://bleyer.org/icarus/: 

2. Ejecute el instalador ```exe``` que se descargó en el ítem anterior. Se abrirá el instalador y se debe tener en cuenta lo siguiente:

  * En ```Select Components```seleccionar lo siguiente:

    ![download_quartus](/labs/figs/lab0/iverilog2.PNG)

  * En ```Select Additional Tasks```seleccionar lo siguiente cerciorarse de que la casilla ```Add executable folder(s) to the user PATH```:

    ![download_quartus](/labs/figs/lab0/iverilog1.PNG)





## En linux:
Actualice la lista de paquetes de Linux, luego instale Icarus Verilog como se muestra:

```
sudo apt update
```

```
sudo apt install iverilog
```

Para comprobar la instalación basta con ejecutar el siguiente comando para verificar la versión instalada:

```
iverilog -v
```


# Instalación de GTKWave

GTKWave es un visor de formas de onda que funciona con Icarus Verilog para mostrar los resultados de la simulación. Está convenientemente disponible en la lista de paquetes apt de Ubuntu, por lo tanto es posible usar el comando ```apt install``` de nuevo:


```
sudo apt install gtkwave
```

Para verificar la instalación basta con ejecutar el comando ```gtkwave``` en la terminal y deberá ejecutarse el programa.