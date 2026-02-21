--sorgular
SELECT p.post_id, pi.post_item_id, pi.item_type, pi.color
FROM Post p
JOIN PostItem pi ON p.post_id = pi.post_id
WHERE p.post_id

SELECT post_id, post_date, caption
FROM Post
WHERE user_id = 1;

SELECT p.post_id, COUNT(pi.post_item_id) AS item_count
FROM Post p
JOIN PostItem pi ON p.post_id = pi.post_id
GROUP BY p.post_id;

SELECT o.user_id, SUM(o.total_amount) AS total_spent
FROM "Order" o
GROUP BY o.user_id;

SELECT s.seller_id, SUM(s.quantity) AS total_stock
FROM Stock s
GROUP BY s.seller_id;

SELECT pi.post_item_id,pi.item_type,pv.variant_id,pv.color,m.method,m.match_score
FROM PostItem pi
JOIN Matching m ON pi.post_item_id = m.post_item_id
JOIN ProductVariant pv ON m.variant_id = pv.variant_id
WHERE pi.post_id = 1;

SELECT variant_id,price
FROM ProductVariant
ORDER BY price DESC
LIMIT 5;

SELECT variant_id,quantity
FROM Stock
WHERE quantity < 35

SELECT user_id, username
FROM "User"
WHERE user_id NOT IN (
    SELECT DISTINCT user_id
    FROM "Order"
);

SELECT variant_id
FROM ProductVariant
WHERE variant_id NOT IN (
    SELECT DISTINCT variant_id
    FROM OutfitItem
);

SELECT user_id, total_amount
FROM "Order"
WHERE total_amount = (
    SELECT MAX(total_amount)
    FROM "Order"
);

SELECT variant_id, price
FROM ProductVariant
WHERE variant_id IN (
    SELECT DISTINCT variant_id
    FROM OrderItem
);

DELETE

DELETE FROM "Order"
WHERE order_id = 13;

DELETE FROM OrderItem
WHERE order_id = 13;

 UPDATELER:
 
UPDATE Stock
SET quantity = quantity + (
    SELECT quantity
    FROM OrderItem
    WHERE order_id = 13
      AND variant_id = Stock.variant_id
)
WHERE variant_id IN (
    SELECT variant_id
    FROM OrderItem
    WHERE order_id = 13
);

UPDATE ProductVariant
SET price = 329.99
WHERE variant_id = 10;

 TRIGGERLER :
  
 NEGATİF STOK ENGELLEYEN:
CREATE OR REPLACE FUNCTION prevent_negative_stock()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.quantity < 0 THEN
        RAISE EXCEPTION 'Stok miktarı 0 altına düşemez';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
CREATE TRIGGER trg_prevent_negative_stock
BEFORE UPDATE ON Stock
FOR EACH ROW
EXECUTE FUNCTION prevent_negative_stock();

UPDATE Stock
SET quantity = -1
WHERE variant_id = 1; #TEST

---------------------------------------

SİPARİŞ EKLENİNCE STOK AZALTAN :

CREATE OR REPLACE FUNCTION reduce_stock_after_order()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Stock
    SET quantity = quantity - NEW.quantity
    WHERE variant_id = NEW.variant_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON OrderItem
FOR EACH ROW
EXECUTE FUNCTION reduce_stock_after_order();

---------------------------------------

SİPARİŞ SİLİNİNCE STOK GERİ ALAN :

CREATE OR REPLACE FUNCTION restore_stock_after_cancel()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Stock
    SET quantity = quantity + OLD.quantity
    WHERE variant_id = OLD.variant_id;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_restore_stock
AFTER DELETE ON OrderItem
FOR EACH ROW
EXECUTE FUNCTION restore_stock_after_cancel()

---------------------------------------

SİPARİŞ TOPLAM TUTARINI OTAMATİK GÜNCELLEYEN:

CREATE OR REPLACE FUNCTION update_order_total()
RETURNS TRIGGER AS $$
DECLARE
    oid INT;
BEGIN
    oid := COALESCE(NEW.order_id, OLD.order_id);

    UPDATE "Order"
    SET total_amount = (
        SELECT COALESCE(SUM(quantity * price_at_purchase), 0)
        FROM OrderItem
        WHERE order_id = oid
    )
    WHERE order_id = oid;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_order_total_after_insert
AFTER INSERT ON OrderItem
FOR EACH ROW
EXECUTE FUNCTION update_order_total();

CREATE TRIGGER trg_update_order_total_after_delete
AFTER DELETE ON OrderItem
FOR EACH ROW
EXECUTE FUNCTION update_order_total();


-----------------------------------------------


AYNI SİPARİŞE AYNI ÜRÜNÜ ENGELLEYEN TRIGGER:

CREATE OR REPLACE FUNCTION prevent_duplicate_order_item()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM OrderItem
        WHERE order_id = NEW.order_id
          AND variant_id = NEW.variant_id
    ) THEN
        RAISE EXCEPTION 'Bu ürün bu siparişte zaten mevcut';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_prevent_duplicate_order_item
BEFORE INSERT ON OrderItem
FOR EACH ROW
EXECUTE FUNCTION prevent_duplicate_order_item()



--------------------------------------------

POST SİLİNİNCE POST ITEMLERİ TEMİZLEYEN TRİGGER:
CREATE OR REPLACE FUNCTION delete_post_items_after_post()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM PostItem
    WHERE post_id = OLD.post_id;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_delete_post_items
AFTER DELETE ON Post
FOR EACH ROW
EXECUTE FUNCTION delete_post_items_after_post();

Viewler :

Kullanıcıların sistem üzerinden yaptığı toplam harcamalar:

CREATE VIEW vw_user_total_spending AS
SELECT 
    u.user_id,
    u.username,
    SUM(o.total_amount) AS total_spent
FROM "User" u
JOIN "Order" o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username;

SELECT * FROM vw_user_total_spending;


---------------------------------------

Siparişlerin ürün bazlı detayları raporlanmıştır

CREATE OR REPLACE VIEW vw_order_details AS
SELECT 
    o.order_id,
    o.user_id,
    oi.variant_id,
    oi.quantity,
    oi.price_at_purchase,
    (oi.quantity * oi.price_at_purchase) AS line_total
FROM "Order" o
JOIN OrderItem oi ON o.order_id = oi.order_id;

SELECT * FROM vw_order_details
WHERE order_id = 1;

SELECT * FROM vw_order_details
WHERE order_id = 10;

SELECT * FROM vw_order_details
WHERE order_id = 2;

-----------------------------------------------

Ürün stok seviyeleri durumlarına göre sınıflandırılmıştır

CREATE OR REPLACE VIEW vw_stock_status AS
SELECT 
    s.variant_id,
    s.quantity,
    CASE 
        WHEN s.quantity < 5 THEN 'Kritik'
        WHEN s.quantity BETWEEN 5 AND 20 THEN 'Orta'
        ELSE 'Yeterli'
    END AS stock_status
FROM Stock s;

SELECT * FROM vw_stock_status;


----------------------------------------
Ürün eşleştirme yöntemlerinin ortalama başarı skorları analiz edilmiştir


CREATE OR REPLACE VIEW vw_matching_method_performance AS
SELECT 
    method,
    AVG(match_score) AS avg_score,
    COUNT(*) AS usage_count
FROM Matching
GROUP BY method;

SELECT *
FROM vw_matching_method_performance
ORDER BY avg_score DESC;


Stored procedure :

Bir kullanıcının kaç siparişi oldugunu bulur
CREATE OR REPLACE PROCEDURE get_user_order_count(
    p_user_id INT,
    OUT order_count INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*)
    INTO order_count
    FROM "Order"
    WHERE user_id = p_user_id;
END;
$$;

CALL get_user_order_count(1,NULL);

-----------------------------------------

Satıcının ratingini güncelle
CREATE OR REPLACE PROCEDURE update_seller_rating(
    p_seller_id INT,
    p_new_rating NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Seller
    SET rating = p_new_rating
    WHERE seller_id = p_seller_id;
END;
$$;

CALL update_seller_rating(3, 4.8);


----------------------------------------------
Bir orderin toplam tutarını günceller
DROP PROCEDURE IF EXISTS update_order_total(INT, NUMERIC);

CREATE PROCEDURE update_order_total(
    IN p_order_id INT,
    INOUT p_total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "Order"
    SET total_amount = p_total
    WHERE order_id = p_order_id;
END;
$$;

CALL update_order_total(3, 750.00);


-----------------------------------------

Bir karttaki ürün sayısını bulmak

CREATE OR REPLACE PROCEDURE get_cart_item_count(
    p_cart_id INT,
    OUT item_count INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*)
    INTO item_count
    FROM CartItem
    WHERE cart_id = p_cart_id;
END;
$$;

CALL get_cart_item_count(2);