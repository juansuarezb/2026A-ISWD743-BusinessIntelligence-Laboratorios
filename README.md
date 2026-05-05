# 2026A-ISWD743-practica4
### Fecha: 05/05/2026
### Práctica Modelo Conceptual Lógico Físico Estrella
  
</div>

[![Andrea Chicaiza](https://img.shields.io/badge/Andrea_Chicaiza-andrea--m11-181717?style=for-the-badge&logo=github)](https://github.com/andrea-m11)<br><br>
[![Andreina Pallo](https://img.shields.io/badge/Andreina_Pallo-Andreina--P-181717?style=for-the-badge&logo=github)](https://github.com/Andreina-P)<br><br>
[![Jose Arias](https://img.shields.io/badge/Jose_Arias-JoseDA0721-181717?style=for-the-badge&logo=github)](https://github.com/JoseDA0721)<br><br>
[![Juan Mateo Quisilema](https://img.shields.io/badge/Juan_Mateo-JuanMateoQ-181717?style=for-the-badge&logo=github)](https://github.com/JuanMateoQ)<br><br>
[![Juan Suarez](https://img.shields.io/badge/Juan_Suarez-juansuarezb-181717?style=for-the-badge&logo=github)](https://github.com/juansuarezb)<br><br>

>[!NOTE]
>
> Este repositorio contiene el desarrollo del trabajo grupal de la Práctica 4 de Business Intelligence, correspondiente al diseño e implementación de un modelo físico en esquema estrella y su análisis en Power Pivot.<br>
> Se implementa un proceso de normalización de datos utilizando PostgreSQL para estructurar la información en tablas de dimensiones y hechos, y posteriormente se realiza el análisis mediante Power Pivot.

---

>[!NOTE]
>
> Objetivos específicos:
> * Presentar el diagrama del modelo estrella en Power Pivot a partir del archivo products.csv.
> * Normalizar los datos del archivo Tabla_Desnormalizada_Ventas.csv en un esquema estrella.
> * Construir el modelo dimensional (tabla de hechos y dimensiones).
> * Generar consultas SQL para analizar ventas por categoría, cliente y producto.
> * Analizar métricas de negocio como ingresos, cantidades vendidas y comportamiento por mes.

---

## 

---

## Diseño y diagrama del modelo estrella de `Tabla_Desnormalizada_Ventas.csv`

### Estructura del archivo original

El archivo tiene **100 filas** con **26 columnas** que mezclan información de cuatro entidades distintas:

| Entidad | Columnas |
|---|---|
| Product | ProductKey, ProductCode, ProductName, ListPrice, Color, Size, Category, Subcategory |
| Customer | CustomerKey, BirthDate, MaritalStatus, Gender, Income, Children, HomeOwner, Cars |
| Order Date | OrderDateKey, Order Date |
| Ship Date | ShipDateKey, Ship Date |
| Sales | OrderNumber, OrderLineNumber, Quantity, UnitPrice, ProductCost, SalesAmount |

**Problema:** Los datos del cliente `1010`, por ejemplo, se repiten exactamente en todas sus filas de compra. La normalización extrae cada entidad a su propia tabla.


### Decisiones de diseño

* **¿Por qué `id_sales` como clave primaria en `fact_sales`?**
Esto simplifica los JOINs, mejora el rendimiento y desacopla la identidad de la fila de los datos del negocio. `OrderNumber` y `OrderLineNumber` se conservan como columnas informativas.
<br>

* **¿Por qué dos tablas de fecha (`dim_order_date` y `dim_ship_date`)?**
Cada venta tiene dos fechas distintas: cuándo se realizó el pedido y cuándo se envió. Para esta práctica se optó por **dos tablas separadas**, lo que permite que ambas relaciones sean activas y simplifica tanto las consultas SQL como el modelo en Power Pivot.
<br>

### Modelo Estrella Final — Ventas

El modelo se compone de **1 tabla de hechos** y **4 dimensiones**:

```
    ┌─────────────────────┐                         ┌──────────────────────┐
    │    dim_product      │                         │   dim_order_date     │
    │─────────────────────│                         │──────────────────────│
    │ ProductKey (PK)     │                         │ OrderDateKey (PK)    │
    │ Product Code        │                         │ date                 │
    │ Product Name        │   ┌─────────────────┐   │ year                 │
    │ List Price          │   │   fact_sales    │   │ month                │
    │ Color               │   │─────────────────│   │ monthName            │
    │ Size                ├───┤ id_sales (PK)   ├───└──────────────────────┘
    │ Category            │   │                 │                          
    │ Subcategory         │   │ OrderNumber     │   ┌──────────────────────┐
    └─────────────────────┘   │ OrderLineNumber │   │   dim_ship_date      │
                              │ Quantity        │   │──────────────────────│
    ┌─────────────────────┐   │ UnitPrice       ├───┤ ShipDateKey (PK)     │
    │   dim_customer      │   │ ProductCost     │   │ date                 │
    │─────────────────────│   │ SalesAmount     │   │ year                 │
    │ CustomerKey (PK)    │   │                 │   │ month                │
    │ Birth Date          ├───┤ ProductKey (FK) │   │ monthName            │
    │ Marital Status      │   │ CustomerKey (FK)│   └──────────────────────┘
    │ Gender              │   │ OrderDateKey(FK)│
    │ Income              │   │ ShipDateKey (FK)│
    │ Children            │   └─────────────────┘
    │ Home Owner          │   
    │ Cars                │   
    └─────────────────────┘   
                          
```

<br>

### Diagrama en Power Pivot — Ventas
---
### Proceso de implementación:

#### Paso 1: Preparar las hojas como Tablas de Excel

Se crearon 5 hojas en el archivo Excel, cada una con los datos de una tabla del modelo. Para que Power Pivot las reconozca correctamente, cada hoja debe convertirse en una Tabla de Excel:

1. Se hace clic en cualquier celda con datos dentro de la hoja.
2. Presionar `Ctrl + T` → confirmar que tiene encabezados → OK.
3. En la pestaña **Diseño de tabla**, asignar el nombre exacto de la tabla (`dim_product`, `dim_customer`, etc.).

Se repitió este proceso para las 5 tablas.

| ![Tabla fact_sales](capturas/tablafactsales.png) |
| :---: |
| *Figura 1: Conversión de datos a una tabla de Excel* |

#### Paso 2: Agregar las tablas al modelo de Power Pivot

Con cada tabla seleccionada, se fue a **Power Pivot → Agregar al modelo de datos**. Esto abre la ventana de Power Pivot y carga cada tabla como una pestaña independiente dentro del modelo.

| ![Tablas al modelo de datos](capturas/tablaModelo.png) |
| :---: |
| *Figura 2: Agregar las tablas al modelo de datos* |

| ![Tablas en power pivot](capturas/tablasPowerPivot.png) |
| :---: |
| *Figura 3: Cinco tablas en Power Pivot* |

#### Paso 3: Crear las relaciones en Vista de Diagrama

Dentro de Power Pivot se navegó a **Inicio → Vista de diagrama**. Las tablas aparecen como bloques flotantes. Se acomodaron manualmente con `fact_sales` al centro y las dimensiones alrededor.

Las relaciones se crean **arrastrando** desde la columna FK en `fact_sales` hacia la columna PK en cada dimensión:

Power Pivot muestra `1` del lado de la dimensión y `*` del lado de `fact_sales`, indicando la relación uno a muchos.

* **Resultado**: Diagrama del modelo en Power Pivot

| ![Diagrama Power Pivot ventas](capturas/modEstrellaVentas.png) |
| :---: |
| *Figura 4: Diagrama del modelo estrella de Tabla_Desnormalizada_Ventas en Power Pivot* |

---