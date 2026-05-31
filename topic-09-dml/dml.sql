-- -----------------------------------------------------
-- Hubskti Robert
-- Tables: menu_categories, menu_items, ingredients
-- menu_item_ingredients, suppliers ,ingredient_suppliers, basic_inventory
-- -----------------------------------------------------

INSERT INTO restaurant.menu_categories (category_name)
VALUES 
  ('Starters'),
  ('Salads'),
  ('Soups'),
  ('Fish Dishes'),
  ('Meat Dishes'),
  ('Vegetarian'),
  ('Extras'),
  ('Desserts'),
  ('Drinks'),
  ('Breakfast')
RETURNING *;


INSERT INTO restaurant.ingredients (ingredient_name, unit)
VALUES 
  ('Salmon', 'kg'),
  ('Dorado', 'kg'),
  ('Shrimp', 'kg'),
  ('Pork', 'kg'),
  ('Beef', 'kg'),
  ('Lamb', 'kg'),
  ('Venison', 'kg'),
  ('Potato', 'kg'),
  ('Tomato', 'kg'),
  ('Carrot', 'kg'),
  ('Onion', 'kg'),
  ('Sweet Potato', 'kg'),
  ('Milk', 'l'),
  ('Cream', 'l'),
  ('Butter', 'kg'),
  ('Eggs', 'pcs'),
  ('Flour', 'kg'),
  ('Rice', 'kg'),
  ('Pasta', 'kg'),
  ('Olive Oil', 'l'),
  ('Garlic', 'kg'),
  ('Mushrooms', 'kg'),
  ('Lettuce', 'kg'),
  ('Cucumber', 'kg'),
  ('Bell Pepper', 'kg'),
  ('Cheese', 'kg'),
  ('Parmesan', 'kg'),
  ('Chicken Breast', 'kg'),
  ('Turkey Fillet', 'kg'),
  ('Bread', 'pcs'),
  ('Sugar', 'kg'),
  ('Dark Chocolate', 'kg'),
  ('Vanilla', 'g'),
  ('Honey', 'kg'),
  ('Strawberries', 'kg'),
  ('Blueberries', 'kg'),
  ('Raspberries', 'kg'),
  ('Apples', 'kg'),
  ('Lemon', 'kg'),
  ('Coffee Beans', 'kg'),
  ('Black Tea', 'g'),
  ('Orange Juice', 'l'),
  ('Apple Juice', 'l'),
  ('Sparkling Water', 'l'),
  ('Salt', 'kg'),
  ('Black Pepper', 'kg'),
  ('Basil', 'g')
RETURNING *;


INSERT INTO restaurant.suppliers (supplier_name, contact_info)
VALUES
  ('Nordic Fish Supply', 'fish@nordic.fi'),
  ('Helsinki Meat Co', 'meat@helsinki.fi'),
  ('Fresh Veg Market', 'veg@fresh.fi'),
  ('Dairy Finland', 'dairy@finland.fi'),
  ('Bakery Wholesale', 'bakery@wholesale.fi'),
  ('Italian Food Import', 'italian@import.fi'),
  ('Berry Farm Finland', 'berries@farm.fi'),
  ('Beverage Partners', 'drinks@partners.fi'),
  ('Spice House', 'spices@house.fi'),
  ('Organic Goods Ltd', 'organic@goods.fi')
RETURNING *;


INSERT INTO restaurant.ingredient_suppliers (ingredient_id, supplier_id, cost)
SELECT 
  i.ingredient_id,
  s.supplier_id,
  CASE
    WHEN i.ingredient_name = 'Salmon' THEN 18.50
    WHEN i.ingredient_name = 'Shrimp' THEN 14.80
    WHEN i.ingredient_name = 'Dorado' THEN 21.00
  END AS cost
FROM restaurant.ingredients AS i
CROSS JOIN restaurant.suppliers AS s
WHERE s.supplier_name = 'Nordic Fish Supply'
  AND i.ingredient_name IN ('Salmon', 'Shrimp', 'Dorado')
RETURNING *;


INSERT INTO restaurant.ingredient_suppliers (ingredient_id, supplier_id, cost)
SELECT 
  i.ingredient_id,
  s.supplier_id,
  CASE
    WHEN i.ingredient_name = 'Pork' THEN 9.80
    WHEN i.ingredient_name = 'Beef' THEN 16.50
    WHEN i.ingredient_name = 'Lamb' THEN 18.90
    WHEN i.ingredient_name = 'Venison' THEN 24.50
    WHEN i.ingredient_name = 'Chicken Breast' THEN 8.70
    WHEN i.ingredient_name = 'Turkey Fillet' THEN 10.20
  END AS cost
FROM restaurant.ingredients AS i
CROSS JOIN restaurant.suppliers AS s
WHERE s.supplier_name = 'Helsinki Meat Co'
  AND i.ingredient_name IN (
    'Pork',
    'Beef',
    'Lamb',
    'Venison',
    'Chicken Breast',
    'Turkey Fillet'
  )
RETURNING *;


INSERT INTO restaurant.ingredient_suppliers (ingredient_id, supplier_id, cost)
SELECT 
  i.ingredient_id,
  s.supplier_id, 
  CASE 
    WHEN i.ingredient_name = 'Potato' THEN 1.30
    WHEN i.ingredient_name = 'Tomato' THEN 2.80
    WHEN i.ingredient_name = 'Carrot' THEN 1.20
    WHEN i.ingredient_name = 'Onion' THEN 1.10
    WHEN i.ingredient_name = 'Sweet Potato' THEN 2.90
    WHEN i.ingredient_name = 'Cucumber' THEN 2.40
    WHEN i.ingredient_name = 'Lettuce' THEN 3.10
    WHEN i.ingredient_name = 'Mushrooms' THEN 4.60
    WHEN i.ingredient_name = 'Bell Pepper' THEN 3.80
  END AS cost
FROM restaurant.ingredients AS i
CROSS JOIN restaurant.suppliers AS s
WHERE s.supplier_name = 'Fresh Veg Market'
  AND i.ingredient_name IN (
    'Potato',
    'Tomato',
    'Carrot',
    'Onion',
    'Sweet Potato',
    'Cucumber',
    'Lettuce',
    'Mushrooms',
    'Bell Pepper'
  )
RETURNING *;


INSERT INTO restaurant.ingredient_suppliers (ingredient_id, supplier_id, cost)
SELECT 
  i.ingredient_id,
  s.supplier_id,
  CASE
    WHEN i.ingredient_name = 'Milk' THEN 1.60
    WHEN i.ingredient_name = 'Cream' THEN 3.20
    WHEN i.ingredient_name = 'Butter' THEN 6.80
    WHEN i.ingredient_name = 'Cheese' THEN 7.90
    WHEN i.ingredient_name = 'Parmesan' THEN 14.50
  END AS cost
FROM restaurant.ingredients AS i
CROSS JOIN restaurant.suppliers AS s
WHERE s.supplier_name = 'Dairy Finland'
  AND i.ingredient_name IN (
    'Milk',
    'Cream',
    'Butter',
    'Cheese',
    'Parmesan'
  )
RETURNING *;


INSERT INTO restaurant.ingredient_suppliers (ingredient_id, supplier_id, cost)
SELECT 
  i.ingredient_id,
  s.supplier_id,
  CASE
    WHEN i.ingredient_name = 'Flour' THEN 1.40
    WHEN i.ingredient_name = 'Bread' THEN 0.90
    WHEN i.ingredient_name = 'Eggs' THEN 0.28
    WHEN i.ingredient_name = 'Sugar' THEN 1.25
    WHEN i.ingredient_name = 'Dark Chocolate' THEN 8.90
    WHEN i.ingredient_name = 'Vanilla' THEN 12.00
    WHEN i.ingredient_name = 'Honey' THEN 6.50
  END AS cost
FROM restaurant.ingredients AS i
CROSS JOIN restaurant.suppliers AS s
WHERE s.supplier_name = 'Bakery Wholesale'
  AND i.ingredient_name IN (
    'Flour',
    'Bread',
    'Eggs',
    'Sugar',
    'Dark Chocolate',
    'Vanilla',
    'Honey'
  )
RETURNING *;


INSERT INTO restaurant.ingredient_suppliers (ingredient_id, supplier_id, cost)
SELECT 
  i.ingredient_id,
  s.supplier_id,
  CASE
    WHEN i.ingredient_name = 'Rice' THEN 2.10
    WHEN i.ingredient_name = 'Pasta' THEN 2.40
    WHEN i.ingredient_name = 'Olive Oil' THEN 7.80
  END AS cost
FROM restaurant.ingredients AS i
CROSS JOIN restaurant.suppliers AS s
WHERE s.supplier_name = 'Italian Food Import'
  AND i.ingredient_name IN (
    'Rice',
    'Pasta',
    'Olive Oil'
  )
RETURNING *;


INSERT INTO restaurant.ingredient_suppliers (ingredient_id, supplier_id, cost)
SELECT 
  i.ingredient_id,
  s.supplier_id,
  CASE
    WHEN i.ingredient_name = 'Strawberries' THEN 6.90
    WHEN i.ingredient_name = 'Blueberries' THEN 8.20
    WHEN i.ingredient_name = 'Raspberries' THEN 9.10
    WHEN i.ingredient_name = 'Apples' THEN 2.20
    WHEN i.ingredient_name = 'Lemon' THEN 2.70
  END AS cost
FROM restaurant.ingredients AS i
CROSS JOIN restaurant.suppliers AS s
WHERE s.supplier_name = 'Berry Farm Finland'
  AND i.ingredient_name IN (
    'Strawberries',
    'Blueberries',
    'Raspberries',
    'Apples',
    'Lemon'
  )
RETURNING *;


INSERT INTO restaurant.ingredient_suppliers (ingredient_id, supplier_id, cost)
SELECT 
  i.ingredient_id,
  s.supplier_id,
  CASE
    WHEN i.ingredient_name = 'Coffee Beans' THEN 13.50
    WHEN i.ingredient_name = 'Black Tea' THEN 9.40
    WHEN i.ingredient_name = 'Orange Juice' THEN 2.90
    WHEN i.ingredient_name = 'Apple Juice' THEN 2.60
    WHEN i.ingredient_name = 'Sparkling Water' THEN 1.10
  END AS cost
FROM restaurant.ingredients AS i
CROSS JOIN restaurant.suppliers AS s
WHERE s.supplier_name = 'Beverage Partners'
  AND i.ingredient_name IN (
    'Coffee Beans',
    'Black Tea',
    'Orange Juice',
    'Apple Juice',
    'Sparkling Water'
  )
RETURNING *;


INSERT INTO restaurant.ingredient_suppliers (ingredient_id, supplier_id, cost)
SELECT 
  i.ingredient_id,
  s.supplier_id,
  CASE
    WHEN i.ingredient_name = 'Salt' THEN 0.80
    WHEN i.ingredient_name = 'Black Pepper' THEN 11.50
    WHEN i.ingredient_name = 'Basil' THEN 7.20
    WHEN i.ingredient_name = 'Garlic' THEN 3.40
  END AS cost
FROM restaurant.ingredients AS i
CROSS JOIN restaurant.suppliers AS s
WHERE s.supplier_name = 'Spice House'
  AND i.ingredient_name IN (
    'Salt',
    'Black Pepper',
    'Basil',
    'Garlic'
  )
RETURNING *;


INSERT INTO restaurant.ingredient_suppliers (ingredient_id, supplier_id, cost)
SELECT 
  i.ingredient_id,
  s.supplier_id,
  CASE
    WHEN i.ingredient_name = 'Tomato' THEN 3.20
    WHEN i.ingredient_name = 'Lettuce' THEN 3.60
    WHEN i.ingredient_name = 'Cucumber' THEN 2.90
    WHEN i.ingredient_name = 'Carrot' THEN 1.70
    WHEN i.ingredient_name = 'Apples' THEN 2.80
  END AS cost
FROM restaurant.ingredients AS i
CROSS JOIN restaurant.suppliers AS s
WHERE s.supplier_name = 'Organic Goods Ltd'
  AND i.ingredient_name IN (
    'Tomato',
    'Lettuce',
    'Cucumber',
    'Carrot',
    'Apples'
  )
RETURNING *;


INSERT INTO restaurant.menu_items (
  category_id,
  item_name,
  price,
  preparation_time
)
SELECT
  mc.category_id,
  v.item_name,
  v.price,
  v.preparation_time
FROM (
  VALUES
    -- Starters
    ('Starters', 'Garlic Bread', 5.90, 8),
    ('Starters', 'Shrimp Skewers', 9.90, 12),
    ('Starters', 'Bruschetta', 6.50, 10),

    -- Salads
    ('Salads', 'Caesar Salad', 12.90, 12),
    ('Salads', 'Greek Salad', 11.50, 10),
    ('Salads', 'Salmon Salad', 15.90, 15),

    -- Soups
    ('Soups', 'Mushroom Soup', 8.90, 15),
    ('Soups', 'Tomato Soup', 7.90, 12),
    ('Soups', 'Chicken Soup', 9.50, 18),

    -- Fish Dishes
    ('Fish Dishes', 'Grilled Salmon', 24.90, 25),
    ('Fish Dishes', 'Baked Dorado', 26.50, 30),
    ('Fish Dishes', 'Shrimp Pasta', 18.90, 22),

    -- Meat Dishes
    ('Meat Dishes', 'Beef Steak', 27.50, 30),
    ('Meat Dishes', 'Pork Ribs', 22.90, 35),
    ('Meat Dishes', 'Lamb Chops', 28.90, 32),

    -- Vegetarian
    ('Vegetarian', 'Veggie Pasta', 14.50, 18),
    ('Vegetarian', 'Mushroom Risotto', 15.90, 25),
    ('Vegetarian', 'Stuffed Pepper', 13.90, 22),

    -- Extras
    ('Extras', 'French Fries', 4.90, 10),
    ('Extras', 'Sweet Potato Fries', 5.90, 12),
    ('Extras', 'Rice Side', 3.90, 8),

    -- Desserts
    ('Desserts', 'Chocolate Cake', 7.90, 10),
    ('Desserts', 'Berry Pancakes', 8.50, 15),
    ('Desserts', 'Apple Pie', 7.50, 12),

    -- Drinks
    ('Drinks', 'Black Coffee', 3.50, 5),
    ('Drinks', 'Orange Juice', 4.20, 3),
    ('Drinks', 'Sparkling Water', 2.90, 2),

    -- Breakfast
    ('Breakfast', 'Omelette', 9.90, 12),
    ('Breakfast', 'Pancakes', 10.50, 15),
    ('Breakfast', 'Breakfast Plate', 12.90, 18)
) AS v(category_name, item_name, price, preparation_time)
JOIN restaurant.menu_categories AS mc
  ON mc.category_name = v.category_name
RETURNING *;


INSERT INTO restaurant.menu_item_ingredients (
  menu_item_id,
  ingredient_id,
  quantity
)
SELECT
  mi.menu_item_id,
  i.ingredient_id,
  v.quantity
FROM (
  VALUES
    -- Grilled Salmon
    ('Grilled Salmon', 'Salmon', 0.30),
    ('Grilled Salmon', 'Olive Oil', 0.03),
    ('Grilled Salmon', 'Lemon', 0.05),
    ('Grilled Salmon', 'Salt', 0.01),
    ('Grilled Salmon', 'Black Pepper', 0.01),

    -- Baked Dorado
    ('Baked Dorado', 'Dorado', 0.35),
    ('Baked Dorado', 'Olive Oil', 0.03),
    ('Baked Dorado', 'Lemon', 0.05),
    ('Baked Dorado', 'Garlic', 0.02),
    ('Baked Dorado', 'Salt', 0.01),

    -- Shrimp Pasta
    ('Shrimp Pasta', 'Shrimp', 0.20),
    ('Shrimp Pasta', 'Pasta', 0.18),
    ('Shrimp Pasta', 'Cream', 0.10),
    ('Shrimp Pasta', 'Parmesan', 0.04),
    ('Shrimp Pasta', 'Garlic', 0.02),

    -- Beef Steak
    ('Beef Steak', 'Beef', 0.35),
    ('Beef Steak', 'Olive Oil', 0.03),
    ('Beef Steak', 'Salt', 0.01),
    ('Beef Steak', 'Black Pepper', 0.01),
    ('Beef Steak', 'Potato', 0.20),

    -- Pork Ribs
    ('Pork Ribs', 'Pork', 0.40),
    ('Pork Ribs', 'Garlic', 0.03),
    ('Pork Ribs', 'Honey', 0.04),
    ('Pork Ribs', 'Salt', 0.01),
    ('Pork Ribs', 'Black Pepper', 0.01),

    -- Lamb Chops
    ('Lamb Chops', 'Lamb', 0.35),
    ('Lamb Chops', 'Olive Oil', 0.03),
    ('Lamb Chops', 'Garlic', 0.02),
    ('Lamb Chops', 'Potato', 0.18),
    ('Lamb Chops', 'Black Pepper', 0.01),

    -- Caesar Salad
    ('Caesar Salad', 'Lettuce', 0.12),
    ('Caesar Salad', 'Chicken Breast', 0.15),
    ('Caesar Salad', 'Parmesan', 0.03),
    ('Caesar Salad', 'Bread', 1.00),
    ('Caesar Salad', 'Olive Oil', 0.02),

    -- Mushroom Soup
    ('Mushroom Soup', 'Mushrooms', 0.20),
    ('Mushroom Soup', 'Cream', 0.12),
    ('Mushroom Soup', 'Onion', 0.05),
    ('Mushroom Soup', 'Butter', 0.03),
    ('Mushroom Soup', 'Salt', 0.01),

    -- Chocolate Cake
    ('Chocolate Cake', 'Flour', 0.12),
    ('Chocolate Cake', 'Eggs', 2.00),
    ('Chocolate Cake', 'Sugar', 0.08),
    ('Chocolate Cake', 'Dark Chocolate', 0.10),
    ('Chocolate Cake', 'Butter', 0.06),

    -- Black Coffee
    ('Black Coffee', 'Coffee Beans', 0.02),
    ('Black Coffee', 'Sparkling Water', 0.20)
) AS v(item_name, ingredient_name, quantity)
JOIN restaurant.menu_items AS mi
  ON mi.item_name = v.item_name
JOIN restaurant.ingredients AS i
  ON i.ingredient_name = v.ingredient_name
RETURNING *;



INSERT INTO restaurant.locations (
    location_name,
    address
)
VALUES
    ('Downtown Restaurant', '12 Main Street'),
    ('Riverside Restaurant', '45 River Road'),
    ('Airport Restaurant', '7 Sky Avenue'),
    ('City Mall Restaurant', '101 Mall Boulevard'),
    ('Old Town Restaurant', '88 Historic Street'),
    ('Business Center Restaurant', '19 Office Plaza'),
    ('Green Park Restaurant', '55 Green Lane'),
    ('University Restaurant', '3 Campus Drive'),
    ('Central Station Restaurant', '77 Railway Street'),
    ('Lakeside Restaurant', '9 Lake View')
RETURNING *;



INSERT INTO restaurant.basic_inventory (
  ingredient_id,
  location_id,
  quantity_available
)
SELECT
  i.ingredient_id,
  l.location_id,
  v.quantity_available
FROM (
  VALUES
    ('Downtown Restaurant', 'Salmon', 25),
    ('Downtown Restaurant', 'Beef', 40),
    ('Downtown Restaurant', 'Potato', 120),
    ('Downtown Restaurant', 'Tomato', 80),
    ('Downtown Restaurant', 'Milk', 50),

    ('Riverside Restaurant', 'Dorado', 18),
    ('Riverside Restaurant', 'Shrimp', 30),
    ('Riverside Restaurant', 'Lettuce', 45),
    ('Riverside Restaurant', 'Cream', 35),
    ('Riverside Restaurant', 'Olive Oil', 20),

    ('Airport Restaurant', 'Chicken Breast', 55),
    ('Airport Restaurant', 'Pasta', 70),
    ('Airport Restaurant', 'Rice', 65),
    ('Airport Restaurant', 'Coffee Beans', 25),
    ('Airport Restaurant', 'Sparkling Water', 100),

    ('City Mall Restaurant', 'Pork', 35),
    ('City Mall Restaurant', 'Lamb', 20),
    ('City Mall Restaurant', 'Mushrooms', 40),
    ('City Mall Restaurant', 'Cheese', 30),
    ('City Mall Restaurant', 'Bread', 90)
) AS v(location_name, ingredient_name, quantity_available)
JOIN restaurant.locations AS l
  ON l.location_name = v.location_name
JOIN restaurant.ingredients AS i
  ON i.ingredient_name = v.ingredient_name
RETURNING *;

-- -----------------------------------------------------
-- Oleksandr Sydorskyi
-- Tables: Customers, Orders, Reservations, Customer_Feedback
-- -----------------------------------------------------

-- Populating CRM base (Customers)
INSERT INTO restaurant.customers (customer_name, phone, email)
VALUES
    ('Oleksandr Petrenko', '+380671111111', 'oleksandr@gmail.com'),
    ('Maria Kovalenko', '+380672222222', 'maria@gmail.com'),
    ('Ivan Shevchenko', '+380673333333', 'ivan@gmail.com'),
    ('Anna Bondarenko', '+380674444444', 'anna@gmail.com'),
    ('Dmytro Tkachenko', '+380675555555', 'dmytro@gmail.com'),
    ('Olena Melnyk', '+380676666666', 'olena@gmail.com'),
    ('Andrii Koval', '+380677777777', 'andrii@gmail.com'),
    ('Natalia Polishchuk', '+380678888888', 'natalia@gmail.com'),
    ('Taras Boyko', '+380679999999', 'taras@gmail.com'),
    ('Iryna Savchuk', '+380670000000', 'iryna@gmail.com');

-- Populating reservations book
INSERT INTO restaurant.reservations (customer_id, location_id, reservation_datetime, table_number)
SELECT
    c.customer_id,
    l.location_id,
    v.reservation_datetime,
    v.table_number
FROM (
    VALUES
        ('oleksandr@gmail.com', 'Downtown Restaurant', '2026-05-05 18:00:00'::timestamp, 1),
        ('maria@gmail.com', 'Riverside Restaurant', '2026-05-05 19:00:00'::timestamp, 2),
        ('ivan@gmail.com', 'Airport Restaurant', '2026-05-06 17:30:00'::timestamp, 5),
        ('anna@gmail.com', 'City Mall Restaurant', '2026-05-06 20:00:00'::timestamp, 3),
        ('dmytro@gmail.com', 'Old Town Restaurant', '2026-05-07 18:30:00'::timestamp, 4),
        ('olena@gmail.com', 'Business Center Restaurant', '2026-05-07 19:30:00'::timestamp, 2),
        ('andrii@gmail.com', 'Green Park Restaurant', '2026-05-08 17:00:00'::timestamp, 12),
        ('natalia@gmail.com', 'University Restaurant', '2026-05-08 18:00:00'::timestamp, 1),
        ('taras@gmail.com', 'Central Station Restaurant', '2026-05-09 19:00:00'::timestamp, 6),
        ('iryna@gmail.com', 'Lakeside Restaurant', '2026-05-09 20:00:00'::timestamp, 3)
) AS v(customer_email, location_name, reservation_datetime, table_number)
JOIN restaurant.customers c ON c.email = v.customer_email
JOIN restaurant.locations l ON l.location_name = v.location_name;

-- Creating order shells
INSERT INTO restaurant.orders (location_id, customer_id, order_type, status, created_at)
SELECT
    l.location_id,
    c.customer_id,
    v.order_type,
    v.status,
    v.created_at
FROM (
    VALUES
        ('Downtown Restaurant', 'oleksandr@gmail.com', 'Dine-in', 'Completed', '2026-05-01 12:00:00'::timestamp),
        ('Riverside Restaurant', 'maria@gmail.com', 'Takeaway', 'Completed', '2026-05-01 13:00:00'::timestamp),
        ('Airport Restaurant', 'ivan@gmail.com', 'Delivery', 'Preparing', '2026-05-01 14:00:00'::timestamp),
        ('City Mall Restaurant', 'anna@gmail.com', 'Dine-in', 'Completed', '2026-05-01 15:00:00'::timestamp),
        ('Old Town Restaurant', 'dmytro@gmail.com', 'Takeaway', 'Completed', '2026-05-01 16:00:00'::timestamp),
        ('Business Center Restaurant', 'olena@gmail.com', 'Delivery', 'Preparing', '2026-05-02 12:30:00'::timestamp),
        ('Green Park Restaurant', 'andrii@gmail.com', 'Dine-in', 'Completed', '2026-05-02 18:15:00'::timestamp),
        ('University Restaurant', 'natalia@gmail.com', 'Takeaway', 'Completed', '2026-05-03 09:00:00'::timestamp),
        ('Central Station Restaurant', 'taras@gmail.com', 'Delivery', 'Preparing', '2026-05-03 21:00:00'::timestamp),
        ('Lakeside Restaurant', 'iryna@gmail.com', 'Dine-in', 'Completed', '2026-05-04 19:45:00'::timestamp)
) AS v(location_name, customer_email, order_type, status, created_at)
JOIN restaurant.locations l ON l.location_name = v.location_name
JOIN restaurant.customers c ON c.email = v.customer_email;

-- Adding specific line items for orders 
INSERT INTO restaurant.order_items (order_id, menu_item_id, quantity)
SELECT
    o.order_id,
    mi.menu_item_id,
    v.quantity
FROM (
    VALUES
        ('oleksandr@gmail.com', '2026-05-01 12:00:00'::timestamp, 'Garlic Bread', 2),
        ('maria@gmail.com', '2026-05-01 13:00:00'::timestamp, 'Caesar Salad', 1),
        ('ivan@gmail.com', '2026-05-01 14:00:00'::timestamp, 'Grilled Salmon', 1),
        ('anna@gmail.com', '2026-05-01 15:00:00'::timestamp, 'Beef Steak', 1),
        ('dmytro@gmail.com', '2026-05-01 16:00:00'::timestamp, 'Black Coffee', 2),
        ('olena@gmail.com', '2026-05-02 12:30:00'::timestamp, 'Veggie Pasta', 1),
        ('andrii@gmail.com', '2026-05-02 18:15:00'::timestamp, 'Chocolate Cake', 2),
        ('natalia@gmail.com', '2026-05-03 09:00:00'::timestamp, 'Omelette', 1),
        ('taras@gmail.com', '2026-05-03 21:00:00'::timestamp, 'Tomato Soup', 1),
        ('iryna@gmail.com', '2026-05-04 19:45:00'::timestamp, 'Bruschetta', 3)
) AS v(customer_email, created_at, item_name, quantity)
JOIN restaurant.customers c ON c.email = v.customer_email
JOIN restaurant.orders o ON o.customer_id = c.customer_id AND o.created_at = v.created_at
JOIN restaurant.menu_items mi ON mi.item_name = v.item_name;

-- Populating customer reviews 
INSERT INTO restaurant.customer_feedback (customer_id, order_id, rating, comment)
SELECT
    c.customer_id,
    o.order_id,
    v.rating,
    v.comment
FROM (
    VALUES
        ('oleksandr@gmail.com', '2026-05-01 12:00:00'::timestamp, 5, 'Excellent food and service'),
        ('maria@gmail.com', '2026-05-01 13:00:00'::timestamp, 4, 'Very tasty meals'),
        ('ivan@gmail.com', '2026-05-01 14:00:00'::timestamp, 3, 'Delivery was a bit slow'),
        ('anna@gmail.com', '2026-05-01 15:00:00'::timestamp, 5, 'Amazing atmosphere'),
        ('dmytro@gmail.com', '2026-05-01 16:00:00'::timestamp, 4, 'Good coffee and desserts'),
        ('olena@gmail.com', '2026-05-02 12:30:00'::timestamp, 5, 'Pasta was incredibly fresh'),
        ('andrii@gmail.com', '2026-05-02 18:15:00'::timestamp, 5, 'Best chocolate cake in town'),
        ('natalia@gmail.com', '2026-05-03 09:00:00'::timestamp, 4, 'Hearty breakfast'),
        ('taras@gmail.com', '2026-05-03 21:00:00'::timestamp, 3, 'Soup was cold upon delivery'),
        ('iryna@gmail.com', '2026-05-04 19:45:00'::timestamp, 5, 'Perfect dinner experience')
) AS v(customer_email, created_at, rating, comment)
JOIN restaurant.customers c ON c.email = v.customer_email
JOIN restaurant.orders o ON o.customer_id = c.customer_id AND o.created_at = v.created_at;


-- -----------------------------------------------------
-- Thir Taras
-- Tables: staff, locations, shift_schedules 
-- -----------------------------------------------------

INSERT INTO restaurant.staff (location_id, full_name, role, phone, email) VALUES
(1, 'Taras Petrenko', 'Manager', '+380671111111', 'taras.petrenko@gmail.com'),
(2, 'Olena Koval', 'Barista', '+380672222222', 'olena.koval@gmail.com'),
(3, 'Andriy Shevchuk', 'Cashier', '+380673333333', 'andriy.shevchuk@gmail.com'),
(4, 'Maria Boiko', 'Waiter', '+380674444444', 'maria.boiko@gmail.com'),
(5, 'Ivan Tkachuk', 'Cook', '+380675555555', 'ivan.tkachuk@gmail.com'),
(6, 'Nataliia Melnyk', 'Barista', '+380676666666', 'nataliia.melnyk@gmail.com'),
(7, 'Serhii Levytskyi', 'Manager', '+380677777777', 'serhii.levytskyi@gmail.com'),
(8, 'Roman Savchuk', 'Cashier', '+380678888888', 'Roman.savchuk@gmail.com'),
(9, 'Oleh Hnatiuk', 'Waiter', '+380679999999', 'oleh.hnatiuk@gmail.com'),
(10, 'Tetiana Romaniuk', 'Cook', '+380670000000', 'tetiana.romaniuk@gmail.com');

INSERT INTO restaurant.shift_schedules (staff_id, shift_date, start_time, end_time, shift_role) VALUES
(1, '2026-01-11', '08:00:00', '16:00:00', 'Manager'),
(2, '2025-01-12', '07:00:00', '15:00:00', 'Barista'),
(3, '2026-03-13', '09:00:00', '17:00:00', 'Cashier'),
(4, '2026-01-14', '10:00:00', '18:00:00', 'Waiter'),
(5, '2025-03-15', '06:00:00', '14:00:00', 'Cook'),
(6, '2026-02-11', '07:00:00', '15:00:00', 'Barista'),
(7, '2026-03-17', '08:00:00', '16:00:00', 'Manager'),
(8, '2026-03-18', '09:00:00', '17:00:00', 'Cashier'),
(9, '2025-09-01', '10:00:00', '18:00:00', 'Waiter'),
(10, '2026-03-30', '06:00:00', '14:00:00', 'Cook');

-- =====================================================
-- UPDATE & DELETE SCENARIOS
-- =====================================================

-- =====================================================
-- Taras Tkhir
-- Structure & HR Module
-- =====================================================
UPDATE restaurant.staff
SET phone = '+380681234567'
WHERE staff_id = 1;

UPDATE restaurant.staff
SET role = 'Senior Barista'
WHERE staff_id = 2;

DELETE FROM restaurant.shift_schedules
WHERE schedule_id = 10;

DELETE FROM restaurant.staff
WHERE staff_id = 10;


-- UPDATE: Restaurant address update (due to rebranding or location relocation)
UPDATE restaurant.locations
SET address = '12 Main Street, Suite 100 (Renovated)'
WHERE location_name = 'Downtown Restaurant';

-- DELETE: Closure of the "Lakeside Restaurant" branch (removing the location)
-- Note: Since there are no active orders/reservations linked to this location, deletion will execute without FK violations.
DELETE FROM restaurant.locations
WHERE location_name = 'Lakeside Restaurant';


-- =====================================================
-- Robert Hubskyi
-- Kitchen & Inventory Module
-- =====================================================

-- UPDATE: Price adjustments due to inflation — increasing the price of all desserts by 10%
UPDATE restaurant.menu_items
SET price = ROUND(price * 1.10, 2)
WHERE category_id = (
    SELECT category_id 
    FROM restaurant.menu_categories 
    WHERE category_name = 'Desserts'
);

-- UPDATE: Restocking inventory — adding 50 kg of Potato to the Downtown Restaurant stock
UPDATE restaurant.basic_inventory
SET quantity_available = quantity_available + 50
WHERE ingredient_id = (SELECT ingredient_id FROM restaurant.ingredients WHERE ingredient_name = 'Potato')
  AND location_id = (SELECT location_id FROM restaurant.locations WHERE location_name = 'Downtown Restaurant');

-- DELETE: Removing a low-demand menu item ("Stuffed Pepper") from the active menu
DELETE FROM restaurant.menu_items
WHERE item_name = 'Stuffed Pepper';


-- =====================================================
-- Oleksandr Sydorskyi
-- Business Process Module
-- =====================================================

-- UPDATE: A customer (Dmytro Tkachenko) updated their phone number in the CRM system
UPDATE restaurant.customers
SET phone = '+380675550055'
WHERE email = 'dmytro@gmail.com';

-- UPDATE: Advancing an order workflow status from "Preparing" to "Completed" upon fulfillment
UPDATE restaurant.orders
SET status = 'Completed'
WHERE customer_id = (SELECT customer_id FROM restaurant.customers WHERE email = 'ivan@gmail.com')
  AND created_at = '2026-05-01 14:00:00'::timestamp;

-- DELETE: Deleting negative feedback (spam moderation or resolved customer support dispute)
-- Removes the complaint from Taras Boyko regarding a cold soup delivery
DELETE FROM restaurant.customer_feedback
WHERE customer_id = (SELECT customer_id FROM restaurant.customers WHERE email = 'taras@gmail.com')
  AND order_id = (
      SELECT order_id 
      FROM restaurant.orders 
      WHERE customer_id = (SELECT customer_id FROM restaurant.customers WHERE email = 'taras@gmail.com')
        AND created_at = '2026-05-03 21:00:00'::timestamp
  );

-- DELETE: A customer (Iryna Savchuk) canceled their scheduled table reservation
DELETE FROM restaurant.reservations
WHERE customer_id = (SELECT customer_id FROM restaurant.customers WHERE email = 'iryna@gmail.com')
  AND reservation_datetime = '2026-05-09 20:00:00'::timestamp;
