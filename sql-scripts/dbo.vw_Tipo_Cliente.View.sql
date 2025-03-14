USE [TechStore]
GO
/****** Object:  View [dbo].[vw_Tipo_Cliente]    Script Date: 13/3/2025 17:10:08 ******/
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
