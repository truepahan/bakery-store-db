-- ============================================================
-- 03_sample_queries.sql — проверочные и примеры аналитических запросов
-- ============================================================

-- ---- Проверочные запросы из практической работы № 7 ----
SELECT * FROM product;
SELECT name, retail_price, barcode FROM product;
SELECT (full_name).last_name, (full_name).first_name, (full_name).middle_name, login FROM employee;

-- ---- Дополнительные примеры ----

-- Товары с категорией, производителем и единицей измерения
SELECT p.name AS product, c.name AS category, m.name AS manufacturer,
       u.short_name AS unit, p.retail_price
FROM product p
JOIN category c          ON c.id = p.category_id
LEFT JOIN manufacturer m ON m.id = p.manufacturer_id
JOIN unit u              ON u.id = p.unit_id
ORDER BY c.name, p.name;

-- Остатки по партиям с ближайшим сроком годности
SELECT p.name AS product, s.name AS store, st.quantity, st.expiration_date
FROM stock st
JOIN product p ON p.id = st.product_id
JOIN store s   ON s.id = st.store_id
ORDER BY st.expiration_date, p.name;

-- Выручка по магазинам и способам оплаты
SELECT s.name AS store, pt.name AS payment_type,
       COUNT(*) AS receipts, SUM(sa.total_amount) AS revenue
FROM sale sa
JOIN store s         ON s.id  = sa.store_id
JOIN payment_type pt ON pt.id = sa.payment_type_id
GROUP BY s.name, pt.name
ORDER BY revenue DESC;

-- Содержимое чеков (позиции продаж)
SELECT sa.id AS sale_id, sa.sale_date, p.name AS product,
       si.quantity, si.sale_price, si.quantity * si.sale_price AS line_total
FROM sale_item si
JOIN sale sa   ON sa.id = si.sale_id
JOIN stock st  ON st.id = si.stock_id
JOIN product p ON p.id = st.product_id
ORDER BY sa.id, p.name;
