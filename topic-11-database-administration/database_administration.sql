-- =====================================================
-- Hubskyi Robert
-- =====================================================

-- Create roles
CREATE ROLE kitchen_role;
CREATE ROLE inventory_role;
CREATE ROLE supplier_role;
CREATE ROLE report_role;

-- Create users
CREATE USER john WITH PASSWORD 'fajbbaoienqfoiw';
CREATE USER bob WITH PASSWORD 'qwnklnqsnvio';
CREATE USER julia WITH PASSWORD 'lsjoivhweognw';
CREATE USER elizabeth WITH PASSWORD 'dgwjoihorwgnkwl';

-- Assign roles to users
GRANT kitchen_role TO john;
GRANT inventory_role TO bob;
GRANT supplier_role TO julia;
GRANT report_role TO elizabeth;

-- Give access to restaurant schema
GRANT USAGE ON SCHEMA restaurant TO kitchen_role;
GRANT USAGE ON SCHEMA restaurant TO inventory_role;
GRANT USAGE ON SCHEMA restaurant TO supplier_role;
GRANT USAGE ON SCHEMA restaurant TO report_role;

GRANT SELECT(ingredient_id, location_id, quantity_available) ON restaurant.basic_inventory TO inventory_role;
GRANT SELECT 
ON restaurant.menu_items,
   restaurant.menu_categories,
   restaurant.menu_item_ingredients,
   restaurant.ingredients,
   restaurant.basic_inventory
TO kitchen_role;

GRANT SELECT
ON restaurant.suppliers,
   restaurant.ingredient_suppliers,
   restaurant.ingredients
TO supplier_role;

GRANT INSERT
ON restaurant.suppliers,
   restaurant.ingredient_suppliers
TO supplier_role;

GRANT UPDATE(contact_info)
ON restaurant.suppliers
TO supplier_role;

GRANT UPDATE(cost)
ON restaurant.ingredient_suppliers
TO supplier_role;

GRANT SELECT
ON restaurant.inventory_report,
   restaurant.menu_item_price_list,
   restaurant.menu_item_recipe_details,
   restaurant.menu_items_with_categories,
   restaurant.expensive_menu_items
TO report_role;

REVOKE INSERT, UPDATE, DELETE
ON restaurant.menu_items
FROM kitchen_role;

REVOKE INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA restaurant
FROM report_role;

REVOKE UPDATE
ON restaurant.ingredients
FROM inventory_role;

REVOKE DELETE
ON restaurant.suppliers,
   restaurant.ingredient_suppliers
FROM supplier_role;

-- =====================================================
-- Oleksandr Sydorskyi
-- =====================================================

-- Create roles

CREATE ROLE readonly;
CREATE ROLE readwrite;

-- Grant schema access

GRANT USAGE ON SCHEMA restaurant TO readonly;
GRANT USAGE ON SCHEMA restaurant TO readwrite;

-- Read-only permissions

GRANT SELECT ON ALL TABLES IN SCHEMA restaurant TO readonly;

-- Create users

CREATE USER waiter WITH PASSWORD 'waiterPassword';
CREATE USER manager WITH PASSWORD 'managerPassword';

-- Assign roles

GRANT readonly TO waiter;
GRANT readwrite TO manager;

-- Read-write permissions

GRANT SELECT ON ALL TABLES IN SCHEMA restaurant TO readwrite;

GRANT INSERT, UPDATE ON restaurant.orders TO readwrite;
GRANT INSERT, UPDATE ON restaurant.reservations TO readwrite;
GRANT INSERT, UPDATE ON restaurant.customer_feedback TO readwrite;

-- Verify privileges

SELECT grantee, table_name, privilege_type
FROM information_schema.table_privileges
WHERE grantee = 'readwrite';

-- Revoke example

REVOKE UPDATE ON restaurant.orders FROM readwrite;

-- Cleanup examples (optional)

-- REVOKE ALL ON ALL TABLES IN SCHEMA restaurant
-- FROM readonly CASCADE;

-- DROP ROLE readonly;


-- =====================================================
-- Taras Tkhir
-- =====================================================

CREATE ROLE restaurant_employee_role;
CREATE ROLE restaurant_manager_role;

GRANT USAGE ON SCHEMA restaurant TO restaurant_employee_role;
GRANT SELECT ON ALL TABLES IN SCHEMA restaurant TO restaurant_employee_role;

GRANT USAGE ON SCHEMA restaurant TO restaurant_manager_role;
GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA restaurant
TO restaurant_manager_role;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA restaurant
TO restaurant_manager_role;

CREATE USER employee_user
WITH PASSWORD 'employee123456';

CREATE USER manager_user
WITH PASSWORD 'manager123456';

GRANT restaurant_employee_role TO employee_user;
GRANT restaurant_manager_role TO manager_user;

REVOKE INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA restaurant
FROM restaurant_employee_role;

REVOKE ALL
ON ALL SEQUENCES IN SCHEMA restaurant
FROM restaurant_employee_role;

-- Optional cleanup after testing

-- DROP USER IF EXISTS robert;
-- DROP USER IF EXISTS john;
-- DROP USER IF EXISTS bob;
-- DROP USER IF EXISTS julia;
-- DROP USER IF EXISTS elizabeth;
-- DROP USER IF EXISTS waiter;
-- DROP USER IF EXISTS manager;
-- DROP USER IF EXISTS employee_user;
-- DROP USER IF EXISTS manager_user;

-- DROP ROLE IF EXISTS manager_role;
-- DROP ROLE IF EXISTS kitchen_role;
-- DROP ROLE IF EXISTS inventory_role;
-- DROP ROLE IF EXISTS supplier_role;
-- DROP ROLE IF EXISTS report_role;
-- DROP ROLE IF EXISTS readonly;
-- DROP ROLE IF EXISTS readwrite;
-- DROP ROLE IF EXISTS restaurant_employee_role;
-- DROP ROLE IF EXISTS restaurant_manager_role;
