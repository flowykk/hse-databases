## 1. 1 Создать таблицы Workers , Events и Operations в соответствии с ER диаграммой. Соответственно создаются первичные и внешние ключи W_id - первичный ключ для Workers  , Op_id первичный ключ для Operations, Ev_id первичный ключ для Events. W_id и Op_id внешние (FOREIGN KEY) для таблицы Events, которые ссылаются на таблицы Workers , Events и Operations

```sql
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
```

## 2. Проверить вставку и удаление записей в таблицы Events, Operations и Workers при наличии ограничений по ссылочной целостности (наличия FOREIGN KEY) и без ограничения по ссылочной целостности.

### Вставка тестовых значений:

```sql
INSERT INTO Workers (W_id, lastname, firstname) VALUES (1, 'Doe', 'John');
INSERT INTO Workers (W_id, lastname, firstname) VALUES (2, 'Smith', 'Anna');

INSERT INTO Operations (Op_id, opname, cost) VALUES (1, 'Welding', 200.00);
INSERT INTO Operations (Op_id, opname, cost) VALUES (2, 'Painting', 150.00);

INSERT INTO Events (Ev_id, W_id, Op_id, [Date], Number) VALUES (1, 1, 1, '2024-10-15', 100);
```

![Screenshot 2024-10-16 at 15 46 01](https://github.com/user-attachments/assets/d9548084-c6d4-4f7d-b096-c5ff78378d78)

### Попытка удаления значений:

```sql
DELETE FROM Workers WHERE W_id = 1;
DELETE FROM Operations WHERE Op_id = 2;
```

![Screenshot 2024-10-16 at 15 47 28](https://github.com/user-attachments/assets/a80746c3-6837-4367-9773-b0e3a2bb34e5)

## 3. Создать ограничения для поля Number в таблице Events как Check , больше нуля и меньше 300 и как default(20).

```sql
ALTER TABLE Events
ADD CONSTRAINT constraint_check CHECK (Number > 0 AND Number < 300);

ALTER TABLE Events
ADD CONSTRAINT constraint_def DEFAULT 20 FOR Number;
```

### Проверка ограничений 

```sql
INSERT INTO Events (Ev_id, W_id, Op_id, [Date], Number) VALUES (1, 1, 1, '2024-10-15', 400);
```

![Screenshot 2024-10-16 at 15 52 31](https://github.com/user-attachments/assets/885297d9-5315-4a6b-8487-fb79a9521254)

```sql
INSERT INTO Events (Ev_id, W_id, Op_id, [Date]) VALUES (4, 1, 1, '2024-10-15');
```

![Screenshot 2024-10-16 at 15 53 23](https://github.com/user-attachments/assets/2be3b41d-c8fd-4932-89cd-6eef684ce45c)

## 5. Добавить поле в таблицу Workers.

```sql
ALTER TABLE Workers ADD middname VARCHAR(30);
```

![Screenshot 2024-10-16 at 15 54 32](https://github.com/user-attachments/assets/b4639606-dc3d-4517-9e7f-872073204d4d)

## 6. Добавить внешний ключ в таблицу Events.

```sql
ALTER TABLE Events ADD CONSTRAINT FK_new FOREIGN KEY (W_id) REFERENCES Workers(W_id) ON UPDATE CASCADE;
```

## 7. Можно изменить тип колонки(поля) [number].

```sql
ALTER TABLE Events ALTER COLUMN Number BIGINT;
```
