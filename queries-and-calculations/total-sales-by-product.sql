USE TechStore;

SELECT p.nombre AS Producto, SUM(v.cantidad) AS Unidades_Vendidas, SUM(v.cantidad * p.precio) AS Total_Ventas
FROM Ventas v
JOIN Productos p ON v.id_producto = p.id_producto
GROUP BY p.nombre;

