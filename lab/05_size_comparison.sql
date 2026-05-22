
-- LAB 5: INDEX SIZE COMPARISON

-- GOAL: See how much smaller partial index is


\echo ' LAB 5: Index Size Comparison'

SELECT 
    indexname,
    pg_size_pretty(pg_relation_size(indexname::regclass)) as size
FROM pg_indexes 
WHERE tablename = 'urls' 
  AND indexname IN ('idx_last_checked', 'idx_partial_last_checked');

\echo ''
\echo ' What to look for:'
\echo '   - Partial index should be smaller (15-30%)'
\echo ''
\echo ' Next: \i lab/06_drop_index.sql'