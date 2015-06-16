MarquetNet

Inspirado en el trabajo de: https://github.com/carlhako/ESP8266-Wireless-Sensors

Red de Nodos con ESP8266-ESP01

Usamos ESP8266-ESP01, Node.JS, LUA y MySQL. El servidor de Node-JS por el momento corre en Windows 7 pero se va a establecer con Linux. Raspberry?

La idea es crear una red de nodos los cuales reciben señales de varios sensores. Al conectarse a la red el nodo puede estar en tres modos:

1) Modo Configuracion
2) Modo Comunicacion
3) Modo Dssleep.

La primera vez que se intenta conectar a la red al nodo debe oprimirsele el botón CONFIG para que entre en modo de configuración. La base de datos en MySQL debe tener los datos de los nodos y al conectarse un nuevo nodo este envia sus datos (node.info) que son comparados con la base de datos. Si el nodo pertenece a esta red el software en LUA sigue leyendo el estado de los sensores y lo transmite.

El servidor de node.js mantendrá la configuración de los nodos y su estado. Está contenido en Windows 7. Proximamente se hará en Ubuntu y la idea es hacerlo con Raspberry.

Los nodos simplemente transmitirán su INFO y leeran los sensores cada vez que detecten un cambio en el valor de ellos.

Los nodos serán diseñados con ESP8266-ESP01 -por ahora-(-Tengo ESP-07 pero no he conseguido las antenas. Si usted lector sabe como puedo diseñar/comprar las antenas le agradecería la información-). Serán programados en LUA.

La base de datos, por ahora será en MySQL.
