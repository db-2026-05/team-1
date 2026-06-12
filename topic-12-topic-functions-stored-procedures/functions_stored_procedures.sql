-- =====================================================
-- TASK 12: FUNCTIONS & STORED PROCEDURES
-- Restaurant Database
-- =====================================================


-- =====================================================
-- Taras Tkhir
-- HR + Structure Module
-- =====================================================

-- FUNCTION: count staff per location
CREATE OR REPLACE FUNCTION restaurant.get_staff_count(
    p_location_id BIGINT
)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_count INT;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM restaurant.staff
    WHERE location_id = p_location_id;

    RETURN v_count;
END;
$$;

-- TEST
SELECT restaurant.get_staff_count(1);


-- PROCEDURE (UPDATE): update staff role
CREATE OR REPLACE PROCEDURE restaurant.update_staff_role(
    p_staff_id BIGINT,
    p_new_role VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE restaurant.staff
    SET role = p_new_role
    WHERE staff_id = p_staff_id;
END;
$$;

-- TEST
CALL restaurant.update_staff_role(1, 'Senior Manager');


-- PROCEDURE (SELECT): get staff schedule
CREATE OR REPLACE PROCEDURE restaurant.get_staff_schedule(
    p_staff_id BIGINT
)
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT shift_date, start_time, end_time, shift_role
        FROM restaurant.shift_schedules
        WHERE staff_id = p_staff_id
    LOOP
        RAISE NOTICE 'Date: %, % - %, Role: %',
            rec.shift_date, rec.start_time, rec.end_time, rec.shift_role;
    END LOOP;
END;
$$;

-- TEST
CALL restaurant.get_staff_schedule(1);



-- =====================================================
-- Robert Hubskyi
-- Kitchen + Inventory Module
-- =====================================================

-- FUNCTION: ingredient availability check
CREATE OR REPLACE FUNCTION restaurant.check_ingredient_availability(
    p_location_id BIGINT,
    p_ingredient_id BIGINT,
    p_required_qty BIGINT
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    v_qty BIGINT;
BEGIN
    SELECT quantity_available
    INTO v_qty
    FROM restaurant.basic_inventory
    WHERE location_id = p_location_id
      AND ingredient_id = p_ingredient_id;

    RETURN COALESCE(v_qty, 0) >= p_required_qty;
END;
$$;

-- TEST
SELECT restaurant.check_ingredient_availability(1, 1, 10);


-- PROCEDURE (UPDATE): restock inventory
CREATE OR REPLACE PROCEDURE restaurant.restock_inventory(
    p_location_id BIGINT,
    p_ingredient_id BIGINT,
    p_qty BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE restaurant.basic_inventory
    SET quantity_available = quantity_available + p_qty
    WHERE location_id = p_location_id
      AND ingredient_id = p_ingredient_id;
END;
$$;

-- TEST
CALL restaurant.restock_inventory(1, 1, 50);


-- PROCEDURE (INSERT): add menu item ingredient
CREATE OR REPLACE PROCEDURE restaurant.add_menu_item_ingredient(
    p_menu_item_id BIGINT,
    p_ingredient_id BIGINT,
    p_qty NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO restaurant.menu_item_ingredients(
        menu_item_id,
        ingredient_id,
        quantity
    )
    VALUES (p_menu_item_id, p_ingredient_id, p_qty);
END;
$$;

-- TEST
CALL restaurant.add_menu_item_ingredient(1, 1, 0.25);



-- =====================================================
-- Oleksandr Sydorskyi
-- Business Process Module
-- =====================================================

-- FUNCTION: calculate order total
CREATE OR REPLACE FUNCTION restaurant.calculate_order_total(
    p_order_id BIGINT
)
RETURNS NUMERIC(10,2)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total NUMERIC(10,2);
BEGIN
    SELECT COALESCE(SUM(mi.price * oi.quantity), 0)
    INTO v_total
    FROM restaurant.order_items oi
    JOIN restaurant.menu_items mi
        ON mi.menu_item_id = oi.menu_item_id
    WHERE oi.order_id = p_order_id;

    RETURN v_total;
END;
$$;

-- TEST
SELECT restaurant.calculate_order_total(1);


-- FUNCTION: average rating
CREATE OR REPLACE FUNCTION restaurant.get_average_rating()
RETURNS NUMERIC(3,2)
LANGUAGE plpgsql
AS $$
DECLARE
    v_avg NUMERIC(3,2);
BEGIN
    SELECT COALESCE(ROUND(AVG(rating), 2), 0)
    INTO v_avg
    FROM restaurant.customer_feedback;

    RETURN v_avg;
END;
$$;

-- TEST
SELECT restaurant.get_average_rating();


-- PROCEDURE (INSERT): add customer
CREATE OR REPLACE PROCEDURE restaurant.add_customer(
    p_name VARCHAR,
    p_phone VARCHAR,
    p_email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO restaurant.customers(customer_name, phone, email)
    VALUES (p_name, p_phone, p_email);
END;
$$;

-- TEST
CALL restaurant.add_customer('Test User', '+380000000000', 'test@test.com');


-- PROCEDURE (SELECT): get customer orders
CREATE OR REPLACE PROCEDURE restaurant.get_customer_orders(
    p_customer_id BIGINT
)
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT order_id, order_type, status, created_at
        FROM restaurant.orders
        WHERE customer_id = p_customer_id
    LOOP
        RAISE NOTICE 'Order: %, Type: %, Status: %, Date: %',
            rec.order_id, rec.order_type, rec.status, rec.created_at;
    END LOOP;
END;
$$;

-- TEST
CALL restaurant.get_customer_orders(1);


-- PROCEDURE (UPDATE): update order status
CREATE OR REPLACE PROCEDURE restaurant.update_order_status(
    p_order_id BIGINT,
    p_status VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE restaurant.orders
    SET status = p_status
    WHERE order_id = p_order_id;
END;
$$;

-- TEST
CALL restaurant.update_order_status(1, 'Completed');

