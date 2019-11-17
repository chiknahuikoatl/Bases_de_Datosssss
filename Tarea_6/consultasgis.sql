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
SELECT em.razonSocial compañia, DATEPART(yyyy, t.fechaIngreso) año,
        DATEPART(q, t.fechaIngreso) trimestre, genero, COUNT(e.CURP) empleados
FROM (Empleado e JOIN Trabajar t ON t.CURP = e.CURP) JOIN
     Empresa em ON t.RFC = em.RFC
    GROUP BY em.razonSocial, DATEPART(yyyy, t.fechaIngreso),
            DATEPART(q, t.fechaIngreso), e.genero;

--consulta j
SELECT em.razonSocial compañia, DATEPART(yyyy, t.fechaIngreso) año,
      DATEPART(q, t.fechaIngreso) trimestre, genero, COUNT(e.CURP) empleados
FROM (Empleado e JOIN Trabajar t ON t.CURP = e.CURP)
JOIN Empresa em ON t.RFC = em.RFC
GROUP BY em.razonSocial, DATEPART(yyyy, t.fechaIngreso),
         DATEPART(q, t.fechaIngreso), e.genero;

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
