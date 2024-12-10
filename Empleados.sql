DROP DATABASE IF EXISTS empleados;
CREATE DATABASE empleados CHARACTER SET utf8mb4;
USE empleados;

CREATE TABLE departamento (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  presupuesto DOUBLE UNSIGNED NOT NULL,
  gastos DOUBLE UNSIGNED NOT NULL
);

CREATE TABLE empleado (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nif VARCHAR(9) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  id_departamento INT UNSIGNED,
  FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);

INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);



-- 1. Lista el nombre y los apellidos de todos los empleados.
SELECT nombre, apellido1, apellido2
FROM empleado;

-- 2. Lista el primer apellido de los empleados eliminando los apellidos que estén repetidos.
SELECT DISTINCT apellido1
FROM empleado;

-- 3. Lista todas las columnas de la tabla empleado.
DESCRIBE empleado;

-- 4. Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado.
SELECT id_departamento
FROM empleado;

-- 5. Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado, eliminando los identificadores que aparecen repetidos.
SELECT DISTINCT id_departamento
FROM empleado
WHERE id_departamento IS NOT NULL;

-- 6. Lista el nombre y apellidos de los empleados en una única columna.
SELECT CONCAT(nombre, ' ', apellido1, ' ', IFNULL(apellido2, '')) AS nombre_completo
FROM empleado;

-- 7. Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en minúscula.
SELECT LOWER(CONCAT(nombre, ' ', apellido1, ' ', IFNULL(apellido2, ''))) AS nombre_completo
FROM empleado;

-- 8. Lista el identificador de los empleados junto al NIF, pero el NIF deberá aparecer en dos columnas, una mostrará únicamente los dígitos del NIF y la otra la letra.
SELECT id, 
       SUBSTRING(nif, 1, CHAR_LENGTH(nif) - 1) AS digitos,
       RIGHT(nif, 1) AS letra
FROM empleado;

-- 9. Lista el nombre de cada departamento y el valor del presupuesto actual del que dispone.
SELECT nombre, (presupuesto - gastos) AS presupuesto_actual
FROM departamento;

-- 10. Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.
SELECT nombre, (presupuesto - gastos) AS presupuesto_actual
FROM departamento
ORDER BY presupuesto_actual ASC;

-- 11. Lista el nombre de todos los departamentos ordenados de forma descendente.
SELECT nombre
FROM departamento
ORDER BY nombre DESC;

-- 12. Lista los apellidos y el nombre de todos los empleados, ordenados de forma alfabética teniendo en cuenta en primer lugar sus apellidos y luego su nombre.
SELECT apellido1, apellido2, nombre
FROM empleado
ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

-- 13. Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.
SELECT nombre, presupuesto
FROM departamento
ORDER BY presupuesto DESC
LIMIT 3;

-- 14. Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.
SELECT nombre, presupuesto
FROM departamento
ORDER BY presupuesto ASC
LIMIT 3;

-- 15. Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen mayor gasto.
SELECT nombre, gastos
FROM departamento
ORDER BY gastos DESC
LIMIT 2;

-- 16. Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen menor gasto.
SELECT nombre, gastos
FROM departamento
ORDER BY gastos ASC
LIMIT 2;

-- 17. Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado.
SELECT *
FROM empleado
LIMIT 5 OFFSET 2;

-- 18. Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto mayor o igual a 150000 euros.
SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto >= 150000;

-- 19. Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto entre 100000 y 200000 euros. (Sin usar `BETWEEN`).
SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto >= 100000 AND presupuesto <= 200000;

-- 20. Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros. (Usando `BETWEEN`).
SELECT nombre
FROM departamento
WHERE presupuesto NOT BETWEEN 100000 AND 200000;

-- 21. Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean mayores que el presupuesto.
SELECT nombre, gastos, presupuesto
FROM departamento
WHERE gastos > presupuesto;

-- 22. Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean menores que el presupuesto.
SELECT nombre, gastos, presupuesto
FROM departamento
WHERE gastos < presupuesto;

-- 23. Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean iguales al presupuesto.
SELECT nombre, gastos, presupuesto
FROM departamento
WHERE gastos = presupuesto;

-- 24. Lista todos los datos de los empleados cuyo segundo apellido sea NULL.
SELECT *
FROM empleado
WHERE apellido2 IS NULL;

-- 25. Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.
SELECT *
FROM empleado
WHERE apellido2 IS NOT NULL;

-- 26. Lista todos los datos de los empleados cuyo segundo apellido sea López.
SELECT *
FROM empleado
WHERE apellido2 = 'López';

-- 27. Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. (Sin utilizar el operador IN).
SELECT *
FROM empleado
WHERE apellido2 = 'Díaz' OR apellido2 = 'Moreno';

-- 28. Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. (Utilizando el operador IN).
SELECT *
FROM empleado
WHERE apellido2 IN ('Díaz', 'Moreno');

-- 29. Lista los nombres, apellidos y NIF de los empleados que trabajan en el departamento 3.
SELECT nombre, apellido1, apellido2, nif
FROM empleado
WHERE id_departamento = 3;

-- 30. Lista los nombres, apellidos y NIF de los empleados que trabajan en los departamentos 2, 4 o 5.
SELECT nombre, apellido1, apellido2, nif
FROM empleado
WHERE id_departamento IN (2, 4, 5);

-- 31. Calcula la suma del presupuesto de todos los departamentos.
SELECT SUM(presupuesto) AS suma_presupuestos
FROM departamento;

-- 32. Calcula la media del presupuesto de todos los departamentos.
SELECT AVG(presupuesto) AS media_presupuestos
FROM departamento;

-- 33. Calcula el valor mínimo del presupuesto de todos los departamentos.
SELECT MIN(presupuesto) AS minimo_presupuesto
FROM departamento;

-- 34. Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con menor presupuesto.
SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto = (SELECT MIN(presupuesto) FROM departamento);

-- 35. Calcula el valor máximo del presupuesto de todos los departamentos.
SELECT MAX(presupuesto) AS max_presupuesto
FROM departamento;

-- 36. Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con mayor presupuesto.
SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto = (SELECT MAX(presupuesto) FROM departamento);

-- 37. Calcula el número total de empleados que hay en la tabla empleado.
SELECT COUNT(*) AS total_empleados
FROM empleado;

-- 38. Calcula el número de empleados que no tienen NULL en su segundo apellido.
SELECT COUNT(*) AS empleados_con_segundo_apellido
FROM empleado
WHERE apellido2 IS NOT NULL;

-- 39. Calcula el número de empleados que trabajan en cada uno de los departamentos. El resultado de esta consulta también tiene que incluir aquellos departamentos que no tienen ningún empleado asociado.
SELECT d.nombre, COUNT(e.id) AS num_empleados
FROM departamento d
LEFT JOIN empleado e ON d.id = e.id_departamento
GROUP BY d.id;

-- 40. Calcula el número de empleados que trabajan en cada uno de los departamentos que tienen un presupuesto mayor a 200000 euros.
SELECT d.nombre, COUNT(e.id) AS num_empleados
FROM departamento d
LEFT JOIN empleado e ON d.id = e.id_departamento
WHERE d.presupuesto > 200000
GROUP BY d.id;

