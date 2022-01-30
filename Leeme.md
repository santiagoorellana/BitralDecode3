
BitralDecode (Procesador de demodulaciones):

Introducción:
Cuando se demodula una señal mediante software, el resultado final puede ser una cadena de símbolos que porta en su interior el mensaje trasmitido, usualmente encriptado, y otros datos necesarios para la sincronización y corrección de errores. Cuando se conoce la codificación y el protocolo que emplean el trasmisor y el receptor, es fácil saber donde se encuentra el mensaje y qué hacer para recuperarlo; pero no es así cuando la señal es desconocida. Mediante el análisis de la señal, se puede conocer el tipo de modulación que emplea y demodula correctamente la señal, pero se hace necesario realizar un estudio de la estructura de esta. La herramienta BitralDecode facilita el análisis y procesamiento de la cadena de símbolos resultantes de la demodulación.

Breve descripción de la herramienta:
BitralDecode es una aplicación MDI que le permite al usuario trabajar con varias demodulaciones a la vez. Las herramientas que emplea son implementadas como subprocesos apartes, por lo que permiten al usuario continuar trabajando con la aplicación mientras se ejecuta la herramienta. 

La aplicación le permite al usuario entre otras cosas:
-  Ver el raster de la demodulación tanto en colores como en escala de gris.
- Editar la demodulación por medio de la interacción gráfica con el raster.
- Buscar automáticamente los posibles períodos de la demodulación, así como cualquier otro tipo de estructura cíclica.
- Buscar las ocurrencias de una cadena dentro de la demodulación.
- Señalar los ficheros de una carpeta dada, que contengan al menos una ocurrencia de una cadena específica.
- Comparar dos demodulaciones y ver el resultado gráficamente, revelándose así las estructuras comunes a ambas.

Carga y edición de una demodulación.
Mediante un simple diálogo, se le permite al usuario seleccionar el fichero que contiene la cadena de caracteres resultantes de la demodulación. Una vez cargado el fichero, el programa busca automáticamente las repeticiones periódicas de subcadenas que ocurren dentro de la demodulación. Al finalizar la búsqueda, se le presenta al usuario una lista de las repeticiones periódicas encontradas y una matriz en colores de los datos de la demodulación. A esta matriz la llamaremos raster de la demodulación y se puede mostrar también en escala de griz.

Basta con seleccionar uno de los períodos de la lista para que el raster de la demodulación se muestre con dicho período. Al encontrar el período correcto, el raster revela algunas estructuras interesantes de la señal demodulada.Lo mismo se puede hacer con las demodulaciones de más de dos símbolos. 

Si el usuario desea editar las demodulaciones, sólo debe activar la pestaña de Editor de Texto o Editor de Raster. Inmediatamente el raster se mostrará en modo de edición. Una vez activado el modo de edición, el usuario podrá hacer uso de los métodos de edición de la barra de herramientas de la ventana. Podrá entre otras cosas:

- Seleccionar líneas o bloques.
- Borrar la selección.
- Cortar la selección.
- Copiar la selección.
- Rellenar la selección con un valor dado.
- Pegar una selección copiada o cortada en una posición dada.
- Insertar datos de forma serial en un punto dado del raster.
- Filtrar para eliminar los caracteres que no pertenecen al conjunto de símbolos permitidos.

Si el usuario comete errores, podrá deshacer los cambios en orden según los fue realizando. Al quedar satisfecho con la edición, podrá guardar los cambios en el fichero original o en uno nuevo.

Búsqueda automática de períodos.
Para la búsqueda avanzada de las repeticiones periódicas de la demodulación, se puede emplear una herramienta que implementa algunos algoritmos de detección de patrones. Una vez que se detectan las periodicidades, estas se muestran en una lista, ordenadas según su importancia. 

Comparación de demodulaciones.
Otras herramientas que brinda la aplicación son los comparadores. Estos se emplean para comparar dos demodulaciones, revelando así sus diferencias o estructuras comunes.

El comparador Diff utiliza un algoritmo muy empleado en el análisis de las cadenas de ADN y otras proteínas complejas. Emplea conceptos de programación dinámica por lo que es muy eficiente en velocidad y clasifica las diferencias según un modelo matemático de los tipos de errores posibles (Borrados, Inserciones, Reemplazos).

Otro comparador es el Most, creado por los autores, el cual busca las más grandes similitudes existentes entre dos demodulaciones. El modelo matemático de error que emplea este comparador es diferente al del comparador Diff y se acerca más a nuestras necesidades.

Ambos comparadores muestran sus resultados mediante gráficos que permiten observar las estructuras de semejanza entre las demodulaciones comparadas.

Búsqueda de cadenas.
Contamos además con una herramienta de búsquedas de cadenas. Esta busca la aparición de una cadena dada en todos los ficheros de demodulación contenidos en la carpeta indicada. 

Próximos desarrollos
La aplicación BitralDecode en su versión 4 tratará de dar solución a otros problemas más complejos relacionados con la decodificación y corrección de errores. 
Además se incluirán otras herramientas de comparación y de revelación de estructuras internas, así como facilidades para mapear las demodulaciones por secciones, insertar comentarios, marcas y finalmente facilitar la creación de informes de forma semiautomática.

Designer and programmer: Santago A. Orellana Pérez
Email: tecnochago@gmail.com
Móvil: +53 54635944
La Habana, Cuba, 2012
