USE TechStore;

SELECT c.nombre AS Cliente, COUNT(v.id_venta) AS Numero_Compras,
       CASE
           WHEN COUNT(v.id_venta) >= 5 THEN 'Frecuente'
           ELSE 'Ocasional'
       END AS Clasificacion
FROM Ventas v
JOIN Clientes c ON v.id_cliente = c.id_cliente
GROUP BY c.nombre;

