--a. Encontrar el nombre y la ciudad de todos los empleados que trabajan en PEMEX.
SELECT nombre, ciudad
    FROM (Empleado e JOIN Trabajar t ON t.CURP = e.CURP) JOIN
            Empresa em ON t.RFC = em.RFC
    WHERE em.razonSocial = 'PEMEX';

-- f. Obtener una lista de cada compañía y el salario promedio que paga. La
--  información se debe mostrar por compañía, año, y género.

SELECT empresa, CASE genero
                    WHEN genero = 'M' THEN 'Masc',
                    ELSE 'Fem'
                  END AS Género,
        año
    FROM (Empleado e JOIN Trabajar t ON t.CURP = e.CURP) JOIN
            Empresa em ON t.RFC = em.RFC
    GROUP BY em.razonSocial, AVG(t.salarioQuincenal), YEAR(t.fechaIngreso);


-- j. Encontrar la cantidad de empleados en cada compañía, por año, trimestre y
--  género.
SELECT compañia, DATEPART(y, t.fechaIngreso) año,
        DATEPART(qq, t.fechaIngreso) trimestre, genero, COUNT(CURP)
    FROM (Empleado e JOIN Trabajar t ON t.CURP = e.CURP) JOIN
            Empresa em ON t.RFC = em.RFC
    GROUP BY em.razonSocial, DATEPART(y, t.fechaIngreso),
            DATEPART(qq, t.fechaIngreso), e.genero;

--n. Información de los proyectos en los que colaboran los empleados que son
--  directores.

SELECT
    FROM (Dirigir d INNER JOIN Colaborar c ON d.CURP = c.CURP) INNER JOIN
            Proyecto p ON p.numProyecto = c.numProyecto
    WHERE


--rv
