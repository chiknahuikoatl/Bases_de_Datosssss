--a. Encontrar el nombre y la ciudad de todos los empleados que trabajan en
--  PEMEX.
SELECT nombre, ciudad
    FROM (Empleado e JOIN Trabajar t ON t.CURP = e.CURP) JOIN
            Empresa em ON t.RFC = em.RFC
    WHERE em.razonSocial = 'PEMEX';

-- f. Obtener una lista de cada compañía y el salario promedio que paga. La
--  información se debe mostrar por compañía, año, y género.

SELECT em.razonSocial empresa, genero, DATEPART(y, t.fechaIngreso),
        AVG(t.salarioQuincenal)
    FROM (Empleado e JOIN Trabajar t ON t.CURP = e.CURP) JOIN
            Empresa em ON t.RFC = em.RFC
    GROUP BY em.razonSocial, genero, YEAR(t.fechaIngreso);


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

SELECT p.numProyecto, p.nombreProyecto, p.fechaInicio, p.fechaFin, p.RFCEmpresa
    FROM (Dirigir d INNER JOIN Colaborar c ON d.CURP = c.CURP) INNER JOIN
            Proyecto p ON p.numProyecto = c.numProyecto

-- r. Encontrar la información de las compañías que tienen al menos dos
--  empleados en la misma ciudad en que tienen sus instalaciones.

SELECT m.RFC, m.razonSocial, m.ciudad, m.calle, m.num, m.CP
    FROM (Empleado e INNER JOIN Trabajar t ON e.CURP = t.CURP) INNER JOIN
            Empresa m ON t.RFC = t.RFC
    GROUP BY e.Ciudad
    HAVING COUNT(e.Ciudad > 1)


--v
