
-- LAB 7: DISABLE INDEX SCAN (Force Bitmap)
-- GOAL: See what happens when PostgreSQL cannot use Index Scan

\echo ' LAB 7: Disabling Index Scan'


SET enable_indexscan = OFF;

EXPLAIN (ANALYZE, BUFFERS) 
SELECT * FROM urls 
WHERE last_checked_at < NOW() - INTERVAL '1 hour'
  AND is_active = true
LIMIT 100;

SET enable_indexscan = ON;

\echo ''
\echo 'What to look for:'
\echo '   - Bitmap Scan (much slower than Index Scan)'
\echo '   - Compare execution time'
\echo ''
\echo ' Next: \i lab/08_final_query.sql'