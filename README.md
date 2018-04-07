# TFG
Trabajo de Fin de Grado. Grado en Física. Carlos Molina

## Layout de un canal de lectura multi-paralelizado para un sensor de imagen CMOS

Este proyecto contiene mi trabajo de fin de grado para el Grado en Física por la Universidad de Sevilla, 
que voy a presentar en Julio de 2018.

### Descripción del trabajo

El trabajo consiste en un estudio sobre los problemas y puntos a tener en cuenta en el diseño
del layout de un canal de lectura de un sensor de imagen CMOS.

El canal de lectura es un bloque analógico que todo sensor de imagen debe tener con objeto de leer el 
voltage proporcionado por el pixel y que representa la cantidad de luz recibida durante un tiempo de exposición.
El canal de lectura se encarga de amplificar y convertir a un valor analógico.

Uno de los métodos usados habitualmente es la comparación del valor analógico dado por el pixel con un valor
ascendente dado por una rampa (comparador de rampa). Tras la comparación, el canal de lectura lanza una señal
temporal que indica en qué momento han coincidido los dos valores y se lo transmite a un circuito digital
que en ese preciso momento detiene un contador digital, cuyo valor representará el valor digital que se ha leído del píxel.

El trabajo se centra en el diseño del layout de este bloque. Ésta tarea engloba varios retos tecnológicos que, en 
ocasiones, lo convierten en uno de los bloques del sensor que más complejidad tiene en su layout. Para empezar,
el area está limitada porque el tamaño del pixel es límitado, y el canal debe acogerse a su tamaño o algún
múltiplo de él, si usamos paralelización. Por ejemplo, pueden usarse 2 o 4 canales en paralelo.

Por otro lado, en tan poco espacio, se tratan señales analógicas que comutan en momentos críticos y que pueden perturbarse
entre distintos canales, lo que puede producir interferencias y acoplos entre canales, lo que tendría un efecto directo en 
imágen final obtenida. Ésto se ve propiciado, además, porque las líneas de transmisión van a tener que recorrer una
gran distancia en vertical separadas pocas micras en horizontal, lo que aumenta el acoplo entre ellas.

Por otro lado el diseño deberá incluir algunos condensadores por la propia arquitectura de los comparadores, y son
condensadores grandes, que deben instanciarse en la limitada area.

Al tratarse de un bloque grande con muchos comparadores, su consumo suele ser alto, por lo que es importante afrontar
correctamente el asunto de la alimentación, ya que una mala alimentación puede crear gradientes en el funcionamiento de
cada canal, lo que resultaría en imágenes con características diferentes en diferentes zonas.


