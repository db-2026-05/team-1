# TEAMWORK - Topic 10 (SQL Views)

## Склад команди

* Команда: Team 1
* Варіант предметної області: Restaurant Database System

## Таблиця внесків

| Учасник             | Роль у команді             | Що зроблено                                                                                                                                                                                        | Артефакти / файли |
| ------------------- | -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| Robert Hubskyi      | Kitchen & Inventory Module | Реалізував views для меню, рецептів, інгредієнтів та складу. Створив horizontal, vertical, mixed, join, subquery, UNION, view-from-view та CHECK OPTION views для кухонного й складського модулів. | views.sql         |
| Oleksandr Sydorskyi | Business Process Module    | Реалізував views для бізнес-процесів ресторану: completed orders, customer orders та customer activity. Створив mixed view, join view та UNION view для CRM і системи замовлень.                   | views.sql         |
| Taras Tkhir         | HR & Structure Module      | Реалізував views для управління персоналом і структурою закладів. Створив horizontal, vertical, mixed, join, subquery, UNION, view-from-view та CHECK OPTION views для співробітників і локацій.   | views.sql         |

## Контекст теми

### Horizontal / Vertical / Mixed Views

* **Robert Hubskyi**

  * Horizontal View: `menu_item_price_list`
  * Vertical View: `expensive_menu_items`
  * Mixed View: `expensive_menu_item_summary`

* **Taras Tkhir**

  * Horizontal View: `vw_staff_basic`
  * Vertical View: `vw_managers`
  * Mixed View: `vw_barista_contacts`

* **Oleksandr Sydorskyi**

  * Mixed View: `completed_orders_view`

### Join / Subquery / UNION Views

* **Robert Hubskyi**

  * Join Views: `menu_items_with_categories`, `menu_item_recipe_details`, `inventory_report`
  * Subquery View: `complex_menu_items`
  * UNION View: `kitchen_entities`

* **Taras Tkhir**

  * Join View: `vw_staff_locations`
  * Subquery View: `vw_active_locations`
  * UNION View: `vw_management_kitchen`

* **Oleksandr Sydorskyi**

  * Join View: `customer_orders_view`
  * UNION View: `customer_activity_view`

### View from View

* **Robert Hubskyi**

  * `category_menu_summary` (побудований на основі `menu_items_with_categories`)

* **Taras Tkhir**

  * `vw_staff_summary` (побудований на основі `vw_staff_locations`)

### WITH CHECK OPTION

* **Robert Hubskyi**

  * `available_basic_inventory`

* **Taras Tkhir**

  * `vw_baristas_only`

### Demo SELECT та структура файлу

* Усі учасники брали участь у перевірці створених views.
* Структурування файлу `views.sql`, додавання коментарів і демонстраційних `SELECT` виконувалось спільно командою.

## Коротке обґрунтування командного підходу

1. **Як ви розподілили типи views між учасниками:**

   Views були розподілені відповідно до модулів бази даних, за які відповідав кожен учасник. Robert працював із кухнею та складом, Oleksandr — із бізнес-процесами та CRM, Taras — зі структурою ресторанів і персоналом. Це дозволило кожному створювати views на основі власної частини моделі даних.

2. **Чому ці views важливі для предметної області:**

   Views спрощують доступ до бізнес-інформації та приховують складність SQL-запитів. Вони дозволяють отримувати звіти про меню, складські залишки, замовлення, активність клієнтів, персонал та робочі локації без необхідності щоразу створювати складні JOIN або агрегуючі запити.

3. **Як перевіряли практичну цінність і коректність кожного view:**

   Кожен view тестувався за допомогою окремих SELECT-запитів. Перевірялась коректність JOIN-операцій, фільтрації даних, роботи підзапитів, UNION-конструкцій та обмежень WITH CHECK OPTION. Також виконувалась перевірка відповідності результатів бізнес-логіці ресторанної системи та відсутності помилок під час виконання скрипта в PostgreSQL.
