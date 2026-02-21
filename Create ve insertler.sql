CREATE TABLE "Order" (
    order_id integer NOT NULL,
    user_id integer,
    order_date date,
    total_amount numeric(10,2)
);

CREATE TABLE "User" (
    user_id integer NOT NULL,
    username character varying(50),
    email character varying(100),
    password character varying(100),
    created_at date
);
CREATE TABLE corporateseller (
seller_id integer NOT NULL,
    company_name character varying(150),
    tax_no character varying(20)
);
CREATE TABLE individualseller (
    seller_id integer NOT NULL,
    tc_no character varying(11)
);
CREATE TABLE matching (
    match_id integer NOT NULL,
    post_item_id integer,
    variant_id integer,
    match_score numeric(3,2),
    method character varying(50)
);
CREATE TABLE orderitem (
    order_id integer NOT NULL,
    variant_id integer NOT NULL,
    quantity integer,
    price_at_purchase numeric(10,2)
);
CREATE TABLE outfit (
    outfit_id integer NOT NULL,
    user_id integer,
    created_at date
);
CREATE TABLE outfititem (
    outfit_id integer NOT NULL,
    variant_id integer NOT NULL
);
CREATE TABLE payment (
    payment_id integer NOT NULL,
    order_id integer,
    payment_type character varying(50),
    payment_date date,
    amount numeric(10,2),
    payment_method character varying(20),
    status character varying(20)
);
CREATE TABLE post (
    post_id integer NOT NULL,
    user_id integer,
    post_date date,
    caption text
);
CREATE TABLE postitem (
    post_item_id integer NOT NULL,
    post_id integer,
    item_type character varying(50),
    color character varying(30)
);
CREATE TABLE posttag (
    post_id integer NOT NULL,
    tag_id integer NOT NULL
);
CREATE TABLE product (
    product_id integer NOT NULL,
    product_name character varying(150),
    category character varying(100)
); 
CREATE TABLE productvariant (
    variant_id integer NOT NULL,
    product_id integer,
    size character varying(20),
    color character varying(30),
    price numeric(10,2)
);
CREATE TABLE seller (
    seller_id integer NOT NULL,
    seller_name character varying(100),
    rating numeric(2,1)
);
CREATE TABLE stock (
    stock_id integer NOT NULL,
    seller_id integer,
    variant_id integer,
    quantity integer
);
CREATE TABLE subscription (
    subscription_id integer NOT NULL,
    user_id integer,
    start_date date,
    end_date date,
    plan_id integer,
    status character varying(20)
);
CREATE TABLE subscriptionplan (
    plan_id integer NOT NULL,
    plan_name character varying(50),
    duration_month integer,
    price numeric(10,2)
);
CREATE TABLE tag (
    tag_id integer NOT NULL,
    tag_name character varying(50)
);
 INSERT INTO "Order" (order_id, user_id, order_date, total_amount) VALUES
(4, 4, '2025-03-04', 449.99),
(5, 5, '2025-03-05', 1199.99),
(6, 6, '2025-03-06', 179.99),
(7, 7, '2025-03-07', 2249.98),
(8, 8, '2025-03-08', 299.99),
(9, 9, '2025-03-09', 899.99),
(10, 10, '2025-03-10', 549.99),
(11, 1, '2025-03-11', 1149.98),
(12, 2, '2025-03-12', 649.99),
(14, 4, '2025-03-14', 1699.98),
(15, 5, '2025-03-15', 649.98),
(2, 2, '2025-03-02', 1299.97),
(1, 1, '2025-03-01', 2499.96),
(3, 3, '2025-03-03', 750.00);

INSERT INTO "User" (user_id, username, email, password, created_at) VALUES
(1, 'zeynep', 'zeynep@mail.com', '12345', '2025-01-01'),
(2, 'ayse', 'ayse@mail.com', 'abcde', '2025-01-05'),
(3, 'zeynep', 'zeynep@mail.com', 'zeynep123', '2025-01-03'),
(4, 'elif', 'elif@mail.com', 'eliff123', '2025-06-04'),
(5, 'melisa', 'melisa@mail.com', 'melissa3', '2025-09-05'),
(6, 'ece', 'ece@mail.com', 'ecoss', '2025-01-06'),
(7, 'selin', 'selin@mail.com', '12345', '2026-01-01'),
(8, 'burcu', 'burcu@mail.com', 'burcuuu2', '2024-12-08'),
(9, 'irem', 'irem@mail.com', 'iremcik', '2025-04-09'),
(10, 'deniz', 'deniz@mail.com', 'sea', '2023-09-10');


INSERT INTO corporateseller (seller_id, tax_no) VALUES
(6, '9991112223'),
(7, '9991112224'),
(8, '9991112225'),
(9, '9991112226'),
(10,'9991112227');

INSERT INTO individualseller (seller_id, tc_no) VALUES
(1, '11111111111'),
(2, '22222222222'),
(3, '33333333333'),
(4, '44444444444'),
(5, '55555555555');


INSERT INTO Matching (match_id, post_item_id, variant_id, match_score, method) VALUES
(21, 1, 11, 0.87, 'Renk'),
(22, 1, 12, 0.82, 'Kategori'),
(23, 2, 13, 0.90, 'Renk + Kategori'),
(24, 2, 14, 0.78, 'Yapay Zeka'),
(25, 3, 15, 0.94, 'Görsel Tanıma'),
(26, 3, 16, 0.80, 'Kategori'),
(27, 4, 17, 0.88, 'Yapay Zeka'),
(28, 4, 18, 0.76, 'Renk'),
(29, 5, 19, 0.91, 'Hibrit'),
(30, 5, 20, 0.83, 'Kategori'),
(31, 6, 1,  0.89, 'Renk'),
(32, 6, 2,  0.84, 'Yapay Zeka'),
(33, 7, 3,  0.92, 'Görsel Tanıma'),
(34, 7, 4,  0.79, 'Kategori'),
(35, 8, 5,  0.86, 'Renk'),
(36, 8, 6,  0.81, 'Hibrit'),
(37, 9, 7,  0.90, 'Yapay Zeka'),
(38, 9, 8,  0.88, 'Görsel Tanıma'),
(39, 10, 9, 0.85, 'Kategori'),
(40, 10, 10,0.93, 'Renk + Kategori');

INSERT INTO productvariant (variant_id, product_id, size, color, price) VALUES
(1, 1, 'M', 'Siyah', 799.99),
(2, 2, 'L', 'Bej', 999.99),
(3, 3, 'M', 'Lacivert', 699.99),
(4, 4, 'S', 'Kırmızı', 499.99),
(5, 5, 'M', 'Beyaz', 400.00),
(6, 6, 'L', 'Gri', 299.99),
(7, 7, 'M', 'Kahverengi', 549.99),
(8, 8, '42', 'Siyah', 1199.99),
(9, 9, 'STD', 'Bej', 899.99),
(11, 11, 'L', 'Siyah', 1499.99),
(12, 12, 'M', 'Krem', 649.99),
(13, 13, 'L', 'Gri', 749.99),
(14, 14, 'M', 'Mavi', 449.99),
(15, 15, 'L', 'Camel', 1699.99),
(16, 16, 'STD', 'Kahverengi', 199.99),
(17, 17, 'STD', 'Siyah', 249.99),
(18, 18, 'STD', 'Bordo', 299.99),
(19, 19, 'STD', 'Gümüş', 1299.99),
(20, 20, 'STD', 'Altın', 179.99),
(10, 10, 'STD', 'Siyah', 329.99);

INSERT INTO stock (stock_id, seller_id, variant_id, quantity) VALUES
(5, 5, 5, 35),
(7, 7, 7, 15),
(8, 8, 8, 10),
(9, 9, 9, 18),
(10, 10, 10, 22),
(11, 1, 11, 12),
(12, 2, 12, 28),
(13, 3, 13, 26),
(14, 4, 14, 34),
(16, 6, 16, 60),
(17, 7, 17, 45),
(18, 8, 18, 38),
(19, 9, 19, 14),
(20, 10, 20, 55),
(15, 5, 15, 20),
(2, 2, 2, 24),
(6, 6, 6, 48),
(3, 3, 3, 39),
(4, 4, 4, 19),
(1, 1, 1, 30);

INSERT INTO subscription (subscription_id, user_id, start_date, end_date, plan_id, status) VALUES
(1, 1, '2024-01-15', NULL, 1, 'active'),
(2, 2, '2023-06-10', NULL, 1, 'active'),
(3, 3, '2024-08-01', NULL, 1, 'paused'),
(4, 4, '2025-02-20', NULL, 1, 'active'),
(5, 5, '2024-05-01', '2024-06-01', 2, 'expired'),
(6, 6, '2024-11-10', '2024-12-10', 2, 'expired'),
(7, 7, '2025-01-01', '2025-02-01', 2, 'expired'),
(8, 8, '2025-09-15', '2025-10-15', 2, 'expired'),
(9, 9, '2025-12-01', '2026-01-01', 2, 'active'),
(10, 10, '2025-10-05', '2025-11-05', 2, 'expired');

INSERT INTO post (post_id, user_id, post_date, caption) VALUES
(1, 1, '2025-01-10', 'Günlük kombin'),
(2, 2, '2025-01-11', 'Ofis stili'),
(3, 3, '2025-01-12', 'Kış kombini'),
(4, 4, '2025-01-13', 'Bohem tarz'),
(5, 5, '2025-01-14', 'Sokak stili'),
(6, 6, '2025-01-15', 'Şık akşam yemeği'),
(7, 7, '2025-01-16', 'Rahat kombin'),
(9, 9, '2025-01-18', 'Spor stil'),
(10, 10, '2025-01-19', 'Okul kombini'),
(8, 8, '2025-01-17', 'Chill bir hafta sonu');



INSERT INTO postitem (post_item_id, post_id, item_type, color) VALUES
(1, 1, 'Üst Giyim', 'Siyah'),
(2, 1, 'Alt Giyim', 'Bej'),
(3, 2, 'Üst Giyim', 'Beyaz'),
(4, 2, 'Ayakkabı', 'Siyah'),
(5, 3, 'Üst Giyim', 'Gri'),
(6, 3, 'Alt Giyim', 'Lacivert'),
(7, 4, 'Elbise', 'Kırmızı'),
(8, 5, 'Üst Giyim', 'Yeşil'),
(9, 5, 'Çanta', 'Kahverengi'),
(10, 6, 'Üst Giyim', 'Siyah'),
(11, 6, 'Ayakkabı', 'Siyah'),
(12, 7, 'Üst Giyim', 'Beyaz'),
(13, 8, 'Üst Giyim', 'Gri'),
(14, 8, 'Alt Giyim', 'Siyah'),
(15, 9, 'Spor Üst', 'Mavi'),
(16, 9, 'Ayakkabı', 'Beyaz'),
(17, 10, 'Üst Giyim', 'Krem'),
(18, 10, 'Alt Giyim', 'Bej');


INSERT INTO posttag (post_id, tag_id) VALUES
(1, 1),
(1, 2),
(2, 6),
(3, 4),
(3, 2),
(4, 1),
(5, 2),
(5, 3),
(6, 6),
(7, 1),
(7, 2),
(8, 5),
(9, 5),
(10, 3);

INSERT INTO payment (payment_id, order_id, payment_type, payment_date, amount, payment_method, status) VALUES
(1, 1, NULL, '2025-03-01', 250.00, 'Credit Card', 'paid'),
(2, 2, NULL, '2025-03-02', 180.00, 'Debit Card', 'paid'),
(3, 3, NULL, '2025-03-03', 320.00, 'Credit Card', 'paid'),
(4, 4, NULL, '2025-03-04', 150.00, 'Credit Card', 'paid'),
(5, 5, NULL, '2025-03-05', 420.00, 'Debit Card', 'paid'),
(6, 6, NULL, '2025-03-06', 600.00, 'Credit Card', 'paid'),
(7, 7, NULL, '2025-03-07', 275.00, 'Credit Card', 'paid'),
(8, 8, NULL, '2025-03-08', 310.00, 'Debit Card', 'paid'),
(9, 9, NULL, '2025-03-09', 190.00, 'Credit Card', 'paid'),
(10, 10, NULL, '2025-03-10', 360.00, 'Credit Card', 'paid'),
(11, 11, NULL, '2025-03-11', 410.00, 'Debit Card', 'paid'),
(12, 12, NULL, '2025-03-12', 220.00, 'Credit Card', 'paid'),
(14, 14, NULL, '2025-03-14', 510.00, 'Credit Card', 'paid'),
(15, 15, NULL, '2025-03-15', 290.00, 'Debit Card', 'paid');

INSERT INTO outfit (outfit_id, user_id, created_at) VALUES
(1, 1, '2025-02-01'),
(2, 2, '2025-02-02'),
(3, 3, '2025-02-03'),
(4, 4, '2025-02-04'),
(5, 5, '2025-02-05'),
(6, 6, '2025-02-06'),
(7, 7, '2025-02-07'),
(8, 8, '2025-02-08'),
(9, 9, '2025-02-09'),
(10, 10, '2025-02-10');

INSERT INTO outfititem (outfit_id, variant_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);


INSERT INTO seller (seller_id, seller_name, rating) VALUES
(1, 'ModaDunyasi', 4.6),
(2, 'TrendSepeti', 1.9),
(4, 'UrbanWear', 3.9),
(5, 'FashionLine', 3.8),
(6, 'ChicStore', 4.3),
(7, 'StyleHub', 2.7),
(8, 'ElegantModa', 4.6),
(9, 'DailyStyle', 3.5),
(10, 'ModernLook', 4.9),
(3, 'StilKosesi', 4.8);

INSERT INTO product (product_id, product_name, category) VALUES
(1, 'Elbise', 'Giyim'),
(2, 'Ceket', 'Giyim'),
(3, 'Pantolon', 'Giyim'),
(4, 'Etek', 'Giyim'),
(5, 'Bluz', 'Giyim'),
(6, 'Tişört', 'Giyim'),
(7, 'Kazak', 'Giyim'),
(8, 'Ayakkabı', 'Aksesuar'),
(9, 'Çanta', 'Aksesuar'),
(10, 'Güneş Gözlüğü', 'Aksesuar'),
(11, 'Mont', 'Giyim'),
(12, 'Hırka', 'Giyim'),
(13, 'Sweatshirt', 'Giyim'),
(14, 'Şort', 'Giyim'),
(15, 'Trençkot', 'Giyim'),
(16, 'Kemer', 'Aksesuar'),
(17, 'Şapka', 'Aksesuar'),
(18, 'Atkı', 'Aksesuar'),
(19, 'Saat', 'Aksesuar'),
(20, 'Bileklik', 'Aksesuar');

INSERT INTO tag (tag_id, tag_name) VALUES
(1, 'casual'),
(2, 'streetwear'),
(3, 'summer'),
(4, 'winter'),
(5, 'sport'),
(6, 'elegant');

INSERT INTO subscriptionplan (plan_id, plan_name, duration_month, price) VALUES
(1, 'Free', 0, 0.00),
(2, 'Premium', 1, 99.99);
INSERT INTO orderitem (order_id, variant_id, quantity, price_at_purchase) VALUES
(1, 1, 1, 799.99),
(1, 6, 1, 299.99),
(2, 3, 1, 699.99),
(3, 11, 1, 1499.99),
(4, 14, 1, 449.99),
(5, 8, 1, 1199.99),
(6, 20, 1, 179.99),
(7, 7, 1, 549.99),
(8, 18, 1, 299.99),
(9, 9, 1, 899.99),
(10, 7, 1, 549.99),
(11, 4, 1, 499.99),
(11, 12, 1, 649.99),
(12, 12, 1, 649.99),
(14, 19, 1, 1299.99),
(14, 5, 1, 400.00),
(15, 10, 1, 349.99),
(15, 6, 1, 299.99),
(2, 6, 2, 299.99),
(1, 3, 1, 699.99),
(1, 4, 1, 699.99);