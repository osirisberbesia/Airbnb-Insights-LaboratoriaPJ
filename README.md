![alt text](Img/portada.png)

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

![alt text](https://github.com/osirisberbesia/Airbnb-Insights-LaboratoriaPJ/blob/2277dd699141a79059ea4f6e3b063b090fdb7fc1/Img/image.png)

Estos datos, se dejarán por fuera del análisis.

Datos después de la pre-limpieza:


| Tabla | Cantidad de datos originales | Datos después de pre-limpieza | % datos excluidos |
|---------|------------------------------|------------------------------|-------------------|
| reviews | 48.875 |  48.710 | 0.34% |
| rooms |  48.875 | 48.710 | 0.34% |
| hosts | 37.484 | 37.362 | 0.33% |


[Query de las limpiezas pre-procesamiento. ](SQL/limpieza.sql)


## Validación de nulos:

La única tabla con nulos es reviews, con 10.016 nulos en cada uno de los siguientes campos: reviews_per_month y last_review.
[Puede ver la query acá.](SQL/nulos.sql)
Se entiende que si una room no ha sido calificada, no tendrá estos datos con valores

## Validación de duplicados

En las tablas de dimensiones, solo se validan los respectivos ID para la exploración de sus duplicados, las cuales no contienen duplicados
En la tabla de hechos reviews, los host_id si tienen duplicados, contando 5.116 duplicados de 1 a más veces.

[Puede ver la query acá.](SQL/duplicados.sql)


## Discrepancias

Fueron identificadas en la pre-limpieza y explicadas a detalles al inicio del documento.

## Cambio de tipos de datos en Power BI

* Latitude y longitud, se asignaron cada una a latitud y longitud y no solo como valores numéricos
* Price, de numérico a moneda


## Nuevas variables

### Tabla reviews

* total_incoming: calcula el total que puede generar una habitación en función del precio y número de días disponibles en un año.

* tipo_anfitrion:

  * 1-10 listados: "Novato"
  * 11-30 listados: "Desarrollo"
  * 31-50 listados: "Emergente"
  * 51-80 listados: "Establecido"
  * 81-100 listados: "Referente"
  * 101+ listados: "Líder del Sector"

### Tabla rooms

* noches_minimas_categorica: según la cantidad de días de noches mínimas que permite reservar se generaron las siguientes categorías
   * 1-14 días: Estadía corta
   * 15-30 días: Estadía media
   * 30-90 días: Estadía larga
   * 91-180 días: Estadía prolongada
   * 181-365 días: Estadía extendida
   * +366 días: Residencia a largo plazo


## Columnas a partir de formulas DAX

  * total_huespedes_barrio: número total de huéspedes que un barrio podría recibir en un año.

```
EVALUATE
VAR dias_year = 365
RETURN
SUMMARIZE(
    'rooms-pre-charge',
    'rooms-pre-charge'[neighbourhood_group],
    "Total_Guests_Per_Year",
    SUMX(
        'rooms-pre-charge',
        DIVIDE(dias_year, 'rooms-pre-charge'[minimum_nights], 0)
    )
)
```


  * perc_rooms_barrio: porcentaje de habitaciones disponibles por barrio.

  ```
EVALUATE
SUMMARIZECOLUMNS(
    'rooms-pre-charge'[neighbourhood_group],
    "Porcentaje de Habitaciones Disponibles",
    DIVIDE(
        SUM('reviews-pre-charge'[availability_365]),
        COUNTROWS('rooms-pre-charge') * 365,
        0
    ) * 100
)
  ```


 ## Visualización de variable categóricas

![alt text](Img/image2.png)


## Visualización  de los datos a lo largo del tiempo

![alt text](Img/image-6.png)
![alt text](Img/image-1.png)

## Puntos en el mapa de las propiedades listadas

![alt text](Img/image-2.png)

## Distribución de ingresos por zona y tipo de habitación


![alt text](Img/image-3.png)

![alt text](Img/image-4.png)

## Promedio de noches mínimas por barrio según tipo de hosts

![alt text](Img/image-5.png)

## Recomendaciones y conclusiones

### Conclusiones

1. Las propiedades están distribuidas principalmente en áreas céntricas o turísticas, lo que influye positivamente en los ingresos.
2. Los apartamentos completos generan más ingresos que las habitaciones privadas o compartidas.
3. Las estancias cortas tienen conquistado completamente el mercado, mientras que las largas aseguran una ocupación estable pero con mínima demanda.
4. Manhattan es el barrio con mayor ingresos de la zona.
5. Los hosts novatos son los que representan la mayor cantidad de ingresos en comparación con líderes del sector

### Recomendaciones

1. Ofrecer descuentos para estancias prolongadas durante temporadas bajas para mantener una ocupación continua.
2. Considerar la oferta de distintos tipos de alojamiento, como habitaciones privadas, para atraer diferentes segmentos de mercado.
3. Disminuir la cantidad de noches mínimas requeridas para hospedaje y aumentar así el atractivo de reservaciones, ya que el mínimo promedio de noches para reservar se recomienda sea 1, e inicia en 4 hasta casi 9 noches.
4. Aumentar la disponibilidad anual de las rooms, ya que de nuestras 48.710 habitaciones, solo el 2.73% (1.284 rooms) tienen disponibilidad durante los 365 días del año.

## Enlaces de interés:

* [Presentación](https://docs.google.com/presentation/d/1KRGexRGgtAMjXQOxSch2y6QnQ0NJpU71CPJofxNK7Bk/edit?usp=sharing)
* [Video Loom](https://www.loom.com/share/a8566c2edd954af3aa47d1505f2ba75d)

--------------------------
# Imagen del [dashboard](https://github.com/osirisberbesia/Airbnb-Insights-LaboratoriaPJ/blob/main/dashboard-airbnb.pbix)

![alt text](Img/dash.png)
