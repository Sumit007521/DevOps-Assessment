INSERT INTO hotel_bookings (
    id,
    org_id,
    hotel_id,
    city,
    checkin_date,
    checkout_date,
    amount,
    status,
    created_at
)
SELECT
    gen_random_uuid(),
    CASE (g % 5)
        WHEN 0 THEN '11111111-1111-1111-1111-111111111111'::uuid
        WHEN 1 THEN '22222222-2222-2222-2222-222222222222'::uuid
        WHEN 2 THEN '33333333-3333-3333-3333-333333333333'::uuid
        WHEN 3 THEN '44444444-4444-4444-4444-444444444444'::uuid
        ELSE '55555555-5555-5555-5555-555555555555'::uuid
    END,
    CONCAT('HOTEL-', g),
    CASE (g % 4)
        WHEN 0 THEN 'delhi'
        WHEN 1 THEN 'mumbai'
        WHEN 2 THEN 'bangalore'
        ELSE 'chandigarh'
    END,
    CURRENT_DATE + (g % 10),
    CURRENT_DATE + ((g % 10) + 2),
    (1000 + (g * 100)),
    CASE (g % 4)
        WHEN 0 THEN 'confirmed'
        WHEN 1 THEN 'cancelled'
        WHEN 2 THEN 'pending'
        ELSE 'completed'
    END,
    NOW() - ((g % 30) * INTERVAL '1 day')
FROM generate_series(1,100) AS g;

-- Insert booking events

INSERT INTO booking_events (
    booking_id,
    event_type,
    payload,
    created_at
)
SELECT
    id,
    'BOOKING_CREATED',
    '{"source":"web"}'::jsonb,
    NOW()
FROM hotel_bookings
LIMIT 30;