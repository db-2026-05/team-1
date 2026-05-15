# TEAMWORK - Topic 04 (SQL DDL)

## Склад команди
- Команда: Team 1
- Варіант предметної області: Variant 3 — Restaurant Management System

## Таблиця внесків

| Учасник | Роль у команді | Що зроблено | Артефакти / файли |
|---|---|---|---|
| Taras Tkhir | HR & Structure Developer | Реалізував DDL-скрипти для таблиць `locations`, `staff`, `shift_schedules`. Створив PK/FK, constraints та зв’язки для структури ресторанів і персоналу. | ddl.sql, ER diagram |
| Robert Hubskyi | Kitchen & Inventory Developer | Реалізував DDL-структуру для `menu_items`, `ingredients`, `suppliers`, `basic_inventory`, а також junction tables `menu_item_ingredients` та `ingredient_suppliers`. Додав constraints та indexes. | ddl.sql, ER diagram |
| Oleksandr Sydorskyi | Business Process Developer | Реалізував DDL-скрипти для `customers`, `orders`, `order_items`, `reservations`, `customer_feedback`. Створив PK/FK, CHECK constraints та indexes для бізнес-процесів системи. | ddl.sql, ER diagram |

## Контекст теми

- Тарас відповідав за створення таблиць, primary keys, foreign keys та constraints для структури ресторанів і персоналу.
- Роберт реалізував DDL для кухонної частини системи, inventory management та many-to-many relationships через junction tables.
- Олександр відповідав за бізнес-логіку системи: замовлення, клієнтів, бронювання та систему відгуків.

Команда спільно узгодила naming conventions, структуру `ddl.sql`, порядок створення таблиць та перевірила виконання скрипта у PostgreSQL.

## Коротке обґрунтування командного підходу

1. Як ви розподілили DDL-об'єкти між учасниками:
   DDL-об’єкти були розподілені відповідно до доменів системи: HR та структура, кухня та inventory, бізнес-процеси та взаємодія з клієнтами.

2. Чому обрали саме такий поділ роботи:
   Такий підхід дозволив незалежно працювати над різними частинами системи без конфліктів у структурі бази даних та забезпечив рівномірний розподіл навантаження між учасниками.

3. Як перевіряли відповідність DDL вашій ER-діаграмі:
   Команда перевіряла відповідність через foreign keys, relationship lines та структуру таблиць. Також DDL-скрипт тестувався у PostgreSQL для перевірки коректності створення schema, tables, constraints та indexes.


ПОСИЛАННЯ НА ВІДЕО:
 https://drive.google.com/file/d/10h9XcYaT8CmaToKqenyL9Rtx87yF8qc5/view?usp=sharing
