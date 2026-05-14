-- ================================================================
-- SQL DDL TEMPLATE (TOPIC 04)
-- ================================================================
-- WHAT SHOULD BE ADDED HERE:
-- 1) Full PostgreSQL DDL for your finalized schema.
-- 2) CREATE TABLE statements for all entities from your ER diagram.
-- 3) Primary keys, foreign keys, NOT NULL, UNIQUE, CHECK constraints.
-- 4) Indexes for important search/join columns.
-- 5) Clean structure and comments (group by tables/constraints/indexes).
--
-- RECOMMENDED ORDER:
-- 1) Tables
-- 2) Constraints (if not inline)
-- 3) Indexes
--
-- TEAM NOTE:
-- Add short attribution comments for who implemented which part.
-- Example:
-- [Name] - users, roles, permissions tables
-- [Name] - orders, payments, invoices tables
--
-- IMPORTANT:
-- The script must run in PostgreSQL and produce a working schema that
-- matches your approved ER diagram and conceptual schema.
-- Submit this as one SQL file.
-- ================================================================

-- Add your DDL below this line

CREATE SCHEMA IF NOT EXISTS restaurant;

-- =====================================================
-- Taras Tkhir
-- HR + Structure Module
-- Tables: locations, staff, shift_schedules
-- =====================================================

CREATE TABLE restaurant.locations (
    location_id bigserial PRIMARY KEY,
    location_name varchar(50) NOT NULL,
    address varchar(100) NOT NULL
);

CREATE TABLE restaurant.staff (
    staff_id bigserial PRIMARY KEY,
    location_id bigint,
    full_name varchar(50),
    role varchar(50),
    phone varchar(50),
    email varchar(255),

    FOREIGN KEY (location_id)
    REFERENCES restaurant.locations(location_id)
);

CREATE TABLE restaurant.shift_schedules (
    schedule_id bigserial PRIMARY KEY,
    staff_id bigint,
    shift_date date,
    start_time time,
    end_time time,
    shift_role varchar(50),

    FOREIGN KEY (staff_id)
    REFERENCES restaurant.staff(staff_id)
);

-- =====================================================
-- Robert Hubskyi
-- Kitchen + Inventory Module
-- Tables: menu_categories, menu_items, ingredients,
-- menu_item_ingredients, suppliers,
-- ingredient_suppliers, basic_inventory
-- =====================================================

CREATE TABLE restaurant.menu_categories (
  category_id bigserial PRIMARY KEY,
  category_name varchar(30) NOT NULL
);

CREATE TABLE restaurant.menu_items (
  menu_item_id bigserial PRIMARY KEY,
  category_id bigint NOT NULL,
  item_name varchar(30) NOT NULL,
  price numeric(10,2) NOT NULL,
  preparation_time int NOT NULL,

  CONSTRAINT fk_menu_items_category
      FOREIGN KEY (category_id)
      REFERENCES restaurant.menu_categories(category_id)
);

CREATE TABLE restaurant.ingredients (
  ingredient_id bigserial PRIMARY KEY,
  ingredient_name varchar(30) NOT NULL,
  unit varchar(10) NOT NULL
);

CREATE TABLE restaurant.menu_item_ingredients (
  menu_item_id bigint REFERENCES restaurant.menu_items(menu_item_id),
  ingredient_id bigint REFERENCES restaurant.ingredients(ingredient_id),
  quantity numeric(10,2) NOT NULL,
  PRIMARY KEY(menu_item_id, ingredient_id)
);

CREATE TABLE restaurant.suppliers (
  supplier_id bigserial PRIMARY KEY,
  supplier_name varchar(30) NOT NULL,
  contact_info varchar(40)
);

CREATE TABLE restaurant.ingredient_suppliers (
  ingredient_id bigint REFERENCES restaurant.ingredients(ingredient_id),
  supplier_id bigint REFERENCES restaurant.suppliers(supplier_id),
  cost numeric(10, 2) NOT NULL,
  PRIMARY KEY(ingredient_id, supplier_id)
);

CREATE TABLE restaurant.basic_inventory (
  inventory_id bigserial PRIMARY KEY,
  ingredient_id bigint NOT NULL REFERENCES restaurant.ingredients(ingredient_id),
  location_id bigint NOT NULL REFERENCES restaurant.locations(location_id),
  quantity_available bigint NOT NULL CHECK (quantity_available >= 0),
  UNIQUE(ingredient_id, location_id)
);

-- =====================================================
-- Oleksandr Sydorskyi
-- Business Process Module
-- Tables: customers, orders, order_items,
-- reservations, customer_feedback
-- =====================================================

CREATE TABLE restaurant.customers (
  customer_id bigserial PRIMARY KEY,
  customer_name varchar(100) NOT NULL,
  phone varchar(20),
  email varchar(255) UNIQUE
);

CREATE TABLE restaurant.orders (
    order_id bigserial PRIMARY KEY,
    location_id bigint NOT NULL,
    customer_id bigint NOT NULL,
    order_type varchar(20) NOT NULL,
    status varchar(20) NOT NULL,
    created_at timestamp NOT NULL DEFAULT current_timestamp,

    CONSTRAINT fk_orders_location
        FOREIGN KEY (location_id)
        REFERENCES restaurant.locations(location_id),

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES restaurant.customers(customer_id)
);

CREATE TABLE restaurant.order_items (
    order_item_id bigserial PRIMARY KEY,
    order_id bigint NOT NULL,
    menu_item_id bigint NOT NULL,
    quantity int NOT NULL DEFAULT 1,

    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES restaurant.orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_order_items_menu_item
        FOREIGN KEY (menu_item_id)
        REFERENCES restaurant.menu_items(menu_item_id),

    CONSTRAINT chk_order_item_quantity
        CHECK (quantity > 0)
);

CREATE TABLE restaurant.reservations (
    reservation_id bigserial PRIMARY KEY,
    location_id bigint NOT NULL,
    customer_id bigint NOT NULL,
    reservation_datetime timestamp NOT NULL,
    table_number int NOT NULL,

    CONSTRAINT fk_reservations_location
        FOREIGN KEY (location_id)
        REFERENCES restaurant.locations(location_id),

    CONSTRAINT fk_reservations_customer
        FOREIGN KEY (customer_id)
        REFERENCES restaurant.customers(customer_id),

    CONSTRAINT chk_table_number
        CHECK (table_number > 0)
);

CREATE TABLE restaurant.customer_feedback (
    feedback_id bigserial PRIMARY KEY,
    order_id bigint NOT NULL,
    customer_id bigint NOT NULL,
    rating int NOT NULL,
    comment text,

    CONSTRAINT fk_feedback_order
        FOREIGN KEY (order_id)
        REFERENCES restaurant.orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_feedback_customer
        FOREIGN KEY (customer_id)
        REFERENCES restaurant.customers(customer_id),

    CONSTRAINT chk_feedback_rating
        CHECK (rating BETWEEN 1 AND 5)
);

-- =====================================================
-- Shared Work
-- Indexes
-- =====================================================

CREATE INDEX idx_menu_items_category_id
ON restaurant.menu_items(category_id);

CREATE INDEX idx_menu_item_ingredients_ingredient_id
ON restaurant.menu_item_ingredients(ingredient_id);

CREATE INDEX idx_ingredient_suppliers_supplier_id
ON restaurant.ingredient_suppliers(supplier_id);

CREATE INDEX idx_basic_inventory_ingredient_id
ON restaurant.basic_inventory(ingredient_id);

CREATE INDEX idx_basic_inventory_location_id
ON restaurant.basic_inventory(location_id);

CREATE INDEX idx_orders_customer_id
ON restaurant.orders(customer_id);

CREATE INDEX idx_orders_location_id
ON restaurant.orders(location_id);

CREATE INDEX idx_order_items_order_id
ON restaurant.order_items(order_id);

CREATE INDEX idx_reservations_customer_id
ON restaurant.reservations(customer_id);

CREATE INDEX idx_customer_feedback_order_id
ON restaurant.customer_feedback(order_id);

