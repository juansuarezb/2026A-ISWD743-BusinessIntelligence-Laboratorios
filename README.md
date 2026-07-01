<div align="center">

<img src="capturas/logo_epn.png" height="80" align="left"/>
<img src="capturas/logo_fis.png" height="80" align="right"/>
<br clear="all"/>

<h1><strong>Escuela Politécnica Nacional</strong></h1>

### Facultad de Ingeniería de Sistemas

**Business Intelligence (ISWD743) · GR2SW_2026-1**

**Informe Naive Bayes y Predecir valores**

---

**Fecha:** <br/>
30 de Junio, 2026

**Integrantes:** <br/>
Andrea Chicaiza <br/>
Andreina Pallo <br/>
Jose Arias <br/>
Juan Mateo Quisilema <br/>
Juan Suarez

</div>

---

> [!NOTE]
>
> Este repositorio contiene el desarrollo del trabajo grupal de la práctica de Naive Bayes y predecir valores, cuyo objetivo es construir y evaluar modelos de clasificación supervisada en Weka mediante los algoritmos J48 (árbol de decisión) y Naive Bayes, predecir nuevas instancias a partir de los modelos entrenados y aplicar ambas técnicas a un caso de estudio de evaluación de riesgo crediticio.

---

> [!NOTE]
>
> Objetivos específicos:
> * Construir y evaluar un árbol de decisión mediante el algoritmo J48 sobre el dataset `iris`, analizando el modelo generado y sus métricas de desempeño.
> * Construir y evaluar un clasificador Naive Bayes sobre el dataset `weather.nominal`, analizando las probabilidades condicionales calculadas y sus métricas de desempeño.
> * Implementar en Python las reglas de decisión obtenidas en Weka para ambos clasificadores, permitiendo predecir nuevas instancias fuera del entorno de Weka.
> * Aplicar los algoritmos J48 y Naive Bayes a un caso de estudio de evaluación de riesgo crediticio (`loan_risk_dataset`), determinando si otorgar o no un crédito a partir de variables como historial crediticio, nivel de ingreso y edad.

---

<h2><strong>Índice</strong></h2>

- [Desarrollo](#desarrollo)
- [1. Introducción](#1-introducción)
  - [1.1 Aprendizaje Supervisado: Clasificación y Predicción](#11-aprendizaje-supervisado-clasificación-y-predicción)
  - [1.2 Árboles de Decisión y Algoritmo J48 (C4.5)](#12-árboles-de-decisión-y-algoritmo-j48-c45)
  - [1.3 Clasificador Naive Bayes (Teorema de Bayes)](#13-clasificador-naive-bayes-teorema-de-bayes)
- [2. Desarrollo de la Práctica](#2-desarrollo-de-la-práctica)
  - [2.1 Preparación de Datos](#21-preparación-de-datos)
  - [2.2 Clasificación con Árbol de Decisión J48](#22-clasificación-con-árbol-de-decisión-j48)
    - [2.2.1 Construcción y Evaluación del Modelo en Weka](#221-construcción-y-evaluación-del-modelo-en-weka)
    - [2.2.2 Predicción de Nuevas Instancias con Código Python](#222-predicción-de-nuevas-instancias-con-código-python)
  - [2.3 Clasificación con Naive Bayes](#23-clasificación-con-naive-bayes)
    - [2.3.1 Construcción y Evaluación del Modelo en Weka](#231-construcción-y-evaluación-del-modelo-en-weka)
    - [2.3.2 Predicción de Nuevas Instancias con Código Python](#232-predicción-de-nuevas-instancias-con-código-python)
  - [2.4 Caso de Estudio Aplicado: Evaluación de Riesgo Crediticio](#24-caso-de-estudio-aplicado-evaluación-de-riesgo-crediticio)
    - [2.4.1 Construcción del Árbol de Decisión en Weka](#241-construcción-del-árbol-de-decisión-en-weka)
    - [2.4.2 Predicción de Riesgo con Código Python](#242-predicción-de-riesgo-con-código-python)
  - [2.5 Comparación y Análisis de Resultados](#25-comparación-y-análisis-de-resultados)
  - [2.6 Predicción de Nuevas Instancias en Weka (ArffViewer)](#26-predicción-de-nuevas-instancias-en-weka-arffviewer)
    - [2.6.1 Preparación del Conjunto de Prueba con ArffViewer](#261-preparación-del-conjunto-de-prueba-con-arffviewer)
    - [2.6.2 Predicción con Naive Bayes](#262-predicción-con-naive-bayes)
    - [2.6.3 Predicción con J48](#263-predicción-con-j48)
- [3. Conclusiones](#3-conclusiones)
- [Referencias Bibliográficas](#referencias-bibliográficas)
- [Declaración de Porcentaje de Uso de IA](#declaración-de-porcentaje-de-uso-de-ia)

---

## Desarrollo

---

## 1. Introducción

### 1.1 Aprendizaje Supervisado: Clasificación y Predicción

### 1.2 Árboles de Decisión y Algoritmo J48 (C4.5)

### 1.3 Clasificador Naive Bayes (Teorema de Bayes)

El **Teorema de Bayes** calcula la probabilidad de un evento $A_i$ dado que se observó otro evento $B$, a partir de la relación:
 
$$P(A_i|B) = \frac{P(A_i) \cdot P(B|A_i)}{P(B)}$$
 
Donde $P(A_i)$ es la probabilidad *a priori* (la probabilidad del evento antes de considerar la evidencia), $P(B|A_i)$ es la verosimilitud (qué tan probable es la evidencia $B$ si $A_i$ es cierto), y $P(A_i|B)$ es la probabilidad *a posteriori*, es decir, la probabilidad actualizada de $A_i$ una vez incorporada la evidencia [[1]](#referencias)[[2]](#referencias).
 
En clasificación, $A_i$ representa una clase (por ejemplo, "jugar" o "no jugar") y $B$ representa los atributos observados (clima, temperatura, etc.). Calcular la verosimilitud conjunta de todos los atributos resulta costoso, por lo que el clasificador **Naive Bayes** incorpora el **supuesto de independencia condicional**: asume que, fijada la clase, cada atributo aporta información de forma independiente respecto a los demás ($P(A \cap B) = P(A) \cdot P(B)$) [[3]](#referencias). Esto permite descomponer la verosimilitud conjunta en el producto de las probabilidades individuales de cada atributo, simplificando notablemente el cálculo. Aunque este supuesto rara vez se cumple estrictamente en datos reales, el clasificador conserva un buen rendimiento predictivo con bajo costo computacional.

 
| ![Teorema de Bayes](capturas/teorema_bayes.png) |
|:--:|
| *Figura 1: Representación esquemática del Teorema de Bayes [[4]](#referencias)* |

---

## 2. Desarrollo de la Práctica

### 2.1 Preparación de Datos

Weka trabaja sobre archivos en formato `.arff` (*Attribute-Relation File Format*), donde cada atributo se declara con su tipo —nominal o numérico— y la clase a predecir queda definida como el último atributo de la relación. La práctica recurre a tres conjuntos de datos distintos, cada uno asociado a un clasificador o caso de aplicación específico.

El dataset `iris.arff` reúne 150 instancias de flores de tres especies (Iris-setosa, Iris-versicolor e Iris-virginica), descritas mediante cuatro atributos numéricos: `sepallength`, `sepalwidth`, `petallength` y `petalwidth`. Este conjunto se utiliza para construir el árbol de decisión J48 en la sección 2.2, ya que sus atributos continuos permiten observar cómo el algoritmo calcula los umbrales de corte en cada nodo.

Por su parte, `weather.nominal.arff` contiene apenas 14 instancias, pero todos sus atributos son nominales: `outlook`, `temperature`, `humidity` y `windy`, con `play` como clase a predecir. Es decir, a diferencia de iris, aquí no hay umbrales numéricos que calcular sino frecuencias de ocurrencia por categoría, lo que lo convierte en el dataset adecuado para introducir Naive Bayes en la sección 2.3.

El tercer dataset, `loan_risk_dataset.arff`, corresponde al caso de estudio de la sección 2.4. Reúne 340 instancias de clientes bancarios, descritas mediante tres atributos nominales (`Loan_History`, `Income` y `Age`) y la clase `Loan_Decision`, que clasifica a cada cliente como `risky` o `safe`. Al contar con muchas más instancias que los dos datasets anteriores, permite evaluar el comportamiento del árbol J48 sobre un volumen de datos más representativo de un escenario real de negocio.

La Tabla 1 resume los tres datasets utilizados a lo largo de la práctica.

<div align="center">

| Dataset | Atributos | Clase | N.º de instancias | Clasificador asociado |
|---|---|---|---|---|
| `iris.arff` | `sepallength`, `sepalwidth`, `petallength`, `petalwidth` (numéricos) | `class` (Iris-setosa / Iris-versicolor / Iris-virginica) | 150 | J48 |
| `weather.nominal.arff` | `outlook`, `temperature`, `humidity`, `windy` (nominales) | `play` (yes / no) | 14 | Naive Bayes |
| `loan_risk_dataset.arff` | `Loan_History`, `Income`, `Age` (nominales) | `Loan_Decision` (risky / safe) | 340 | J48 (caso de estudio) |

*Tabla 1: Resumen de los datasets utilizados en la práctica*

</div>

Además de los tres datasets anteriores, la sección 2.6 utiliza un cuarto archivo, `test.arff`, derivado de `weather.nominal.arff` mediante la herramienta ArffViewer de Weka. A diferencia de los datasets previos, `test.arff` no es un conjunto de entrada original sino una instancia de prueba con el atributo `play` en blanco, construida específicamente para que los clasificadores J48 y Naive Bayes ya entrenados prediga su valor.

Con los datasets caracterizados, las siguientes secciones detallan la construcción de cada clasificador y su aplicación sobre nuevas instancias.

---

### 2.2 Clasificación con Árbol de Decisión J48

#### 2.2.1 Construcción y Evaluación del Modelo en Weka

#### 2.2.2 Predicción de Nuevas Instancias con Código Python

---

### 2.3 Clasificación con Naive Bayes

#### 2.3.1 Construcción y Evaluación del Modelo en Weka

#### 2.3.2 Predicción de Nuevas Instancias con Código Python

---

### 2.4 Caso de Estudio Aplicado: Evaluación de Riesgo Crediticio

#### 2.4.1 Construcción del Árbol de Decisión en Weka

#### 2.4.2 Predicción de Riesgo con Código Python

---

### 2.5 Comparación y Análisis de Resultados

---

### 2.6 Predicción de Nuevas Instancias en Weka (ArffViewer)

#### 2.6.1 Preparación del Conjunto de Prueba con ArffViewer

#### 2.6.2 Predicción con Naive Bayes

#### 2.6.3 Predicción con J48

---

## 3. Conclusiones

---

## Referencias Bibliográficas
<a name="referencias"></a>

[1] "13.4: Regla Bayes, probabilidad condicional e independencia," *LibreTexts*. [En línea]. Disponible en: https://espanol.libretexts.org/Bookshelves/Ingenieria/Ingenieria_Industrial_y_de_Sistemas/Libro%3A_Din%C3%A1mica_y_Controles_de_Procesos_Qu%C3%ADmicos_(Woolf)/13%3A_Estad%C3%ADsticas_y_antecedentes_probabil%C3%ADsticos/13.04%3A_Regla_Bayes%2C_probabilidad_condicional_e_independencia. [Accedido: 30-jun-2026].
 
[2] J. Joyce, "Bayes' Theorem," *Stanford Encyclopedia of Philosophy*, 2003. [En línea]. Disponible en: https://plato.stanford.edu/entries/bayes-theorem/. [Accedido: 30-jun-2026].
 
[3] J. Ortega, "Capítulo 3: Probabilidad Condicional e Independencia," *CIMAT*. [En línea]. Disponible en: https://www.cimat.mx/~jortega/MaterialDidactico/EPyE14/Cap3.pdf. [Accedido: 30-jun-2026].
 
[4] Libélula - ciencia, ingeniería y cultura, "Teorema de Bayes fácil y rápido," *YouTube*. [En línea]. Disponible en: https://www.youtube.com/watch?v=9TTx9H9CwhA. [Accedido: 30-jun-2026].

---

## Declaración de Porcentaje de Uso de IA
