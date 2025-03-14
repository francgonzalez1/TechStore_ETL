USE [TechStore]
GO
/****** Object:  User [NT AUTHORITY\SYSTEM]    Script Date: 14/3/2025 17:42:40 ******/
CREATE USER [NT AUTHORITY\SYSTEM] FOR LOGIN [NT AUTHORITY\SYSTEM] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [SQLArcExtensionUserRole]    Script Date: 14/3/2025 17:42:40 ******/
CREATE ROLE [SQLArcExtensionUserRole]
GO
ALTER ROLE [SQLArcExtensionUserRole] ADD MEMBER [NT AUTHORITY\SYSTEM]
GO
/****** Object:  Table [dbo].[clientes]    Script Date: 14/3/2025 17:42:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clientes](
	[id_cliente] [int] NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[ciudad] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_clientes] PRIMARY KEY CLUSTERED 
(
	[id_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productos]    Script Date: 14/3/2025 17:42:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productos](
	[id_producto] [int] NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[precio] [decimal](18, 10) NOT NULL,
 CONSTRAINT [PK_productos] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ventas]    Script Date: 14/3/2025 17:42:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ventas](
	[id_venta] [int] NOT NULL,
	[id_cliente] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[cantidad] [decimal](18, 10) NOT NULL,
 CONSTRAINT [PK_ventas] PRIMARY KEY CLUSTERED 
(
	[id_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Tipo_Cliente]    Script Date: 14/3/2025 17:42:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Consultas para segmentar diferentes niveles de clientes en base a compras.

CREATE   VIEW [dbo].[vw_Tipo_Cliente] AS
WITH Compras_Cliente AS (
    SELECT 
        v.id_cliente,
        COUNT(v.id_venta) AS numero_compras,
        SUM(p.precio * v.cantidad) AS monto_total_ventas
    FROM Ventas v
    JOIN Productos p ON v.id_producto = p.id_producto
    GROUP BY v.id_cliente
)
SELECT 
    c.id_cliente,
    c.nombre,
    c.ciudad,
    COALESCE(cp.numero_compras, 0) AS numero_compras,
    COALESCE(cp.monto_total_ventas, 0) AS monto_total_ventas,
    CASE 
        WHEN COALESCE(cp.numero_compras, 0) = 5 THEN 'Leal'
        WHEN COALESCE(cp.numero_compras, 0) BETWEEN 3 AND 5 THEN 'Frecuente'
        WHEN COALESCE(cp.numero_compras, 0)  BETWEEN 1 AND 2 THEN 'Ocasional'
        ELSE 'Sin Compras'
    END AS tipo_cliente,
    LEFT(CAST(c.id_cliente AS VARCHAR(10)), 2) AS codigo_pais
FROM Clientes c
LEFT JOIN Compras_Cliente cp ON c.id_cliente = cp.id_cliente;
GO
/****** Object:  View [dbo].[vw_Codigo_Ciudad]    Script Date: 14/3/2025 17:42:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Clasificacion por tipo de Ciudad:

CREATE   VIEW [dbo].[vw_Codigo_Ciudad] AS
WITH Compras_Ciudad AS (
    SELECT 
        c.ciudad,
        COUNT(v.id_venta) AS total_compras,
        SUM(p.precio * v.cantidad) AS monto_total_ventas
    FROM Clientes c
    LEFT JOIN Ventas v ON c.id_cliente = v.id_cliente
    LEFT JOIN Productos p ON v.id_producto = p.id_producto
    GROUP BY c.ciudad
)
SELECT 
    cc.ciudad,
    COALESCE(cc.total_compras, 0) AS total_compras,
    COALESCE(cc.monto_total_ventas, 0) AS monto_total_ventas
FROM Compras_Ciudad cc;
GO
/****** Object:  Table [dbo].[Clientes_Clasificados]    Script Date: 14/3/2025 17:42:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes_Clasificados](
	[id_cliente] [int] NOT NULL,
	[nombre_cliente] [nvarchar](50) NOT NULL,
	[codigo_pais] [varchar](2) NULL,
	[numero_compras] [int] NULL,
	[monto_total_compras] [decimal](38, 20) NULL,
	[clasificacion] [varchar](9) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes_Frecuentes]    Script Date: 14/3/2025 17:42:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes_Frecuentes](
	[id_cliente] [int] NOT NULL,
	[nombre_cliente] [nvarchar](50) NOT NULL,
	[codigo_pais] [varchar](2) NULL,
	[numero_compras] [int] NULL,
	[monto_total_compras] [decimal](38, 20) NULL,
	[clasificacion] [varchar](9) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes_Ocasionales]    Script Date: 14/3/2025 17:42:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes_Ocasionales](
	[id_cliente] [int] NOT NULL,
	[nombre_cliente] [nvarchar](50) NOT NULL,
	[codigo_pais] [varchar](2) NULL,
	[numero_compras] [int] NULL,
	[monto_total_compras] [decimal](38, 20) NULL,
	[clasificacion] [varchar](9) NOT NULL
) ON [PRIMARY]
GO
