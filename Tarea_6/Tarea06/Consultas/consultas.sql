--a. Encontrar el nombre y la ciudad de todos los empleados que trabajan en
--  PEMEX.
SELECT nombre, ciudad
    FROM (Empleado e JOIN Trabajar t ON t.CURP = e.CURP) JOIN
            Empresa em ON t.RFC = em.RFC
    WHERE em.razonSocial = 'PEMEX';

--consulta b
SELECT e.nombre, e.ciudad, em.RFC, em.ciudad
FROM Empleado as e
JOIN (
SELECT t.CURP, t.RFC, ep.ciudad
FROM Trabajar as t
JOIN Empresa as ep
ON t.RFC = ep.RFC) as em
ON e.CURP = em.CURP
WHERE e.ciudad = em.ciudad

--d
SELECT * FROM Empleados E
INNER JOIN Dirigir D ON E.CURP = D.CURP
INNER JOIN Trabajar T ON T.CURP = D.CURP
INNER JOIN Empresa E ON D.RFC = E.RFC
INNER JOIN Colaborar C ON C.CURP = D.CURP
INNER JOIN Proyecto P ON C.numProyecto = P.numProyecto
INNER JOIN Supervisar S ON (S.CURPSupervisor = D.CURP
        OR S.CURPSupervisado = D.CURP);

-- e. Encontrar a todos los empleados que viven en la misma ciudad y en la misma
--  calle que su supervisor.
SELECT e.CURP
    FROM Empleado e INNER JOIN Supervisar s ON e.CURP = s.CURPSupervisado
        INNER JOIN Empleado es ON s.CURPSupervisor = es.CURP
    WHERE (e.CURP != es.CURP) AND (e.ciudad = es.ciudad) AND (e.calle) = es.calle;



--consulta f
SELECT em.razonSocial compañia, DATEPART(yyyy, t.fechaIngreso) año,
        DATEPART(q, t.fechaIngreso) trimestre, genero, COUNT(e.CURP) empleados
FROM (Empleado e JOIN Trabajar t ON t.CURP = e.CURP) JOIN
     Empresa em ON t.RFC = em.RFC
    GROUP BY em.razonSocial, DATEPART(yyyy, t.fechaIngreso),
            DATEPART(q, t.fechaIngreso), e.genero;

--h
SELECT razonSocial, MIN(salarioQuincenal) SALARIO_MINIMO, MAX(salarioQuincenal) SALARIO_MAXIMO, SUM(salarioQuincenal) TOTAL
FROM Empresa E INNER JOIN Trabajar T ON E.RFC = T.RFC
GROUP BY razonSocial;

-- i. Encontrar información de los empleados y número de horas que dedican a los
--  proyectos. Interesan aquellos empleados que colaboran en al menos dos
--  proyectos y en donde el número de horas que dediquen a algún proyecto sea
--  mayor a 20.
-- SELECT e.CURP, e.nombre, e.apellidoPaterno, e.apellidoMaterno
-- FROM Empleado e INNER JOIN Colaborar c ON e.CURP = c.CURP
-- WHERE DATEPART(hh, c.numHoras) > 20;
-- Esta consulta no se pudo hacer por conflictos con el formato.

--consulta j
SELECT em.razonSocial compañia, DATEPART(yyyy, t.fechaIngreso) año,
      DATEPART(q, t.fechaIngreso) trimestre, genero, COUNT(e.CURP) empleados
FROM (Empleado e JOIN Trabajar t ON t.CURP = e.CURP)
JOIN Empresa em ON t.RFC = em.RFC
GROUP BY em.razonSocial, DATEPART(yyyy, t.fechaIngreso),
         DATEPART(q, t.fechaIngreso), e.genero;


-- l
SELECT nombre, apellidoPaterno, apellidoMaterno, salarioQuincenal, AVG(T.salarioQuincenal) promedio_Salario
FROM Eempleado E INNER JOIN Trabajar T ON E.CURP = T.CURP
GROUP BY nombre, apellidoPaterno, apellidoMaterno, salarioQuincenal HAVING T.salarioQuincenal > (SELECT AVG(salarioQuincenal) FROM trabajar)

--m. Encontrar la compañía que tiene menos empleados y listar toda la
--  información de los mismos.
SELECT e.CURP, e.nombre, e.apellidoPaterno, e.apellidoMaterno, e.genero,
        e.nacimiento, e.calle, e.num, e.ciudad, e.CP
FROM Empleado e INNER JOIN Trabajar t ON t.CURP = e.CURP
WHERE t.RFC = (SELECT TOP(1) t.RFC
        FROM Trabajar t INNER JOIN Empresa m ON c.RFC = e.RFC INNER JOIN
            Empleado e ON t.CURP = e.CURP
        ORDER BY ASC(COUNT(e.RFC))
    );

 --consulta n
 SELECT d.CURP, c.numProyecto, p.nombreProyecto, p.fechaInicio, p.fechaFin, p.RFCEmpresa
 FROM Dirigir as d
 JOIN Colaborar as c ON d.CURP = c.CURP
 JOIN Proyecto as p ON p.numProyecto = c.numProyecto



--p
SELECT E.CURP FROM Empleado E INNER JOIN Colaborar C ON E.CURP = C.CURP
INNER JOIN Proyecto P ON C.numProyecto = P.numProyecto
WHERE C.fechaFin < P.fechaFin;

-- q. Información de los empleados que no colaboran en ningún proyecto.
SELECT e.CURP, e.nombre, e.apellidoPaterno, e.apellidoMaterno, e.genero,
        e.nacimiento, e.calle, e.num, e.ciudad, e.CP
    FROM


--consulta r
SELECT e.RFC, e.razonSocial, e.calle, e.num, e.CPE
FROM Empresa as e
JOIN (
SELECT e2.ciudad, COUNT(e2.CURP) as empleados
FROM Empleado as e2
GROUP BY e2.ciudad) as em
ON e.ciudad = em.ciudad
WHERE em.empleados >= 2

--t
SELECT E.CURP FROM Empleado E INNER JOIN Trabajar T ON E.CURP = T.CURP
WHERE DAY(E.nacimiento) = DAY(T.fechaIngreso) AND MONTH(E.nacimiento) = MONTH(t.fechaIngreso);


--u. Obtener una lista del número de empleados que supervisa cada supervisor.

--consultas v
SELECT e.CURP,e.nombre, DATEDIFF(YEAR,e.nacimiento, GETDATE()) AS años
FROM Empleado as e
JOIN Dirigir as d ON e.CURP = d.CURP
WHERE DATEDIFF(YEAR,GETDATE(), e.nacimiento) > 50

--x
SELECT nombreProyecto, E.RFC, COUNT(C.CURP) NUMERO_EMPLEADOS
FROM Proyecto P INNER JOIN Empresa E ON P.RFCEmpresa = E.RFC
INNER JOIN Colaborar C ON C.numProyecto = P.numProyecto
WHERE MONTH(P.fechaInicio) = 12
GROUP BY P.nombreProyecto, E.RFC;
