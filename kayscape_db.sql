
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(20),
    avatar_url TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- объект



CREATE TABLE properties (
    id SERIAL PRIMARY KEY,
    owner_id INT NOT NULL REFERENCES users(id),
    category_id INT NOT NULL REFERENCES categories(id),
    title VARCHAR(200) NOT NULL,
    description TEXT,
    address VARCHAR(300) NOT NULL,
    city VARCHAR(100) NOT NULL,
    price_per_night NUMERIC(10,2) NOT NULL,
    max_guests INT NOT NULL DEFAULT 1,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE property_images (
    id SERIAL PRIMARY KEY,
    property_id INT NOT NULL REFERENCES properties(id),
    image_url TEXT NOT NULL,
    is_main BOOLEAN DEFAULT FALSE
);





-- бронирования
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    property_id INT NOT NULL REFERENCES properties(id),
    guest_id INT NOT NULL REFERENCES users(id),
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    guests_count INT DEFAULT 1,
    total_price NUMERIC(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL UNIQUE REFERENCES bookings(id),
    rating INT NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);





CREATE TABLE favorites (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id),
    property_id INT NOT NULL REFERENCES properties(id),
    added_at TIMESTAMP DEFAULT NOW()
);


-- data

INSERT INTO categories (name) VALUES ('Квартира'), ('Дом'), ('Отель');

INSERT INTO users (full_name, email, phone) VALUES
('Алия Сейткали', 'aliya@mail.ru', '+7 701 234 5678'),
('Марат Ахметов', 'marat_a@gmail.com', '+7 702 891 0023'),
('Светлана Иванова', 'sv.ivanova@mail.ru', null),
('Дмитрий Козлов', 'dkozlov@gmail.com', '+7 707 345 6712'),
('Аида Нурланова', 'aida.n@mail.ru', '+7 708 567 4490');

INSERT INTO properties (owner_id, category_id, title, description, address, city, price_per_night, max_guests) VALUES
(1, 1, 'Студия в центре', 'рядом с метро абая, светлая', 'ул. Абая 10 кв 5', 'Алматы', 8300, 2),
(1, 2, 'Дом в Боровом', 'с бассейном, большой участок', 'пос. Боровое д 12', 'Боровое', 14500, 8),
(2, 1, 'Апартаменты Достык', 'вид на горы, новый ремонт', 'пр. Достык 45 кв 201', 'Алматы', 11700, 4),

(3, 3, 'Бутик-отель Kayscape', null, 'ул. Сейфуллина 22', 'Алматы', 17900, 2),
(4, 1, 'Двушка у парка', 'полностью оснащена', 'ул. Гоголя 5 кв 18', 'Астана', 9200, 4),
(5, 2, 'Коттедж в горах', 'экологично, тихо', 'с. Чемолган д 7', 'Алматы', 10800, 6);

    INSERT INTO property_images (property_id, image_url, is_main) VALUES
(   1, 'https://cdn.kayscape.io/p1-main.jpg', TRUE),
(1, 'https://cdn.kayscape.io/p1-kitchen.jpg', FALSE),
(2, 'https://cdn.kayscape.io/p2-main.jpg', TRUE),
(3, 'https://cdn.kayscape.io/p3-main.jpg', TRUE),
(4, 'https://cdn.kayscape.io/p4-main.jpg', TRUE),
(5, 'https://cdn.kayscape.io/p5-main.jpg', TRUE),
(6, 'https://cdn.kayscape.io/p6-main.jpg', TRUE);

    INSERT INTO bookings (property_id, guest_id, check_in, check_out, guests_count, total_price, status) VALUES

(1, 2, '2025-06-01', '2025-06-05', 2, 33200, 'completed'),
(3, 3, '2025-06-10', '2025-06-13', 3, 35100, 'completed'),
(4, 1, '2025-07-01', '2025-07-03', 2, 35800, 'confirmed'),
(2, 4, '2025-07-15', '2025-07-20', 5, 72500, 'confirmed'),
(5, 2, '2025-08-01', '2025-08-04', 2, 27600, 'pending'),
(6, 3, '2025-08-10', '2025-08-14', 4, 43200, 'cancelled');

INSERT INTO reviews (booking_id, rating, comment) VALUES
(1, 5, 'Отличное место, всё как на фото!'),
(2, 4, 'Красивый вид, немного далеко от центра.'),
(6, 3, 'Дом хороший, но поездка не состоялась.');

INSERT INTO favorites (user_id, property_id) VALUES
(2, 2), (2, 4), (3, 1), (3, 3), (4, 6);


-- запррос все


-- Запрос 1: selcet с условием


SELECT p.id, p.title, p.city, p.price_per_night, c.name AS category
FROM properties p
JOIN categories c ON c.id = p.category_id
WHERE p.is_active = TRUE AND p.price_per_night > 10000
ORDER BY p.price_per_night DESC;

-- Запрос 2: insert
INSERT INTO users (full_name, email, phone)
VALUES ('Нурлан Бекенов', 'nurlan@example.com', '+7 776 000 0006');

-- Запрос 3: update
UPDATE properties
SET price_per_night = 9350
WHERE id = 1;

-- Запрос 4: delete
DELETE FROM reviews WHERE booking_id = 6;
DELETE FROM bookings WHERE id = 6;

-- Запрос 5: selecet с join йф
SELECT
    b.id AS booking_id,
    u.full_name AS guest,
    p.title AS property,
    p.city,
    b.check_in,
    b.check_out,
    b.total_price,
    b.status
FROM bookings b
JOIN users u ON u.id = b.guest_id
JOIN properties p ON p.id = b.property_id
ORDER BY b.check_in;
