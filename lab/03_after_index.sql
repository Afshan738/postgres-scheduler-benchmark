
-- LAB 3: QUERY AFTER INDEX

--  GOAL: See how much faster the query is


\echo 'LAB 3: Query After Index'
EXPLAIN (ANALYZE, BUFFERS) 
SELECT * FROM urls 
WHERE last_checked_at < NOW() - INTERVAL '1 hour'
  AND is_active = true
LIMIT 100;

\echo ''
\echo 'What to look for:'
\echo '   - "Index Scan" instead of "Seq Scan"'
\echo '   - Execution Time (should be < 1ms)'
\echo ''
\echo ' Next: \i lab/04_partial_index.sql'