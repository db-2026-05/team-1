-- =====================================================
-- Hubskyi Robert
-- =====================================================
CREATE OR REPLACE VIEW restaurant.menu_item_price_list AS
SELECT
    item_name,
    price,
    preparation_time
FROM restaurant.menu_items;


CREATE OR REPLACE VIEW restaurant.expensive_menu_items AS
SELECT
    *
FROM restaurant.menu_items
WHERE price > 20;


CREATE OR REPLACE VIEW restaurant.expensive_menu_item_summary AS
SELECT
    item_name,
    price
FROM restaurant.menu_items
WHERE price > 20;


CREATE OR REPLACE VIEW restaurant.menu_items_with_categories AS
SELECT
    mi.item_name,
    mi.price,
    mi.preparation_time,
    mc.category_name
FROM restaurant.menu_items AS mi
JOIN restaurant.menu_categories AS mc
    ON mi.category_id = mc.category_id;


CREATE OR REPLACE VIEW restaurant.menu_item_recipe_details AS
SELECT
    mi.item_name,
    i.ingredient_name,
    mii.quantity,
    i.unit
FROM restaurant.menu_items AS mi
JOIN restaurant.menu_item_ingredients AS mii
    ON mi.menu_item_id = mii.menu_item_id
JOIN restaurant.ingredients AS i
    ON mii.ingredient_id = i.ingredient_id;


CREATE OR REPLACE VIEW restaurant.complex_menu_items AS
SELECT
    mi.item_name,
    COUNT(mii.ingredient_id) AS ingredient_count
FROM restaurant.menu_items AS mi
JOIN restaurant.menu_item_ingredients AS mii
    ON mi.menu_item_id = mii.menu_item_id
GROUP BY mi.menu_item_id, mi.item_name
HAVING COUNT(mii.ingredient_id) > (
    SELECT AVG(ingredient_total)
    FROM (
        SELECT COUNT(*) AS ingredient_total
        FROM restaurant.menu_item_ingredients
        GROUP BY menu_item_id
    ) AS ingredient_counts
);


CREATE OR REPLACE VIEW restaurant.kitchen_entities AS
SELECT
    ingredient_name AS entity_name,
    'Ingredient' AS entity_type
FROM restaurant.ingredients

UNION ALL

SELECT
    supplier_name AS entity_name,
    'Supplier' AS entity_type
FROM restaurant.suppliers;


CREATE OR REPLACE VIEW restaurant.category_menu_summary AS
SELECT
    category_name,
    COUNT(*) AS number_of_items,
    ROUND(AVG(price), 2) AS average_price
FROM restaurant.menu_items_with_categories
GROUP BY category_name;


CREATE OR REPLACE VIEW restaurant.available_basic_inventory AS
SELECT
    inventory_id,
    ingredient_id,
    location_id,
    quantity_available
FROM restaurant.basic_inventory
WHERE quantity_available > 0
WITH CHECK OPTION;


CREATE OR REPLACE VIEW restaurant.inventory_report AS
SELECT
    l.location_name,
    i.ingredient_name,
    bi.quantity_available,
    i.unit
FROM restaurant.basic_inventory AS bi
JOIN restaurant.ingredients AS i
    ON bi.ingredient_id = i.ingredient_id
JOIN restaurant.locations AS l
    ON bi.location_id = l.location_id;

-- =====================================================
-- Oleksandr Sydorskyi
-- Business Process Module
-- =====================================================

-- Mixed View: selected columns from completed orders only
CREATE OR REPLACE VIEW restaurant.completed_orders_view AS
SELECT
    order_id,
    customer_id,
    location_id,
    created_at
FROM restaurant.orders
WHERE status = 'Completed';

-- Join View: customers and their orders
CREATE OR REPLACE VIEW restaurant.customer_orders_view AS
SELECT
    c.customer_name,
    o.order_id,
    o.order_type,
    o.status,
    o.created_at
FROM restaurant.customers c
JOIN restaurant.orders o
    ON c.customer_id = o.customer_id;

-- UNION View: all customer activities
CREATE OR REPLACE VIEW restaurant.customer_activity_view AS
SELECT
    customer_id,
    reservation_datetime AS activity_date,
    'Reservation' AS activity_type
FROM restaurant.reservations

UNION

SELECT
    customer_id,
    created_at AS activity_date,
    'Order' AS activity_type
FROM restaurant.orders;

-- =====================================================
-- Sample SELECT statements
-- =====================================================

-- SELECT * FROM restaurant.completed_orders_view;
-- SELECT * FROM restaurant.customer_orders_view;
-- SELECT * FROM restaurant.customer_activity_view;


-- =====================================================
-- Thir Taras
-- =====================================================

CREATE OR REPLACE VIEW restaurant.vw_staff_basic AS
SELECT 
    full_name, 
    role
FROM restaurant.staff;


CREATE OR REPLACE VIEW restaurant.vw_managers AS
SELECT 
    staff_id,
    location_id,
    full_name,
    role,
    phone,
    email
FROM restaurant.staff
WHERE role = 'Manager';


CREATE OR REPLACE VIEW restaurant.vw_barista_contacts AS
SELECT 
    full_name, 
    email
FROM restaurant.staff
WHERE role LIKE '%Barista%';


CREATE OR REPLACE VIEW restaurant.vw_staff_locations AS
SELECT
    s.staff_id,
    s.full_name,
    s.role,
    l.location_name,
    l.address
FROM restaurant.staff s
JOIN restaurant.locations l
    ON s.location_id = l.location_id;


CREATE OR REPLACE VIEW restaurant.vw_active_locations AS
SELECT 
    location_id, 
    location_name, 
    address
FROM restaurant.locations
WHERE location_id IN (
    SELECT DISTINCT location_id
    FROM restaurant.staff
    WHERE location_id IS NOT NULL
);


CREATE OR REPLACE VIEW restaurant.vw_management_kitchen AS
SELECT 
    full_name, 
    role
FROM restaurant.staff
WHERE role = 'Manager'

UNION

SELECT 
    full_name, 
    role
FROM restaurant.staff
WHERE role = 'Cook';


CREATE OR REPLACE VIEW restaurant.vw_staff_summary AS
SELECT 
    full_name, 
    location_name
FROM restaurant.vw_staff_locations;


CREATE OR REPLACE VIEW restaurant.vw_baristas_only AS
SELECT 
    staff_id,
    location_id,
    full_name,
    role,
    phone,
    email
FROM restaurant.staff
WHERE role LIKE '%Barista%'
WITH CHECK OPTION;
