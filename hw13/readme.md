
## 1. Сделать копии таблиц Production.Categories и Production.Products из базы данных tsql2012 в dbo.Categories и dbo.Products тремя способами

a) При помощи инструкции SELECT INTO с подзапросом
b) При помощи инструкции SELECT INTO без подзапроса (просто из таблицы)
c) При помощи INSERT INTO в итоговую таблицу

### a)

```sql
SELECT * INTO dbo.Categories
FROM ( SELECT * FROM Production.Categories) AS Subquery;

SELECT * INTO dbo.Products
FROM (SELECT * FROM Production.Products) AS Subquery;
```

### b) 

```sql
```

### c) 

```sql
```

## 2. Обновить цену unitprice в таблице orderdetails для работника по фамилии Пелед, Увеличить ее на 20% при помощи соединения(JOIN) с таблицами employees и orders

```sql
```

## 3. Обновить цену unitprice в таблице orderdetails для работника по фамилии Пелед, Увеличить ее на 20% при помощи коррелированного подзапроса  с участием таблицм employees и orders

```sql
```

## 4. Удалить записи в таблице orderdetails для работника по фамилии Пелед при помощи соединения(JOIN) с таблицами employees и orders

```sql
```

## 5. Удалить записи в таблице orderdetails для работника по фамилии Пелед при помощи коррелированного подзапроса и таблиц  employees и orders

```sql
```

## 6. Создать таблицу test. Занести в нее несколько записей, некоторые долны быть одинаковыми кроме первичных ключей. Удалить повторяющиеся записи.

```sql
```

## 7. Сделать таблицу testex одинаковой с таблицей test при помощи инструкции MERGE

```sql
```

## 8. Объединить таблицы Categories и Products при помощи JOIN по полю categoryid. Создать по данному запросу представление View с именем v1 и вывести все поля представления на экран

```sql
```

## 9. Определить для каждого работника суммарную стоимость заказа unitprice*qty*(1-discount) за каждый год для таблиц orderdetails, orders, employees. Вывести значения lastname, firstname, год заказа, суммарная стоимость. Решить при помощи подзапроса с последующим соединением этого подзапроса с таблицей employees и созданием из данного подзапроса представления(view).

```sql
```
