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

--consulta f

SELECT t1.RFC, DATENAME(YEAR, t1.fechaIngreso) as Año, e.genero, t2.salarioPromedio
FROM Empleado as e
JOIN Trabajar as t1 ON t1.CURP = e.CURP
JOIN (
SELECT t.RFC, AVG(salarioQuincenal) as salarioPromedio
FROM Trabajar as t
GROUP BY t.RFC) as t2
ON t2.RFC = t1.RFC
--consulta j


--consulta n
SELECT d.CURP, c.numProyecto, p.nombreProyecto, p.fechaInicio, p.fechaFin, p.RFCEmpresa
FROM Dirigir as d
JOIN Colaborar as c ON d.CURP = c.CURP
JOIN Proyecto as p ON p.numProyecto = c.numProyecto

--consulta r
SELECT e.RFC, e.razonSocial, e.calle, e.num, e.CPE
FROM Empresa as e
JOIN (
SELECT e2.ciudad, COUNT(e2.CURP) as empleados
FROM Empleado as e2
GROUP BY e2.ciudad) as em
ON e.ciudad = em.ciudad
WHERE em.empleados >= 2

--consultas v
SELECT e.CURP,e.nombre, DATEDIFF(YEAR,e.nacimiento, GETDATE()) AS años
FROM Empleado as e
JOIN Dirigir as d ON e.CURP = d.CURP
WHERE DATEDIFF(YEAR,GETDATE(), e.nacimiento) > 50
