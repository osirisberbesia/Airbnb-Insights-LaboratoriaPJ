# Airbnb-Insights-LaboratoriaPJ
Proyecto de Business Intelligence aplicado a Airbnb. Analiza datos de interacciones anfitrión-huésped para optimizar disponibilidad, maximizar ingresos y mejorar experiencias. Utiliza técnicas avanzadas de BI para visualizar tendencias, identificar patrones y fundamentar decisiones estratégicas.

## Datos recibidos
Se reciben tres data set, uno correspondiente a una tabla de hechos (reviews) y dos tablas de dimensión (rooms y hosts).

Cantidad de datos originales por set:
* Reviews: 48.875
* Rooms: 48.875 
* Host: 37.484

### Detalles de los datos:

Exploratorio pre-liminar antes de cargar los datos a bigquery.

#### Dataset de rooms

* id: en este campo, hay valores diferentes a la naturaleza del mismo, por lo que se observa que los datos pertenecen al campo "name"
* name: hay cadena de caracteres en chino, sin embargo no se dejarán por fuera
* neighbourhood: hay datos que no corresponden en si a un acrónimo o a un barrio, los cuales son:
  * Battery Park City - Aunque es una zona conocida, se suele considerar más como una región o distrito.
  * Brooklyn - Es uno de los cinco boroughs de Nueva York, no un barrio específico dentro de Brooklyn.
  * Manhattan - Al igual que Brooklyn, Manhattan es uno de los boroughs de Nueva York.
  * Staten Island - También es uno de los boroughs de Nueva York.
  * Queens - Otro borough de Nueva York.
  * Financial District - Es una zona específica dentro de Manhattan, pero se refiere a un distrito financiero.
  * Downtown Brooklyn - Aunque es una área dentro de Brooklyn, se refiere a una región más amplia que a un barrio específico.
  * Flatiron District - Es una zona en Manhattan conocida por su edificio icónico, pero se considera más un distrito que un barrio.
  * University Heights - Es un área en el Bronx, pero se puede considerar una región más que un barrio tradicional.
  * Theater District - Se refiere a una área en Manhattan conocida por sus teatros, pero no es un barrio en el sentido tradicional.
  * Financial District - Es un área de Manhattan conocida por sus centros financieros, no un barrio. 
    Estos datos se dejarán tan cual como está en el dataset

 * neighbourhood_group: existen datos anómalos correspondientes a las coordenadas, se decide excluir estos del estudio.
 * latitude: existen valores no numéricos (154) correspondientes a room_type
 * longitud: al igual que latitude, existen valores no numéricos correspondientes a room_type y otros valores numéricos no correspondientes a una medida de longitud para coordenadas
 * room_type: contiene valores numéricos, sin embargo, por la naturaleza numérica no se puede determinar a cual campo pertenece
 * minimun_nights: no se observan discrepancias


#### Dataset de hosts

* hostid: hay valores de letras
* hostname: no se encuentran anomalías en este campo

#### Dataset de reviews

* id: campos con letras o símbolos
* hostid: no se observan discrepancias
* price: existen datos en formato fecha que no corresponde a lo esperado en este campo
* numberofreviews: para un campo numérico continuo resultado de la acumulación de reviews en el sistema, se toma como discrepante el hecho de que hayan valores con decimales 
* lastreview: se observa que este campo es del tipo fecha, sin embargo, tiene valores numéricos
* reviewspermonth: no se observan datos discrepantes
* calculatedhostlistingscount: no se observan datos discrepantes
* availability365:  no se observan datos discrepantes

Se observa, que hay campos con información intercambiada:

![alt text](img/image.png)

Estos datos, se dejarán por fuera del análisis.

Datos después de la pre-limpieza:
| Tabla | Cantidad de datos originales | Datos después de pre-limpieza | % datos excluidos |
|---------|------------------------------|------------------------------|-------------------|
| reviews | 48.875 |  48.710 | 0.34% |
| rooms |  48.875 | 48.710 | 0.34% |
| hosts | 37.484 | 37.362 | 0.33% |


[Query de las limpiezas pre-procesamiento. ](/SQL/limpieza.sql)


## Validación de nulos:

La única tabla con nulos es reviews, con 10.016 nulos en cada uno de los siguientes campos: reviews_per_month y last_review.
[Puede ver la query acá.](/SQL/nulos.sql)
Se entiende que si una room no ha sido calificada, no tendrá estos datos con valores

## Validación de duplicados

En las tablas de dimensiones, solo se validan los respectivos ID para la exploración de sus duplicados, las cuales no contienen duplicados
En la tabla de hechos reviews, los host_id si tienen duplicados, contando 5.116 duplicados de 1 a más veces.

[Puede ver la query acá.](/SQL/duplicados.sql)


## Discrepancias

Fueron identificadas en la pre-limpieza y explicadas a detalles al inicio del documento.



