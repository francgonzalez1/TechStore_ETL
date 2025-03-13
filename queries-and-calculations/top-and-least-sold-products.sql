

SELECT p.nombre AS Producto, SUM(v.cantidad) AS Total_Unidades,
       CASE
           WHEN SUM(v.cantidad) >= 50 THEN 'Top Vendido'
           ELSE 'Menos Vendido'
       END AS Clasificacion
FROM Ventas v
JOIN Productos p ON v.id_producto = p.id_producto
GROUP BY p.nombre;
