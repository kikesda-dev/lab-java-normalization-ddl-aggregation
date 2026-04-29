-- 1. Tabla de Autores
CREATE TABLE authors
(
    author_id   INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Tabla de Artículos
CREATE TABLE articles
(
    article_id INT AUTO_INCREMENT PRIMARY KEY,
    title      VARCHAR(255) NOT NULL,
    word_count INT          NOT NULL CHECK (word_count > 0),
    views      INT DEFAULT 0 CHECK (views >= 0),
    author_id  INT,
    FOREIGN KEY (author_id) REFERENCES authors (author_id) ON DELETE CASCADE
);

-- Insertar datos de ejemplo
INSERT INTO authors (author_name)
VALUES ('Maria Charlotte'),
       ('Juan Perez'),
       ('Gemma Alcocer');

INSERT INTO articles (title, word_count, views, author_id)
VALUES ('Best Paint Colors', 814, 14, 1),
       ('Small Space Decorating Tips', 1146, 221, 2),
       ('Hot Accessories', 986, 105, 1),
       ('Mixing Textures', 765, 22, 1),
       ('Kitchen Refresh', 1242, 307, 2),
       ('Homemade Art Hacks', 1002, 193, 1),
       ('Refinishing Wood Floors', 1571, 7542, 3);