
-- POSTGRES SCHEDULER BENCHMARK - SETUP


\echo ' Starting Scheduler Benchmark Setup...'
\timing on

-- Drop existing objects if any
DROP TABLE IF EXISTS urls CASCADE;

-- Creating table urls....
CREATE TABLE urls (
    id SERIAL PRIMARY KEY,
    url TEXT NOT NULL,
    status_code INT,
    last_checked_at TIMESTAMPTZ,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- using this query we will Seed 500,000 rows
\echo 'Seeding 500,000 URLs...'

INSERT INTO urls (url, status_code, last_checked_at, is_active)
SELECT 
    'https://example.com/page/' || generate_series(1, 500000),
    CASE WHEN random() < 0.9 THEN 200 ELSE 500 END,
    NOW() - (random() * INTERVAL '30 days'),
    CASE WHEN random() < 0.85 THEN true ELSE false END
FROM generate_series(1, 500000);

-- Update statistics
ANALYZE urls;

\echo 'Setup complete!'
\echo 'Total URLs: ' || (SELECT COUNT(*) FROM urls);
\echo 'Active URLs: ' || (SELECT COUNT(*) FROM urls WHERE is_active = true);
\echo 'Inactive URLs: ' || (SELECT COUNT(*) FROM urls WHERE is_active = false);