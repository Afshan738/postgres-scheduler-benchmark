
-- LAB 4: PARTIAL INDEX

-- GOAL: Create smaller index for active URLs only


\echo ' LAB 4: Creating Partial Index (Active URLs Only)'


CREATE INDEX CONCURRENTLY idx_partial_last_checked ON urls(last_checked_at) 
WHERE is_active = true;

\echo 'Partial index created!'
\echo ''
\echo 'Next: \i lab/05_size_comparison.sql'