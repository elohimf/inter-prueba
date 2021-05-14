# Prueba tecnica Backend

## Instalación

El repositorio contiene un Dockerfile el cual puede ser utilizado para correr 
toda la aplicacion. 

Primero se construye la imagen:

```shell
$ docker build -t inter-prueba .
```

La imagen incluye todo lo necesario para correr la aplicacion sin dependencias

```shell
$ docker run -Pd --name inter-prueba inter-prueba
```

Usando `-P` se enlaza a un puerto libre. Para conocerlo se puede ver con:

```shell
$ docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS         PORTS                     NAMES
d836c8f8626f   inter-prueba   "bundle exec thin st…"   45 minutes ago   Up 2 seconds   0.0.0.0:49161->3000/tcp   inter-prueba
```

(Algunos datos pueden variar)

Cuando se corre la aplicación de esta forma, se necesitará acceder al contenedor para revisar archivos o consultar la base de datos.

```shell
$ docker exec -it inter-prueba /bin/sh
/app # 
```

Por supuesto, la aplicación puede correrse de forma tradicional. Para ello, se instalan dependencias y luego se corre el servidor:
```shell
$ bundle install
...
$ bundle exec thin start
```

En este caso el servidor estara disponible en el puerto 3000.

Una vez que la aplicación este ejecutandose, puede interactuarse con la api. Lo mas simple es usar curl:

```shell
$ curl -d @facturas/invoice_example.xml http://0.0.0.0:49161/validarFactura # En el directorio principal, usando la imagen de docker
```

## API

| Endpoint | Resultado |
| -------- | --------- |
| POST /dummy | Solo devuelve el cuerpo del request, para testing |
| POST /validarFactura | Devuelve codigo _200_ si la factura es valida y _450_ si no lo es |
| POST /almacenarFactura | Valida y luego guarda la factura en la base de datos, regresando _200_ al final. Si falla en algún punto, devuelve _450_|

## Consideraciones de la prueba

Primeramente agradezco nuevamente su interés. Me hubiese gustado tener más tiempo y mejorar algunos aspectos, 
pero tuve menos tiempo esta semana del que pense. En total se trabajo en Miercoles y Jueves durate aproximadamente 6 horas para asegurar que todo funcionara. La mayoria del codigo, a excepcion de los endpoints y comentarios esta en inglés, usualmente preferiría elegir un solo idioma pero no estaba seguro sobre sus preferencias.

Muchas de las decisiones sobre el código fueron tomadas con la solución más simple y rápida en mente (una vez más, por cuestiones de tiempo). Mi decisión sobre tecnologías, algunos aspectos de organización y en general de diseño serías diferentes si estuviera programando algo similar para usarse en producción. Por ejemplo, para requisitos de rendimiento, usar alguna libreria con workers como Puma mejoraría la capacidad para procesar facturas. Rails usualmente implementa todo el "scaffolding" necesario para aplicaciones, pero Sinatra no lo hace, sin embargo esto tiene la ventaja de poder usar menos codigo para lograr implementar una solución correcta.

Elegí usar sqlite debido a su bajo consumo de memoria y relativa simplicidad para integrarlo con Active Record sin soporte de Rails, así como por cuestiones de tiempo. Usualmente para una aplicación de producción, usar Postgres directamente (o similar) seria mas adecuado y en todo caso solo habría que ajustar las migraciones. Tambien, la forma en la que se dividen las tablas (Factura, Timbre y Concepto) esta basado en como se hace el parsing, pero lo ideal seria eliminar datos superfluos y solo almacenar la  informacion necesaria. Esto tambien reduciria el tiempo necesario para almacenar. Asi mismo, tambien se pudieran añadir relaciones mas avanzadas, por ejemplo asegurar que los RFC esten asociados con un timbre en particular o asignarlos a usuarios. Decidí no incluir los traslados porque no estaba completamente seguro sobre el formato en el esquema y tambien para reducir tiempo de testing.

Para parsear use Nokogiri, fue recomendada en el email y ya tenia familiaridad con ella. Sin embargo, es posible que usar libxml directamente con algun validador hash pudiera ser mas eficiente, aunque personalmente solo he probado libxml parseando labels de paqueteria.

En cuanto a la organizacion, use una cercana a Rails, aunque mas sencilla. `app` incluye el código fuente, `config` configuraciones, `facturas` incluye las facturas de prueba y el esquema, `spec` incluye los tests. Por ahora no usé Rake ni ningún esquema de tareas muy complejo para correr, por ejemplo, las migraciones; para ellas usé un solo archivo.

Las pruebas abarcan todo menos los modelos, aunque la función `store` tecnicamente se prueba en `api_spec.rb` indirectamente. Se hicieron las pruebas primero y se implementó todo de forma iterativa.

Finalmente, en cuanto a mejoras, consideraría añadir error handling más robusto, más pruebas y posiblemente añadir funcionalidad para generar un reporte desde la base de datos (tecnicamente, también podrían almacenarse archivos json o similar si solo se necesitan reportes temporales, en vez de guardarlos en base de datos, o usar un memory store) y cambiar al objeto de Invoice para que funcione con otros schemas y formatos.

En caso que existan dudas, no duden en preguntarme. 
