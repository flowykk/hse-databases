-- Таблица Workers
CREATE TABLE Workers (
    W_id INT PRIMARY KEY,
    lastname NVARCHAR(50),
    firstname NVARCHAR(50)
);

-- Таблица Operations
CREATE TABLE Operations (
    Op_id INT PRIMARY KEY,
    opname NVARCHAR(100),
    cost DECIMAL(10, 2)
);

-- Таблица Events с нужными внешними ключами
CREATE TABLE Events (
    Ev_id INT PRIMARY KEY,
    W_id INT,
    Op_id INT,
    [Date] DATE,
    Number INT,
    CONSTRAINT FK_Worker FOREIGN KEY (W_id) REFERENCES Workers(W_id) ON DELETE CASCADE,
    CONSTRAINT FK_Operation FOREIGN KEY (Op_id) REFERENCES Operations(Op_id) ON DELETE CASCADE
);

-- Вставка тестовых значений в таблицы
INSERT INTO Workers (W_id, lastname, firstname) VALUES (1, 'Doe', 'John')
INSERT INTO Workers (W_id, lastname, firstname) VALUES (2, 'Smith', 'Anna')

INSERT INTO Operations (Op_id, opname, cost) VALUES (1, 'Welding', 200.00)
INSERT INTO Operations (Op_id, opname, cost) VALUES (2, 'Painting', 150.00)

INSERT INTO Events (Ev_id, W_id, Op_id, [Date], Number) VALUES (1, 1, 1, '2024-10-15', 100)

-- Удаление значений
DELETE FROM Workers WHERE W_id = 1
DELETE FROM Operations WHERE Op_id = 2

-- Добавление ограничений на таблицу Events
ALTER TABLE Events
ADD CONSTRAINT constraint_check CHECK (Number > 0 AND Number < 300)

ALTER TABLE Events
ADD CONSTRAINT constraint_def DEFAULT 20 FOR Number

-- Проверка созданных ограничений
INSERT INTO Events (Ev_id, W_id, Op_id, [Date], Number) VALUES (1, 1, 1, '2024-10-15', 400)
INSERT INTO Events (Ev_id, W_id, Op_id, [Date]) VALUES (4, 1, 1, '2024-10-15')

-- Добавление нового столбца в таблицу Workers
ALTER TABLE Workers ADD middname VARCHAR(30)

-- Добавление нового FK к таблице Events
ALTER TABLE Events ADD CONSTRAINT FK_new FOREIGN KEY (W_id) REFERENCES Workers(W_id) ON UPDATE CASCADE

-- Изменение типа значений столбца Number
ALTER TABLE Events ALTER COLUMN Number BIGINT
