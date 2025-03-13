USE TechStore;

SELECT c.nombre AS Cliente, SUM(v.cantidad * p.precio) AS Total_Ventas
FROM Ventas v
JOIN Clientes c ON v.id_cliente = c.id_cliente
JOIN Productos p ON v.id_producto = p.id_producto
GROUP BY c.nombre;

