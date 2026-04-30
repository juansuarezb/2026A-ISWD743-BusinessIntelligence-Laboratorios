# 2026A-ISWD743-practica2
### Fecha: 01/05/2026
### Práctica ETL
  
</div>

[![Andrea Chicaiza](https://img.shields.io/badge/Andrea_Chicaiza-andrea--m11-181717?style=for-the-badge&logo=github)](https://github.com/andrea-m11)<br><br>
[![Andreina](https://img.shields.io/badge/Andreina-Andreina--P-181717?style=for-the-badge&logo=github)](https://github.com/Andreina-P)<br><br>
[![Jose Arias](https://img.shields.io/badge/Jose_Arias-JoseDA0721-181717?style=for-the-badge&logo=github)](https://github.com/JoseDA0721)<br><br>
[![Juan Mateo Quisilema](https://img.shields.io/badge/Juan_Mateo-JuanMateoQ-181717?style=for-the-badge&logo=github)](https://github.com/JuanMateoQ)<br><br>
[![Juan Suarez](https://img.shields.io/badge/Juan_Suarez-juansuarezb-181717?style=for-the-badge&logo=github)](https://github.com/juansuarezb)<br><br>

>[!NOTE]
>
> Este repositorio contiene el desarrollo del trabajo grupal de la Práctica 2 de Business Intelligence, correspondiente al caso de estudio "Ferretería El Tornillo Feliz".<br>
> Se implementa un proceso ETL(Extract, Transform, Load) utilizando Pentaho Data Integration para limpiar y consolidar el catálogo de productos de la ferretería en una base de datos central PostgreSQL.

---

>[!NOTE]
>
> Objetivos específicos:
> * Crear la tabla staging.productos_ferreteria_raw en PostgreSQL y cargar los datos originales
> * Diseñar una transformación ETL en Pentaho que estandarice las categorías de productos.
> * Eliminar símbolos innecesarios ($) del campo precio_unitario.
> * Unificar los distintos formatos de unidad de medida
> * Cargar los datos limpios en la tabla staging.productos_ferreteria_clean.

---

## 🛠️ Detalle de los Pasos de Transformación (Transform)
Se diseño el siguiente flujo para transformar los datos.

![Flujo ETL](capturas/flujoETL.png)

A continuación, se detalla la configuración de cada componente del flujo de tranformación:

### 1. Normalización de Cadenas
* **Tipo de Transformación:** `String operations`
* **Nombre del paso:** `Normalizar datos`
* **Configuración:**
    * **Campo `categoria y unidad_medidad`**: Se aplicó la función `Lower` (minúsculas) y se eliminaron espacios en blanco con `Trim type: both`. Esto reduce las variaciones.

![Normalizacion](capturas/normalizar.png)  

### 2. Homologación de Categorías
* **Tipo de Transformación:** `Value mapper`
* **Nombre del paso:** `Limpieza de Categorías`
* **Configuración:**
    * **Campo origen:** `categoria`
    * **Mapeo:** Se establecieron reglas para consolidar sinónimos y abreviaturas en términos estándar.
        * *Ejemplo:* `htas`, `herram`, `herramientas` se transforman en **Herramienta**.
        * *Ejemplo:* `electr`, `electric.` se transforman en **Electricidad**.
    * **Valor por defecto:** Se definió como `REVISAR` para capturar cualquier categoría nueva que no cumpla con los filtros establecidos.

![LimpiezaCategorias](capturas/limpiarcategorias.png)

### 3. Estandarización de Unidades de Medida
* **Tipo de Transformación:** `Replace in string`
* **Nombre del paso:** `Estandarizar Unidad de Medida`
* **Configuración:**
    * **Uso de RegEx:** Se activó la opción `Use regular expression` para realizar búsquedas avanzadas.
    * **Lógica:** Se configuraron expresiones para identificar variaciones de unidades (Unidad, Litro, Caja, Rollo, Set, Frasco, Tubo, Metro, Par, Hoja).
    * **Case Sensitive:** Configurado en `N` para ignorar mayúsculas.

![EstandarizarUnidades](capturas/estadarizarunidad.png)


### 4. Limpieza de Formato de Precios
* **Tipo de Transformación:** `Replace in string`
* **Nombre del paso:** `Limpieza de Precios`
* **Configuración:**
    * **Campo:** `precio_unitario`
    * **Búsqueda:** Se localiza el símbolo especial `$` (símbolo de moneda).
    * **Reemplazo:** Se deja vacío (cadena de longitud cero) para purificar el dato y permitir su conversión a formato numérico.

![LimpiezaPrecio](capturas/limpiezaprecio.png)

### 5. Definición de Metadatos y Tipado Final
* **Tipo de Transformación:** `Select values` (Pestaña Meta-data)
* **Nombre del paso:** `Cambiar tipo de dato`
* **Configuración:**
    * **precio_unitario**: Conversión formal de String a **Number**, definiendo una precisión de `2` decimales.

![CambiarTipo](capturas/cambiotipo.png)

