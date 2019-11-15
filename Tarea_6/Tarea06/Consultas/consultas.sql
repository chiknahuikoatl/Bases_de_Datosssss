--a. Encontrar el nombre y la ciudad de todos los empleados que trabajan en PEMEX.
SELECT nombre, ciudad
    FROM (Empleado e JOIN Trabajar t ON t.CURP = e.CURP) JOIN
            Empresa em ON t.RFC = em.RFC
    WHERE em.razonSocial = 'PEMEX';

-- f. Obtener una lista de cada compañía y el salario promedio que paga. La
--  información se debe mostrar por compañía, año, y género.


-- procedure
-- sadasduñisdcn

SELECT empresa, CASE genero
                    WHEN genero = 'M' THEN 'Masc',
                    ELSE 'Fem'
                  END AS Género,

    FROM (Empleado e JOIN Trabajar t ON t.CURP = e.CURP) JOIN
            Empresa em ON t.RFC = em.RFC
    GROUP BY em.razonSocial, AVG(t.salarioQuincenal),


SELECT empresa,
    FROM (Empleado e JOIN Trabajar t ON t.CURP = e.CURP) JOIN
            Empresa em ON t.RFC = em.RFC
    GROUP BY em.razonSocial, AVG(t.salarioQuincenal),

-- j. Encontrar la cantidad de empleados en cada compañía, por año, trimestre y
--  género.
SELECT compañia, año, trimestre, genero, COUNT(CURP)
    FROM (Empleado e JOIN Trabajar t ON t.CURP = e.CURP) JOIN
            Empresa em ON t.RFC = em.RFC
    GROUP BY em.razonSocial, e.genero


--nrv
