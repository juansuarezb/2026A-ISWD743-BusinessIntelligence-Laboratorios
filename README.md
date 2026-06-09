# 2026A-ISWD743-practica7
### Fecha: 12/06/2026
### Práctica Creación Cubo Excel

<div align="center">

[![Andrea Chicaiza](https://img.shields.io/badge/Andrea_Chicaiza-andrea--m11-181717?style=for-the-badge&logo=github)](https://github.com/andrea-m11)<br><br>
[![Andreina Pallo](https://img.shields.io/badge/Andreina_Pallo-Andreina--P-181717?style=for-the-badge&logo=github)](https://github.com/Andreina-P)<br><br>
[![Jose Arias](https://img.shields.io/badge/Jose_Arias-JoseDA0721-181717?style=for-the-badge&logo=github)](https://github.com/JoseDA0721)<br><br>
[![Juan Mateo Quisilema](https://img.shields.io/badge/Juan_Mateo-JuanMateoQ-181717?style=for-the-badge&logo=github)](https://github.com/JuanMateoQ)<br><br>
[![Juan Suarez](https://img.shields.io/badge/Juan_Suarez-juansuarezb-181717?style=for-the-badge&logo=github)](https://github.com/juansuarezb)<br><br>

</div>

> [!NOTE]
>
> Este repositorio contiene el desarrollo del trabajo grupal de la Práctica 7, correspondiente a la creación de un cubo de datos multidimensional mediante tablas dinámicas en Microsoft Excel, utilizando un conjunto de datos de ventas por producto, ciudad y año.

---

> [!NOTE]
>
> Objetivos específicos:
> * Construir una tabla dinámica principal en Excel configurando los campos Producto, Fecha, Ciudad y Total para analizar ventas desde múltiples perspectivas.
> * Generar tablas dinámicas adicionales mediante duplicación y reconfiguración matricial que permitan visualizar los datos alternando las dimensiones de fila y columna.
> * Aplicar opciones de formato tabular y desactivar los totales generales para producir una estructura de cubo limpia y analíticamente comparable.

---

## Desarrollo

### Paso 1 – Configuración de la Tabla Dinámica Principal

Se creó la primera tabla dinámica mapeando los campos de la siguiente manera:

| Área        | Campo asignado   |
|-------------|------------------|
| Filas       | Productos        |
| Filtro      | Fecha            |
| Columnas    | Ciudad           |
| Valores     | Suma de Total    |

El resultado muestra las ventas totales de cada producto (Archivadores, Bolígrafos, Carpetas, Grapas, Lápices) desglosadas por ciudad (La Vega, Moca, Santiago, Santo Domingo), con el filtro de Fecha configurado para mostrar todas las fechas.

![Tabla dinámica principal — Producto × Ciudad](capturas/tdinamica1.png)

---

### Pasos 2 y 3 – Construcción y Reconfiguración Matricial de las Tablas Dinámicas Secundarias

Se duplicó la tabla dinámica original y se reconfiguraron los campos para obtener **dos perspectivas alternativas**:

**Segunda tabla dinámica — Fecha × Ciudad**

Los campos se redistribuyeron así:

| Área        | Campo asignado   |
|-------------|------------------|
| Filas       | Fecha            |
| Filtro      | Productos        |
| Columnas    | Ciudad           |
| Valores     | Suma de Total    |

Esto permite comparar el desempeño de ventas por año (2014, 2015, 2016) en cada ciudad.
![Tabla dinámica 2](capturas/tdinamica2.png)

**Tercera tabla dinámica — Fecha × Producto**

| Área        | Campo asignado   |
|-------------|------------------|
| Filas       | Fecha            |
| Columnas    | Productos        |
| Valores     | Suma de Total    |

Esta configuración expone la evolución temporal de las ventas por línea de producto.

![Tres tablas dinámicas 3](capturas/tdinamica3.png)

---

### Pasos 4 y 5 – Desactivación de Totales Generales y Formato Tabular

Para limpiar la estructura visual y homologar el formato entre las tres tablas:

1. Se desactivó la opción **Totales Generales** (tanto para filas como para columnas) desde la pestaña **Diseño → Totales generales → Desactivado para filas y columnas**.
2. Se aplicó el formato **"Mostrar en Forma Tabular"** desde **Diseño → Diseño de informe → Mostrar en forma tabular**, lo que alinea los encabezados de forma plana y facilita la lectura tipo cubo.

El resultado final muestra las tres tablas con estructura uniforme, sin filas de totales que distorsionen la comparación analítica entre dimensiones.

![Formato totales desactivados](capturas/desactivartotal.png)

![Formato tabular aplicado](capturas/etiquetas.png)

---
