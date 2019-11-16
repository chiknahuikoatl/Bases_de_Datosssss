--Seleccionamos master para creación de base
USE Master;

-- --Validamos en sys si la base ya existe
-- PRINT N'Validamos si la base no existe';
-- IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = 'FBD2020-1-3815')
-- BEGIN
-- PRINT N'Borramos la base preexistente';
--
-- --Borramos la base si existe
-- DROP DATABASE [FBD2020-1-3815]
-- END;
-- GO
--
-- PRINT N'Creamos la base de datos';
-- --Creamos la base
-- CREATE DATABASE [FBD2020-1-3815]
-- ON PRIMARY
-- (
-- NAME = 'FBD2020-1-3815',
-- FILENAME = '/fbd/fundamentos/FBD2020-1-3815.mdf',
-- SIZE = 10MB,
-- MAXSIZE = UNLIMITED,
-- FILEGROWTH = 50%
-- )
-- LOG ON
-- (
-- NAME = 'FBD2020-1-3815_Log',
-- FILENAME = '/fbd/fundamentos/FBD2020-1-3815.ldf',
-- SIZE = 2MB,
-- MAXSIZE = 100MB,
-- FILEGROWTH = 2MB
-- );
-- PRINT N'Base de datos creada correctamente';
-- GO
--
-- USE [FBD2020-1-3815];
-- GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Empleado')
BEGIN
PRINT N'Borramos la tabla preexistente';
DROP TABLE Empleado;
END;
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Dirigir')
BEGIN
PRINT N'Borramos la tabla preexistente';
DROP TABLE Dirigir;
END;
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Trabajar')
BEGIN
PRINT N'Borramos la tabla preexistente';
DROP TABLE Trabajar;
END;
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Colaborar')
BEGIN
PRINT N'Borramos la tabla preexistente';
DROP TABLE Colaborar;
END;
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Supervisar')
BEGIN
PRINT N'Borramos la tabla preexistente';
DROP TABLE Supervisar;
END;
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Empresa')
BEGIN
PRINT N'Borramos la tabla preexistente';
DROP TABLE Empresa;
END;
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Proyecto')
BEGIN
PRINT N'Borramos la tabla preexistente';
DROP TABLE Proyecto;
END;
GO

--Creamos todas las tablas

CREATE TABLE Empleado (
  CURP nchar(18) UNIQUE NOT NULL,
  nombre nvarchar(255) NOT NULL,
  apellidoPaterno nvarchar(255) NOT NULL,
  apellidoMaterno nvarchar(255) NOT NULL,
  genero char(1) NULL,
  nacimiento date NOT NULL,
  calle nvarchar(255) NOT NULL,
  num int NOT NULL,
  ciudad nvarchar(255) NOT NULL,
  CP nvarchar(5) NOT NULL,
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
    CURPSupervidado nchar(18) UNIQUE NOT NULL,
  CURPSupervisor nchar(18) NOT NULL,
  PRIMARY KEY (CURPSupervidado)
);

CREATE TABLE Empresa (
  RFC nvarchar(13) UNIQUE NOT NULL,
  razonSocial nvarchar(255) NULL,
  calle nvarchar(255) NOT NULL,
  num int NOT NULL,
  CP nvarchar(5) NOT NULL,
  PRIMARY KEY (RFC),
  CONSTRAINT CP
  CHECK (CP LIKE '[0-9][0-9][0-9][0-9][0-9]')
);

CREATE TABLE Proyecto (
  numProyecto int UNIQUE NOT NULL,
  nombreProyecto nvarchar(255) NULL,
  fechaInicio date NOT NULL,
  fechaFin date NULL,
  RFCEmpresa nvarchar(13),
  PRIMARY KEY (numProyecto)
);

PRINT N'Tablas creadas exitosamente';
END;
GO
