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

## Задание 4

```sql

```
