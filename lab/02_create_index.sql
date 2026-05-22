
-- LAB 2: CREATE INDEX
--  GOAL: Add a B-tree index on last_checked_at
\echo ' LAB 2: Creating B-tree Index'


CREATE INDEX CONCURRENTLY idx_last_checked ON urls(last_checked_at);

\echo ' Index created!'
\echo ''
\echo ' Next: \i lab/03_after_index.sql'