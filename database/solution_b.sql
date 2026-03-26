-- =========================
-- PHẦN B: TRUY VẤN ĐƠN HÀNG
-- =========================

-- Câu 1:
-- Liệt kê: mã user, tên user, mã đơn hàng
SELECT u.user_id, u.user_name, o.order_id
FROM users u
JOIN orders o ON u.user_id = o.user_id;

-- Câu 2:
-- Số lượng đơn hàng của mỗi user
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS total_orders
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name;

-- Câu 3:
-- Mã đơn hàng, số sản phẩm
SELECT o.order_id, COUNT(od.product_id) AS total_products
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id;

-- Câu 4:
-- Thông tin mua hàng: user + đơn + tên sản phẩm
SELECT u.user_id, u.user_name, o.order_id, p.product_name
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
ORDER BY o.order_id;

-- Câu 5:
-- Top 7 user có nhiều đơn hàng nhất
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS total_orders
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name
ORDER BY total_orders DESC
LIMIT 7;

-- Câu 6:
-- User mua sản phẩm có tên Samsung hoặc Apple
SELECT u.user_id, u.user_name, o.order_id, p.product_name
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name LIKE '%Samsung%'
   OR p.product_name LIKE '%Apple%';

-- Câu 7:
-- Tổng tiền mỗi đơn hàng
SELECT u.user_id, u.user_name, o.order_id,
       SUM(p.product_price) AS total_price
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY u.user_id, u.user_name, o.order_id;

-- Câu 8:
-- Mỗi user lấy đơn có tổng tiền lớn nhất
SELECT *
FROM (
    SELECT u.user_id, u.user_name, o.order_id,
           SUM(p.product_price) AS total_price
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) t
WHERE total_price = (
    SELECT MAX(total_price)
    FROM (
        SELECT SUM(p.product_price) AS total_price
        FROM orders o
        JOIN order_details od ON o.order_id = od.order_id
        JOIN products p ON od.product_id = p.product_id
        WHERE o.user_id = t.user_id
        GROUP BY o.order_id
    ) x
);

-- Câu 9:
-- Mỗi user lấy đơn có tổng tiền nhỏ nhất + số sản phẩm
SELECT *
FROM (
    SELECT u.user_id, u.user_name, o.order_id,
           SUM(p.product_price) AS total_price,
           COUNT(p.product_id) AS total_products
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) t
WHERE total_price = (
    SELECT MIN(total_price)
    FROM (
        SELECT SUM(p.product_price) AS total_price
        FROM orders o
        JOIN order_details od ON o.order_id = od.order_id
        JOIN products p ON od.product_id = p.product_id
        WHERE o.user_id = t.user_id
        GROUP BY o.order_id
    ) x
);

-- Câu 10:
-- Mỗi user lấy đơn có số sản phẩm nhiều nhất
SELECT *
FROM (
    SELECT u.user_id, u.user_name, o.order_id,
           SUM(p.product_price) AS total_price,
           COUNT(p.product_id) AS total_products
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) t
WHERE total_products = (
    SELECT MAX(total_products)
    FROM (
        SELECT COUNT(p.product_id) AS total_products
        FROM orders o
        JOIN order_details od ON o.order_id = od.order_id
        JOIN products p ON od.product_id = p.product_id
        WHERE o.user_id = t.user_id
        GROUP BY o.order_id
    ) x
);