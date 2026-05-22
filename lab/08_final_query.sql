
-- LAB 8: FINAL PRODUCTION QUERY
--  GOAL: See the optimized production query

\echo ' LAB 8: Final Production Query'


-- Make sure indexes exist
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_partial_last_checked ON urls(last_checked_at) 
WHERE is_active = true;

-- Final query
EXPLAIN (ANALYZE, BUFFERS) 
SELECT * FROM urls 
WHERE last_checked_at < NOW() - INTERVAL '5 minutes'
  AND is_active = true
ORDER BY last_checked_at
LIMIT 100;

\echo ''
\echo ' Lab Complete!'
\echo ''
\echo 'Summary of what you learned:'
\echo '   1. Seq Scan reads all rows (slow)'
\echo '   2. Index Scan jumps to matching rows (fast)'
\echo '   3. LIMIT makes Index Scan stop early'
\echo '   4. Partial indexes are smaller and faster'
\echo '   5. PostgreSQL automatically chooses best method'