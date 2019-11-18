--DROP TABLE Empleado;
--DROP TABLE Dirigir;
--DROP TABLE Trabajar;
--DROP TABLE Colaborar;
--DROP TABLE Supervisar;
--DROP TABLE Empresa;
--DROP TABLE Proyecto;

--Seleccionamos master para creación de base
USE master;


--Creamos todas las tablas

CREATE TABLE Empleado (
  nombre nvarchar(255) NOT NULL,
  apellidoPaterno nvarchar(255) NOT NULL,
  apellidoMaterno nvarchar(255) NOT NULL,
  genero char(1) NULL,
  nacimiento date NOT NULL,
  calle nvarchar(255) NOT NULL,
  num int NOT NULL,
  ciudad nvarchar(255) NOT NULL,
  CP nvarchar(5) NOT NULL,
  CURP nchar(18) UNIQUE NOT NULL,
  PRIMARY KEY (CURP),
  CONSTRAINT genero
  CHECK (genero IN ('M', 'F')),
  CONSTRAINT CP
  CHECK (CP LIKE '[0-9][0-9][0-9][0-9][0-9]')
);

CREATE TABLE Dirigir (
  CURP nchar(18) UNIQUE NOT NULL,
  RFC nvarchar(13) NOT NULL,
  fechaInicio date NOT NULL
  PRIMARY KEY (CURP)
);

CREATE TABLE Trabajar (
  CURP nchar(18) UNIQUE NOT NULL,
  RFC nvarchar(13) NOT NULL,
  salarioQuincenal int NULL,
  fechaIngreso date NOT NULL
  PRIMARY KEY (CURP)
);

CREATE TABLE Colaborar (
  CURP nchar(18) UNIQUE NOT NULL,
  numProyecto int NOT NULL,
  fechaInicio date NOT NULL,
  fechaFin date NULL,
  numHoras datetime NULL
  PRIMARY KEY (CURP)
);

CREATE TABLE Supervisar (
  CURPSupervisado nchar(18) UNIQUE NOT NULL,
  CURPSupervisor nchar(18) NOT NULL,
  PRIMARY KEY (CURPSupervisado)
);

CREATE TABLE Empresa (
  RFC nvarchar(13) UNIQUE NOT NULL,
  razonSocial nvarchar(255) NULL,
  calle nvarchar(255) NOT NULL,
  num int NOT NULL,
  ciudad nvarchar(255) NOT NULL,
  CPE nvarchar(5) NOT NULL,
  PRIMARY KEY (RFC),
  CONSTRAINT CPE
  CHECK (CPE LIKE '[0-9][0-9][0-9][0-9][0-9]')
);

CREATE TABLE Proyecto (
  numProyecto int UNIQUE NOT NULL,
  nombreProyecto nvarchar(255) NULL,
  fechaInicio date NOT NULL,
  fechaFin date NULL,
  RFCEmpresa nvarchar(13),
  PRIMARY KEY (numProyecto)
);
