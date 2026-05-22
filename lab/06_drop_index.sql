-- LAB 6: DROP INDEX (See Seq Scan Again)
--  GOAL: Prove that index was helping

\echo ' LAB 6: Dropping Index'


DROP INDEX idx_last_checked;

\echo ' Index dropped!'
\echo ''
\echo 'Run this query to see Seq Scan again:'
\echo ''
\echo 'EXPLAIN (ANALYZE, BUFFERS) '
\echo 'SELECT * FROM urls '
\echo 'WHERE last_checked_at < NOW() - INTERVAL ''1 hour'''
\echo '  AND is_active = true '
\echo 'LIMIT 100;'
\echo ''
\echo ' Next: \i lab/07_disable_indexscan.sql'