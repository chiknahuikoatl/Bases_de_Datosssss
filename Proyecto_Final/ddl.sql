USE master;

--IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = 'Taqueria')
--BEGIN
--	DROP DATABASE [Taqueria];
--END;
--GO

--CREATE DATABASE [Taqueria]
--ON PRIMARY
--(
--NAME = 'Taqueria',
--FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.EMILIANOFS\MSSQL\DATA\Taqueria.mdf',
--SIZE = 10MB,
--MAXSIZE = UNLIMITED,
--FILEGROWTH = 50 %
--)
--LOG ON
--(
--NAME = 'Taqueria_Log',
--FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.EMILIANOFS\MSSQL\DATA\Taqueria_Log.ldf',
--SIZE = 2MB,
--MAXSIZE = 100MB,
--FILEGROWTH = 2MB
--);
--GO
-- TODAVIA NO SE SI VAMOS A HACER LA BASE ASI , POR LO MIENTRAS PONGO EL QUE CREA LA BASE AQUI


CREATE TABLE Sucursal (
	idSucursal int UNIQUE NOT NULL,
	estado nvarchar(255) NOT NULL,
	calle nvarchar(255) NOT NULL,
	avenida nvarchar(255) NOT NULL,
	numExt int NOT NULL,
	CP nvarchar(5) NOT NULL,
	PRIMARY KEY (idSucursal),
	CONSTRAINT CP
	CHECK (CP LIKE '[0-9][0-9][0-9][0-9][0-9]')
);

CREATE TABLE Parrillero (
	CURP nchar(18) UNIQUE NOT NULL,
	RFC nvarchar(13) NOT NULL,
	idSucursal int NOT NULL,
	nombre nvarchar(255) NOT NULL,
	apellidoP nvarchar(255) NOT NULL,
	apellidoM nvarchar(255) NOT NULL,
	edad int NOT NULL,
	tipoSangre nchar(3) NOT NULL,
	fechaInicio datetime NOT NULL,
	numSeguridad int NOT NULL,
	nomina money NOT NULL,
	PRIMARY KEY (CURP),
	FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal),
	CONSTRAINT tipoSangre
	CHECK (tipoSangre LIKE 'A+,A-,B+,B-,O+,O-,AB+,AB-')
);

CREATE TABLE Mesero (
	CURP nchar(18) UNIQUE NOT NULL,
	RFC nvarchar(13) NOT NULL,
	idSucursal int NOT NULL,
	nombre nvarchar(255) NOT NULL,
	apellidoP nvarchar(255) NOT NULL,
	apellidoM nvarchar(255) NOT NULL,
	edad int NOT NULL,
	tipoSangre nchar(3) NOT NULL,
	fechaInicio datetime NOT NULL,
	numSeguridad int NOT NULL,
	nomina money NOT NULL,
	PRIMARY KEY (CURP),
	FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal),
	CONSTRAINT tipoSangre
	CHECK (tipoSangre LIKE 'A+,A-,B+,B-,O+,O-,AB+,AB-')
);

CREATE TABLE Cajero (
	CURP nchar(18) UNIQUE NOT NULL,
	RFC nvarchar(13) NOT NULL,
	idSucursal int NOT NULL,
	nombre nvarchar(255) NOT NULL,
	apellidoP nvarchar(255) NOT NULL,
	apellidoM nvarchar(255) NOT NULL,
	edad int NOT NULL,
	tipoSangre nchar(3) NOT NULL,
	fechaInicio datetime NOT NULL,
	numSeguridad int NOT NULL,
	nomina money NOT NULL,
	PRIMARY KEY (CURP),
	FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal),
	CONSTRAINT tipoSangre
	CHECK (tipoSangre LIKE 'A+,A-,B+,B-,O+,O-,AB+,AB-')
);

CREATE TABLE Taquero (
	CURP nchar(18) UNIQUE NOT NULL,
	RFC nvarchar(13) NOT NULL,
	idSucursal int NOT NULL,
	nombre nvarchar(255) NOT NULL,
	apellidoP nvarchar(255) NOT NULL,
	apellidoM nvarchar(255) NOT NULL,
	edad int NOT NULL,
	tipoSangre nchar(3) NOT NULL,
	fechaInicio datetime NOT NULL,
	numSeguridad int NOT NULL,
	nomina money NOT NULL,
	PRIMARY KEY (CURP),
	FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal),
	CONSTRAINT tipoSangre
	CHECK (tipoSangre LIKE 'A+,A-,B+,B-,O+,O-,AB+,AB-')
);

CREATE TABLE Repartidor (
	CURP nchar(18) UNIQUE NOT NULL,
	RFC nvarchar(13) NOT NULL,
	idSucursal int NOT NULL,
	nombre nvarchar(255) NOT NULL,
	apellidoP nvarchar(255) NOT NULL,
	apellidoM nvarchar(255) NOT NULL,
	edad int NOT NULL,
	tipoSangre nchar(3) NOT NULL,
	fechaInicio datetime NOT NULL,
	numSeguridad int NOT NULL,
	nomina money NOT NULL,
	numlic int NOT NULL,
	transporte nvarchar(255) NOT NULL, 
	PRIMARY KEY (CURP),
	FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal),
	CONSTRAINT tipoSangre
	CHECK (tipoSangre LIKE 'A+,A-,B+,B-,O+,O-,AB+,AB-')
);

CREATE TABLE BonoRepartidor (
	CURP nchar(18) UNIQUE NOT NULL,
	numBono int NOT NULL,
	FOREIGN KEY (CURP) REFERENCES Repartidor(CURP)
);
	
CREATE TABLE BonoParrillero (
	CURP nchar(18) UNIQUE NOT NULL,
	numBono int NOT NULL,
	FOREIGN KEY (CURP) REFERENCES Parrillero(CURP)
);

CREATE TABLE BonoMesero (
	CURP nchar(18) UNIQUE NOT NULL,
	numBono int NOT NULL,
	FOREIGN KEY (CURP) REFERENCES Mesero(CURP)
);

CREATE TABLE BonoCajero (
	CURP nchar(18) UNIQUE NOT NULL,
	numBono int NOT NULL,
	FOREIGN KEY (CURP) REFERENCES Cajero(CURP)
);

CREATE TABLE BonoTaquero (
	CURP nchar(18) UNIQUE NOT NULL,
	numBono int NOT NULL,
	FOREIGN KEY (CURP) REFERENCES Taquero(CURP)
);

CREATE TABLE ProductoPerecedor (
	idProducto int UNIQUE NOT NULL,
	nombreProducto nvarchar(255) NOT NULL,
	precio money,
	marca nvarchar(255) NOT NULL,
	PRIMARY KEY (idProducto)
);

CREATE TABLE ProductoNoPerecedor (
	idProducto int UNIQUE NOT NULL,
	nombreProducto nvarchar(255) NOT NULL,
	precio money,
	marca nvarchar(255) NOT NULL,
	fechaCaducidad datetime NOT NULL,
	PRIMARY KEY (idProducto)
);

CREATE TABLE SolicitarPrP (
	idSucursal int NOT NULL,
	idProducto int NOT NULL,
	cantidadProducto int NOT NULL,
	fechaCompra datetime NOT NULL
	FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal),
	FOREIGN KEY (idProducto) REFERENCES ProductoPerecedor(idProducto)
);

CREATE TABLE SolicitarPrNP (
	idSucursal int NOT NULL,
	idProducto int NOT NULL,
	cantidadProducto int NOT NULL,
	fechaCompra datetime NOT NULL
	FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal),
	FOREIGN KEY (idProducto) REFERENCES ProductoPerecedor(idProducto)
);

CREATE TABLE Proveedor (
	idProveedor int UNIQUE NOT NULL,
	nombreProveedor nvarchar(255) NOT NULL,
	PRIMARY KEY (idProveedor)
);

CREATE TABLE SurtirPrP (
	idProducto int NOT NULL,
	idProveedor int NOT NULL,
	FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor),
	FOREIGN KEY (idProducto) REFERENCES ProductoPerecedor(idProducto)
);

CREATE TABLE SurtirPrNP (
	idProducto int NOT NULL,
	idProveedor int NOT NULL,
	FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor),
	FOREIGN KEY (idProducto) REFERENCES ProductoNoPerecedor(idProducto)
);

CREATE TABLE ClienteDefault (
	idClienteD int UNIQUE NOT NULL,
	PRIMARY KEY (IdClienteD)
);

CREATE TABLE Pertenecer (
	idCliente int NOT NULL,
	idSucursal int NOT NULL,
	FOREIGN KEY (idCliente) REFERENCES ClienteDefault(idClienteD),
	FOREIGN KEY (idSucursal) REFERENCES Sucursal(idSucursal)
);

CREATE TABLE PedidoPersonalD (
	numPedidoPD int UNIQUE NOT NULL,
	idCliente int NOT NULL,
	fechaPedido datetime NOT NULL,
	formaPago nvarchar(255) NOT NULL
	PRIMARY KEY (numPedidoPD),
	FOREIGN KEY (idCliente) REFERENCES ClienteDefault(idClienteD)
);

CREATE TABLE PedidoDomicilioD (
	numPedidoDD int UNIQUE NOT NULL,
	idCliente int NOT NULL,
	fechaPedido datetime NOT NULL,
	formaPago nvarchar(255) NOT NULL,
	CURP nchar(18) NOT NULL,
	PRIMARY KEY (numPedidoDD),
	FOREIGN KEY (idCliente) REFERENCES ClienteDefault(idClienteD),
	FOREIGN KEY (CURP) REFERENCES Repartidor(CURP)
);

CREATE TABLE ClienteE (
	idClienteE int UNIQUE NOT NULL,
	nombre nvarchar(255) NOT NULL,
	calle nvarchar(255) NOT NULL,
	avenida nvarchar(255) NOT NULL,
	numExt int NOT NULL,
	CP nvarchar(5) NOT NULL,
	CONSTRAINT CP
	CHECK (CP LIKE '[0-9][0-9][0-9][0-9][0-9]'),
	PRIMARY KEY (IdClienteE)
);

CREATE TABLE TaqueroCorazon (
	idP int UNIQUE NOT NULL,
	idCliente int NOT NULL,
	FOREIGN KEY (idCliente) REFERENCES ClienteE(idClienteE)
);

CREATE TABLE PedidoPersonalE (
	numPedidoPE int UNIQUE NOT NULL,
	IdP int NOT NULL,
	idCliente int NOT NULL,
	fechaPedido datetime NOT NULL,
	formaPago nvarchar(255) NOT NULL
	PRIMARY KEY (numPedidoPE),
	FOREIGN KEY (idCliente) REFERENCES ClienteE(idClienteE),
	FOREIGN KEY (idP) REFERENCES TaqueroCorazon(idP)
);

CREATE TABLE PedidoDomicilioE (
	numPedidoDE int UNIQUE NOT NULL,
	idP int NOT NULL,
	idCliente int NOT NULL,
	fechaPedido datetime NOT NULL,
	formaPago nvarchar(255) NOT NULL,
	CURP nchar(18) NOT NULL,
	PRIMARY KEY (numPedidoDE),
	FOREIGN KEY (idCliente) REFERENCES ClienteE(idClienteE),
	FOREIGN KEY (CURP) REFERENCES Repartidor(CURP),
	FOREIGN KEY (idP) REFERENCES TaqueroCorazon(idP)
);

CREATE TABLE Platillo (
	idPlatillo int UNIQUE NOT NULL,
	nombrePlatillo nvarchar(255) NOT NULL,
	precioPlatillo money NOT NULL
	PRIMARY KEY (idPlatillo)
);

CREATE TABLE OrdenarPersonalD (
	idPlatillo int NOT NULL,
	numPedido int NOT NULL,
	cantidad int NOT NULL,
	FOREIGN KEY (idPlatillo) REFERENCES Platillo(idPlatillo),
	FOREIGN KEY (numPedido) REFERENCES PedidoPersonalD(numPedidoPD)
);

CREATE TABLE OrdenarDomicilioD (
	idPlatillo int NOT NULL,
	numPedido int NOT NULL,
	cantidad int NOT NULL,
	FOREIGN KEY (idPlatillo) REFERENCES Platillo(idPlatillo),
	FOREIGN KEY (numPedido) REFERENCES PedidoDomicilioD(numPedidoDD)
);

CREATE TABLE OrdenarPersonalE (
	idPlatillo int NOT NULL,
	numPedido int NOT NULL,
	cantidad int NOT NULL,
	FOREIGN KEY (idPlatillo) REFERENCES Platillo(idPlatillo),
	FOREIGN KEY (numPedido) REFERENCES PedidoPersonalE(numPedidoPE)
);

CREATE TABLE OrdenarDomicilioE (
	idPlatillo int NOT NULL,
	numPedido int NOT NULL,
	cantidad int NOT NULL,
	FOREIGN KEY (idPlatillo) REFERENCES Platillo(idPlatillo),
	FOREIGN KEY (numPedido) REFERENCES PedidoDomicilioE(numPedidoDE)
);

CREATE TABLE Ingredientes (
	idPlatillo int NOT NULL,
	ingrediente nvarchar(255) NOT NULL,
	FOREIGN KEY (idPlatillo) REFERENCES Platillo(idPlatillo)
);

CREATE TABLE Promocion (
	numPromo int UNIQUE NOT NULL,
	descuento int NOT NULL,
	condiciones nvarchar(255) NOT NULL,
	dia date NOT NULL,
	PRIMARY KEY (numPromo)
);

CREATE TABLE AplicarPromo (
	numPromo int NOT NULL,
	idPlatillo int NOT NULL,
	FOREIGN KEY (idPlatillo) REFERENCES Platillo(idPlatillo),
	FOREIGN KEY (numPromo) REFERENCES Promocion(numPromo)
);

CREATE TABLE Salsa (
	idSalsa int UNIQUE NOT NULL,
	nombreSalsa nvarchar(255) NOT NULL,
	nivelPicante nvarchar(255) NOT NULL,
	PRIMARY KEY (idSalsa)
);

CREATE TABLE Acompañar (
	idSalsa int NOT NULL,
	idPlatillo int NOT NULL,
	FOREIGN KEY (idSalsa) REFERENCES Salsa(idSalsa),
	FOREIGN KEY (idPlatillo) REFERENCES Platillo(idPlatillo)
);

CREATE TABLE IngredientesSalsa (
	idSalsa int NOT NULL,
	ingrediente nvarchar(255) NOT NULL,
	FOREIGN KEY (idSalsa) REFERENCES Salsa(idSalsa)
);

CREATE TABLE ComprarSalsaD (
	idCliente int NOT NULL,
	idSalsa int NOT NULL,
	presentacion int NOT NULL,
	FOREIGN KEY (idSalsa) REFERENCES Salsa(idSalsa),
	FOREIGN KEY (idCliente) REFERENCES ClienteDefault(idClienteD)
);

CREATE TABLE ComprarSalsaE (
	idCliente int NOT NULL,
	idSalsa int NOT NULL,
	presentacion int NOT NULL,
	FOREIGN KEY (idSalsa) REFERENCES Salsa(idSalsa),
	FOREIGN KEY (idCliente) REFERENCES ClienteE(idClienteE)
);