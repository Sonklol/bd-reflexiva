/*
Empleados{codEmpleado, codJefe   nombre,        priApe,        sueldo,                                     dni}
            P.K          F.K     N.N UNIQUE     N.N UNIQUE    CHECK(sueldo>0 AND sueldo<6000), N.N       UNIQUE N.N
*/

DROP DATABASE IF EXISTS Ejercicio_Empleados;
CREATE DATABASE Ejercicio_Empleados;
USE Ejercicio_Empleados;
CREATE TABLE Empleados (
    codEmpleado INT PRIMARY KEY,
    codJefe INT, /* Código del Jefe del Empleado (SI NO TIENE ES NULL)*/
    nombre VARCHAR(20) NOT NULL,
    priApe VARCHAR(25) NOT NULL,
    sueldo NUMERIC(7, 2) NOT NULL CHECK(sueldo>0),
    dni VARCHAR(9) NOT NULL UNIQUE,

    FOREIGN KEY (codJefe) REFERENCES Empleados(codEmpleado) ON DELETE SET NULL /* ON UPDATE CASCADE (NO FUNCIONA PORQUE ES REFLEXIBA)*/
);

ALTER TABLE Empleados ADD UNIQUE(nombre, priApe);
ALTER TABLE Empleados ADD CHECK(sueldo<=6000);

ALTER TABLE Empleados MODIFY dni VARCHAR(9) NULL;
ALTER TABLE Empleados MODIFY priApe VARCHAR(25) NULL;

INSERT INTO Empleados(codEmpleado, nombre, priApe, sueldo, dni) VALUES (1, 'Jorge', 'Sanchez', 5000, '76544565S');
INSERT INTO Empleados(codEmpleado, codJefe, nombre, priApe, sueldo, dni) VALUES (2, 1, 'Ana', 'Garcia', 4000, '87644565S');
INSERT INTO Empleados(codEmpleado, codJefe, nombre, priApe, sueldo, dni) VALUES (3, 1, 'Tomas', 'Lopez', 4000, '87547563S');
INSERT INTO Empleados(codEmpleado, codJefe, nombre, priApe, sueldo, dni) VALUES (4, 2, 'Rodrigo', 'Sanz', 1500, '97565563S');
INSERT INTO Empleados(codEmpleado, codJefe, nombre, priApe, sueldo, dni) VALUES (5, 2, 'Teresa', 'Martin', 1500, '77667563S');

UPDATE Empleados SET priApe = 'Sainz' WHERE codEmpleado = 4;
UPDATE Empleados SET dni ='87547563A' WHERE codEmpleado = 3;
UPDATE Empleados SET sueldo = sueldo * 3 WHERE codEmpleado = 5;
UPDATE Empleados SET sueldo = sueldo + 150 WHERE codEmpleado = 2 OR codEmpleado = 3;
UPDATE Empleados SET sueldo = sueldo / 2 WHERE sueldo >= 1000 AND sueldo <=1500;

--UPDATE Empleados SET codEmpleado = 215 WHERE nombre = 'Ana'; /* No deja CASCADE DE MISMA FOREIGN KEY en la misma TABLA */ /* Cambiamos Ana en codJefe para todas las claves foraneas tenido ON UPDATE CASCADE*/
-- ALTERNATIVA
DELETE FROM Empleados WHERE dni = '87644565S';
INSERT INTO Empleados(codEmpleado, codJefe, nombre, priApe, sueldo, dni) VALUES (215, 1, 'Ana', 'Garcia', 4150, '87644565S');
UPDATE Empleados SET codJefe = 215 WHERE dni = '77667563S';
UPDATE Empleados SET codJefe = 215 WHERE dni = '97565563S';

DELETE FROM Empleados WHERE dni = '77667563S';

--UPDATE Empleados SET codEmpleado = codEmpleado + 1000; /* No deja CASCADE DE MISMA FOREIGN KEY en la misma TABLA */
-- ALTERNATIVA
DELETE FROM Empleados WHERE dni = '87644565S' OR dni = '76544565S';
UPDATE Empleados SET codEmpleado = codEmpleado + 1000;
INSERT INTO Empleados(codEmpleado, nombre, priApe, sueldo, dni) VALUES (1001, 'Jorge', 'Sanchez', 5000, '76544565S');
INSERT INTO Empleados(codEmpleado, codJefe, nombre, priApe, sueldo, dni) VALUES (1215, 1001, 'Ana', 'Garcia', 4150, '87644565S');
UPDATE Empleados SET codJefe = 1001 WHERE dni = '87547563S';
UPDATE Empleados SET codJefe = 1215 WHERE dni = '97565563S';

DELETE FROM Empleados WHERE dni = '87644565S';
UPDATE Empleados SET codJefe = 1001 WHERE dni = '97565563S';
