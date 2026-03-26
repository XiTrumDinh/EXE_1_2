-- =========================
-- PHẦN A: TRUY VẤN người ùng
-- Bảng: users
-- =========================

-- Câu 1: Lấy danh sách người dùng theo Alphabet (A → Z)
SELECT *
FROM users
ORDER BY user_name ASC;

-- Câu 2: Lấy 7 người dùng theo Alphabet (A → Z)
SELECT *
FROM users
ORDER BY user_name ASC
LIMIT 7;

-- Câu 3: Lấy danh sách người dùng có chữ 'a' trong tên
SELECT *
FROM users
WHERE user_name LIKE '%a%'
ORDER BY user_name ASC;

-- Câu 4: Lấy danh sách người dùng có tên bắt đầu bằng chữ 'm'
SELECT *
FROM users
WHERE user_name LIKE 'm%';

-- Câu 5: Lấy danh sách người dùng có tên kết thúc bằng chữ 'i'
SELECT *
FROM users
WHERE user_name LIKE '%i';

-- Câu 6: Lấy danh sách người dùng có email Gmail
SELECT *
FROM users
WHERE user_email LIKE '%@gmail.com';

-- Câu 7: Gmail + tên bắt đầu bằng 'm'
SELECT *
FROM users
WHERE user_email LIKE '%@gmail.com'
AND user_name LIKE 'm%';

-- Câu 8: Gmail + tên có chữ 'i' + độ dài > 5
SELECT *
FROM users
WHERE user_email LIKE '%@gmail.com'
AND user_name LIKE '%i%'
AND LENGTH(user_name) > 5;

-- Câu 9:
-- Tên có chữ 'a', độ dài từ 5 đến 9
-- Email Gmail
-- Trong phần tên email (trước @) có chữ 'i'
SELECT *
FROM users
WHERE user_name LIKE '%a%'
AND LENGTH(user_name) BETWEEN 5 AND 9
AND user_email LIKE '%i%@gmail.com';

-- Câu 10:
-- (Tên có 'a' và dài 5→9)
-- OR (Tên có 'i' và dài < 9)
-- OR (Email Gmail và có 'i' trong phần tên email)
SELECT *
FROM users
WHERE 
(
    user_name LIKE '%a%' 
    AND LENGTH(user_name) BETWEEN 5 AND 9
)
OR
(
    user_name LIKE '%i%' 
    AND LENGTH(user_name) < 9
)
OR
(
    user_email LIKE '%i%@gmail.com'
);
