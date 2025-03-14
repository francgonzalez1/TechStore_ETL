USE [TechStore]
GO
/****** Object:  View [dbo].[vw_Codigo_Ciudad]    Script Date: 13/3/2025 17:10:08 ******/
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
