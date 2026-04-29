-- 1. Tabla de Clientes
CREATE TABLE customers
(
    customer_id            INT AUTO_INCREMENT PRIMARY KEY,
    customer_name          VARCHAR(150) NOT NULL,
    customer_status        VARCHAR(50) DEFAULT 'None',
    total_customer_mileage INT         DEFAULT 0
);

-- 2. Tabla de Aviones
CREATE TABLE aircrafts
(
    aircraft_name        VARCHAR(100) PRIMARY KEY,
    total_aircraft_seats INT NOT NULL CHECK (total_aircraft_seats > 0)
);

-- 3. Tabla de Vuelos
CREATE TABLE flights
(
    flight_number  VARCHAR(20) PRIMARY KEY,
    flight_mileage INT NOT NULL CHECK (flight_mileage > 0),
    aircraft_name  VARCHAR(100),
    FOREIGN KEY (aircraft_name) REFERENCES aircrafts (aircraft_name) ON DELETE SET NULL
);

-- 4. Tabla de Reservas (Tabla intermedia)
CREATE TABLE bookings
(
    booking_id    INT AUTO_INCREMENT PRIMARY KEY,
    customer_id   INT,
    flight_number VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id) ON DELETE CASCADE,
    FOREIGN KEY (flight_number) REFERENCES flights (flight_number) ON DELETE CASCADE
);

-- Insertar Clientes
INSERT INTO customers (customer_name, customer_status, total_customer_mileage)
VALUES ('Agustine Riviera', 'Silver', 115235),
       ('Alaina Sepulvida', 'None', 6008),
       ('Tom Jones', 'Gold', 205767),
       ('Sam Rio', 'None', 2653),
       ('Jessica James', 'Silver', 127656),
       ('Ana Janco', 'Silver', 136773),
       ('Jennifer Cortez', 'Gold', 300582),
       ('Christian Janco', 'Silver', 14642);

-- Insertar Aviones
INSERT INTO aircrafts (aircraft_name, total_aircraft_seats)
VALUES ('Boeing 747', 400),
       ('Airbus A330', 236),
       ('Boeing 777', 264);

-- Insertar Vuelos
INSERT INTO flights (flight_number, flight_mileage, aircraft_name)
VALUES ('DL143', 135, 'Boeing 747'),
       ('DL122', 4370, 'Airbus A330'),
       ('DL53', 2078, 'Boeing 777'),
       ('DL222', 1765, 'Boeing 777'),
       ('DL37', 531, 'Boeing 747');

-- Insertar Reservas
INSERT INTO bookings (customer_id, flight_number)
VALUES (1, 'DL143'),
       (1, 'DL122'),
       (1, 'DL143'),
       (1, 'DL143'),
       (1, 'DL143'), -- Agustine Riviera
       (2, 'DL122'), -- Alaina Sepulvida
       (3, 'DL122'),
       (3, 'DL53'),
       (3, 'DL222'), -- Tom Jones
       (4, 'DL143'),
       (4, 'DL143'),
       (4, 'DL37'),  -- Sam Rio
       (5, 'DL143'),
       (5, 'DL122'), -- Jessica James
       (6, 'DL222'), -- Ana Janco
       (7, 'DL222'), -- Jennifer Cortez
       (8, 'DL222'); -- Christian Janco

SELECT COUNT(*)
FROM flights;

SELECT AVG(flight_mileage)
FROM flights;

SELECT AVG(total_aircraft_seats)
FROM aircrafts;

SELECT customer_status, AVG(total_customer_mileage)
FROM customers
GROUP BY customer_status;

SELECT customer_status, MAX(total_customer_mileage)
FROM customers
GROUP BY customer_status;

SELECT COUNT(*)
FROM aircrafts
WHERE aircraft_name LIKE '%Boeing%';

SELECT *
FROM flights
WHERE flight_mileage BETWEEN 300 AND 2000;

SELECT c.customer_status, AVG(f.flight_mileage)
FROM bookings b
         JOIN customers c ON b.customer_id = c.customer_id
         JOIN flights f ON b.flight_number = f.flight_number
GROUP BY c.customer_status;

SELECT a.aircraft_name, COUNT(*) AS total_bookings
FROM bookings b
         JOIN customers c ON b.customer_id = c.customer_id
         JOIN flights f ON b.flight_number = f.flight_number
         JOIN aircrafts a ON f.aircraft_name = a.aircraft_name
WHERE c.customer_status = 'Gold'
GROUP BY a.aircraft_name
ORDER BY total_bookings DESC
LIMIT 1;