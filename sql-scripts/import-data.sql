USE TechStore;

-- Importar datos a la tabla Clientes
BULK INSERT Clientes
FROM 'C:\Users\frang\TechStore_ETL\data\clientes.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

-- Importar datos a la tabla Productos
BULK INSERT Productos
FROM 'C:\Users\frang\TechStore_ETL\data\productos.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

-- Importar datos a la tabla Ventas
BULK INSERT Ventas
FROM 'C:\Users\frang\TechStore_ETL\data\ventas.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
