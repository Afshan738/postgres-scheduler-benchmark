
-- LAB 1: BASELINE QUERY (No Index)

--  GOAL: See how slow the query is without index
-- 
-- Run this with: \i lab/01_baseline.sql
-- Or copy the query below

\echo 'LAB 1: Baseline Query - No Index'


EXPLAIN (ANALYZE, BUFFERS) 
SELECT * FROM urls 
WHERE last_checked_at < NOW() - INTERVAL '1 hour'
  AND is_active = true
LIMIT 100;

\echo ''
\echo ' What to look for:'
\echo '   - "Seq Scan" means it scanned ALL rows'
\echo '   - Execution Time (likely 100-200ms)'
\echo ''
\echo ' Next: \i lab/02_create_index.sql'
