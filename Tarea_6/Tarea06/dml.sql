use Tarea6
--a. Encontrar el nombre y la ciudad de todos los empleados que trabajan en
--  PEMEX.
SELECT nombre, e.ciudad
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

--C
SELECT nombre , apellidoPaterno, apellidoMaterno ,salarioQuincenal
FROM Empleado E JOIN Dirigir D on E.CURP = D.CURP JOIN Trabajar T on T.CURP = E.CURP

--d
SELECT E.CURP, E.nombre, E.apellidoPaterno, E.apellidoMaterno, E.genero,
        E.nacimiento, E.calle, E.num, E.ciudad, E.CP,D.fechaInicio
    FROM (Empleado E INNER JOIN Dirigir D ON E.CURP = D.CURP) INNER JOIN
        Empresa Em ON D.RFC = Em.RFC
    WHERE DATEPART(yyyy, D.fechaInicio) = 2018 AND
    (DATEPART(qq, D.fechaInicio) = 2 OR DATEPART(qq, D.fechaInicio) = 4);

-- e. Encontrar a todos los empleados que viven en la misma ciudad y en la misma
--  calle que su supervisor.
SELECT e.CURP,e.nombre,e.apellidoPaterno,e.apellidoMaterno
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

--G
SELECT nombre , apellidoPaterno , apellidoMaterno
FROM Empleado E JOIN Colaborar C on E.CURP = C.CURP JOIN Proyecto P on C.numProyecto = P.numProyecto JOIN Empresa Em on P.RFCEmpresa
= Em.RFC JOIN Trabajar T on Em.RFC != T.RFC AND E.CURP = T.CURP

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

 --K
 SELECT nombre, apellidoPaterno , apellidoMaterno , razonSocial,salarioQuincenal
 FROM Trabajar T JOIN (SELECT MAX(salarioQuincenal) as MaxSal , razonSocial FROM Empresa Em JOIN Trabajar T on T.RFC = Em.RFC
 GROUP BY razonSocial) as tempnew on T.salarioQuincenal = tempnew.MaxSal JOIN Empleado E on T.CURP = E.CURP

-- l
SELECT nombre, apellidoPaterno, apellidoMaterno, salarioQuincenal, AVG(T.salarioQuincenal) promedio_Salario
FROM Empleado E INNER JOIN Trabajar T ON E.CURP = T.CURP
GROUP BY nombre, apellidoPaterno, apellidoMaterno, salarioQuincenal 
HAVING T.salarioQuincenal > (SELECT AVG(salarioQuincenal) FROM trabajar)

--m. Encontrar la compañía que tiene menos empleados y listar toda la
--  información de los mismos.

SELECT razonSocial ,e.CURP, nombre, apellidoPaterno, apellidoMaterno, genero,
        nacimiento, e.calle, e.num, e.ciudad, CP
FROM Empleado e INNER JOIN Trabajar t ON t.CURP = e.CURP JOIN Empresa on t.RFC = Empresa.RFC
WHERE t.RFC = (SELECT TOP(1) a.RFC
    FROM (SELECT RFC, COUNT(CURP) AS c
            FROM Trabajar
            GROUP BY RFC) As a
    ORDER BY c ASC);

 --consulta n
 SELECT d.CURP, c.numProyecto, p.nombreProyecto, p.fechaInicio, p.fechaFin, p.RFCEmpresa
 FROM Dirigir as d
 JOIN Colaborar as c ON d.CURP = c.CURP
 JOIN Proyecto as p ON p.numProyecto = c.numProyecto

 --O
 SELECT razonSocial
 FROM (SELECT COUNT (ciudad) as Total
 FROM(SELECT DISTINCT ciudad
 FROM Empleado) as ciudades) as TotalCiudad
 JOIN
 (SELECT razonSocial , COUNT(ciudad) as TotalCiudades
 FROM(SELECT DISTINCT E.ciudad , razonSocial
 FROM Empleado E JOIN Trabajar T on E.CURP = T.CURP JOIN Empresa Em on Em.RFC = T.RFC)as Cuenta
 GROUP BY razonSocial) as CiudadesEmpresa ON TotalCiudad.Total = CiudadesEmpresa.TotalCiudades

--p 
SELECT E.CURP, E.nombre, E.apellidoPaterno, E.apellidoMaterno
    FROM Empleado E INNER JOIN Colaborar C ON E.CURP = C.CURP
        INNER JOIN Proyecto P ON C.numProyecto = P.numProyecto
        WHERE C.fechaFin < P.fechaFin;

-- q. Información de los empleados que no colaboran en ningún proyecto.
SELECT CURP, nombre, apellidoPaterno, apellidoMaterno, genero,
        nacimiento, calle, num, ciudad, CP
FROM Empleado 
WHERE CURP NOT IN (SELECT e.CURP FROM Empleado e JOIN Colaborar c ON e.CURP = c.CURP) 

--consulta r
SELECT e.RFC, e.razonSocial, e.calle, e.num, e.CPE
FROM Empresa as e
JOIN (
SELECT e2.ciudad, COUNT(e2.CURP) as empleados
FROM Empleado as e2
GROUP BY e2.ciudad) as em
ON e.ciudad = em.ciudad
WHERE em.empleados >= 2

--S
SELECT nombre, apellidoPaterno, apellidoMaterno, PR.nombreProyecto , numHoras
FROM Proyecto PR JOIN (SELECT top 1 COUNT(CURP) as Colaboradores , nombreProyecto FROM Colaborar C JOIN Proyecto P on C.numProyecto = P.numProyecto
GROUP BY nombreProyecto ORDER BY Colaboradores desc) as tempnew on PR.nombreProyecto = tempnew.nombreProyecto JOIN Colaborar C
on C.numProyecto = PR.numProyecto JOIN Empleado E on E.CURP = C.CURP

--t
SELECT E.CURP, E.nombre , E.apellidoPaterno , E.apellidoMaterno FROM Empleado E INNER JOIN Trabajar T ON E.CURP = T.CURP
WHERE DAY(E.nacimiento) = DAY(T.fechaIngreso) AND MONTH(E.nacimiento) = MONTH(t.fechaIngreso);


--u. Obtener una lista del número de empleados que supervisa cada supervisor.
SELECT s.CURPSupervisor AS CURP_Supervisor, COUNT(e.CURP) AS Supervisados
    FROM (Empleado e INNER JOIN Supervisar s ON e.CURP = s.CURPSupervisado)
        JOIN Empleado f ON s.CURPSupervisor = f.CURP
    GROUP BY s.CURPSupervisor;

--consultas v
SELECT e.nombre,e.apellidoPaterno,e.apellidoMaterno
FROM Empleado as e
JOIN Dirigir as d ON e.CURP = d.CURP
WHERE DATEDIFF(YEAR,e.nacimiento, GETDATE()) > 50

--W
SELECT nombre , apellidoPaterno , apellidoMaterno
FROM Empleado
WHERE apellidoPaterno LIKE '[A,D,G,J,L,P,R]%'

--x
SELECT nombreProyecto, E.RFC, COUNT(C.CURP) NUMERO_EMPLEADOS
FROM Proyecto P INNER JOIN Empresa E ON P.RFCEmpresa = E.RFC
INNER JOIN Colaborar C ON C.numProyecto = P.numProyecto
WHERE MONTH(P.fechaInicio) = 12
GROUP BY P.nombreProyecto, E.RFC;
