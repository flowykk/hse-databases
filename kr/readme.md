## Модель БД

```
Users(user_id (PK), username, email)
Chats (chat_id (PK), chat_name, is_channel)
ChatMembers (chat_id (FK), user_id (FK))
Messages(message_id (PK), chat_id (FK), sender_id (FK), original_message_id (FK), content, sent_at)
Files (file_id (PK), message_id (FK), file_path)
Reactions(reaction_id (PK), message_id (FK), user_id (FK), emoji)
```

## Скрипты создания таблиц

```sql
CREATE TABLE users (
    user_id INT IDENTITY PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    email NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE chats (
    chat_id INT IDENTITY PRIMARY KEY,
    chat_name NVARCHAR(100),
    is_channel BIT NOT NULL DEFAULT 0
);

CREATE TABLE chat_members (
    chat_id INT FOREIGN KEY REFERENCES chats(chat_id) ON DELETE CASCADE,
    user_id INT FOREIGN KEY REFERENCES users(user_id) ON DELETE CASCADE,
    PRIMARY KEY (chat_id, user_id)
);

CREATE TABLE messages (
    message_id INT IDENTITY PRIMARY KEY,
    chat_id INT FOREIGN KEY REFERENCES chats(chat_id) ON DELETE CASCADE,
    sender_id INT FOREIGN KEY REFERENCES users(user_id) ON DELETE SET NULL,
    original_message_id INT,
    content NVARCHAR(MAX),
    sent_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_messages_original_message FOREIGN KEY (original_message_id) REFERENCES messages(message_id) ON DELETE NO ACTION
);

CREATE TABLE files (
    file_id INT IDENTITY PRIMARY KEY,
    message_id INT FOREIGN KEY REFERENCES messages(message_id) ON DELETE CASCADE,
    file_path NVARCHAR(255) NOT NULL
);

CREATE TABLE reactions (
    reaction_id INT IDENTITY PRIMARY KEY,
    message_id INT FOREIGN KEY REFERENCES messages(message_id) ON DELETE CASCADE,
    user_id INT FOREIGN KEY REFERENCES users(user_id) ON DELETE CASCADE,
    emoji NVARCHAR(10) NOT NULL
);
```

## Задание 2

```sql
SELECT
    SUM(CASE WHEN m.sender_id = 1 AND f.file_id IS NOT NULL AND m.original_message_id IS NULL THEN 1 ELSE 0 END) AS sent_with_files,
    SUM(CASE WHEN cm.user_id = 1 AND ch.is_channel = 0 AND m.sender_id <> 1 AND f.file_id IS NOT NULL AND m.original_message_id IS NULL THEN 1 ELSE 0 END) AS received_with_files,
    SUM(CASE WHEN m.sender_id = 1 AND f.file_id IS NOT NULL AND m.original_message_id IS NOT NULL THEN 1 ELSE 0 END) AS forwarded_with_files
FROM messages m
LEFT JOIN files f ON m.message_id = f.message_id
JOIN chats ch ON m.chat_id = ch.chat_id
JOIN chat_members cm ON m.chat_id = cm.chat_id AND cm.user_id = 1
WHERE m.sent_at BETWEEN '2023-01-01' AND '2023-12-31';
```

### Пример работы

<img width="568" alt="Screenshot 2024-11-12 at 17 37 21" src="https://github.com/user-attachments/assets/2ac323e8-c199-4cd9-ac4b-5a8af480a4ee">


## Задание 3

```sql
SELECT DISTINCT cm.user_id
FROM chat_members cm
JOIN chats ch ON cm.chat_id = ch.chat_id
JOIN messages m ON ch.chat_id = m.chat_id
JOIN reactions r ON m.message_id = r.message_id
WHERE ch.is_channel = 1
GROUP BY cm.user_id, cm.chat_id
HAVING COUNT(r.emoji) > 5;
```

### Пример работы

<img width="145" alt="Screenshot 2024-11-12 at 17 37 05" src="https://github.com/user-attachments/assets/2efac6bf-6bd1-482a-97bb-aa0f62485527">


## Задание 4

```sql
WITH TopChannels AS (
    SELECT TOP 3 ch.chat_id, ch.chat_name, COUNT(m.message_id) AS message_count
    FROM chats ch
    JOIN messages m ON ch.chat_id = m.chat_id
    WHERE ch.is_channel = 1 -- только каналы
    GROUP BY ch.chat_id, ch.chat_name
    ORDER BY message_count DESC
),
ActiveUserPerChannel AS (
    SELECT 
        ch.chat_id, 
        m.sender_id, 
        COUNT(m.message_id) AS user_message_count,
        ROW_NUMBER() OVER (PARTITION BY ch.chat_id ORDER BY COUNT(m.message_id) DESC) AS row_num
    FROM TopChannels ch
    JOIN messages m ON ch.chat_id = m.chat_id
    GROUP BY ch.chat_id, m.sender_id
)
SELECT tc.chat_name, tc.message_count, aupc.sender_id AS active_user_id
FROM TopChannels tc
JOIN ActiveUserPerChannel aupc ON tc.chat_id = aupc.chat_id
WHERE aupc.row_num = 1;
```

### Пример работы

<img width="438" alt="Screenshot 2024-11-12 at 17 36 49" src="https://github.com/user-attachments/assets/3effe86a-85b3-4d0a-ac6c-e32c731354bc">
