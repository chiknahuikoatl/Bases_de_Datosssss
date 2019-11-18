use Tarea6
--C
SELECT nombre , apellidoPaterno, apellidoMaterno ,salarioQuincenal
FROM Empleado E JOIN Dirigir D on E.CURP = D.CURP JOIN Trabajar T on T.CURP = E.CURP
--G
SELECT nombre , apellidoPaterno , apellidoMaterno 
FROM Empleado E JOIN Colaborar C on E.CURP = C.CURP JOIN Proyecto P on C.numProyecto = P.numProyecto JOIN Empresa Em on P.RFCEmpresa
= Em.RFC JOIN Trabajar T on Em.RFC != T.RFC AND E.CURP = T.CURP
--K
SELECT nombre, apellidoPaterno , apellidoMaterno , razonSocial,salarioQuincenal
FROM Trabajar T JOIN (SELECT MAX(salarioQuincenal) as MaxSal , razonSocial FROM Empresa Em JOIN Trabajar T on T.RFC = Em.RFC 
GROUP BY razonSocial) as tempnew on T.salarioQuincenal = tempnew.MaxSal JOIN Empleado E on T.CURP = E.CURP 
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
--S
SELECT nombre, apellidoPaterno, apellidoMaterno, PR.nombreProyecto , numHoras
FROM Proyecto PR JOIN (SELECT top 1 COUNT(CURP) as Colaboradores , nombreProyecto FROM Colaborar C JOIN Proyecto P on C.numProyecto = P.numProyecto 
GROUP BY nombreProyecto ORDER BY Colaboradores desc) as tempnew on PR.nombreProyecto = tempnew.nombreProyecto JOIN Colaborar C
on C.numProyecto = PR.numProyecto JOIN Empleado E on E.CURP = C.CURP
--W
SELECT nombre , apellidoPaterno , apellidoMaterno
FROM Empleado
WHERE apellidoPaterno LIKE '[A,D,G,J,L,P,R]%'

