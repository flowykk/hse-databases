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
