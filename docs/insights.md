---

## `docs/insights.md` (What I Learned )

# PostgreSQL Performance Insights

## What I learned optimizing 500,000 rows

### 1. Indexes are not always faster

I tested the same query on a small table and a large table.

Small table (100 rows):

- Sequential scan: 0.05 ms
- Index scan: 0.12 ms

The index was actually slower because of the overhead. It has to check the index first, then go to the table.

Large table (500,000 rows):

- Sequential scan: 121 ms
- Index scan: 0.141 ms

The index wins when the table has enough rows. The crossover point is around 10,000 to 50,000 rows.

### 2. LIMIT makes index scan shine

Same query. Same index. Only difference is LIMIT.

Without LIMIT:

- Finds all matching rows (424,285 of them)
- Takes 217 ms

With LIMIT 100:

- Stops after finding 100 rows
- Takes 0.141 ms

Always use LIMIT for scheduler queries.

### 3. Partial indexes save space

I created two indexes on the same column:

Regular index (all rows): 11 MB
Partial index (where is_active = true): 9.3 MB

The partial index is 17% smaller with the same performance.

PostgreSQL is smart. When both indexes can answer the query, it chooses the smaller one.

### 4. Cache matters more than you think

First query after PostgreSQL started: 14.374 ms
Second query (immediately after): 0.141 ms

PostgreSQL automatically caches data in memory. Real production performance is the hot cache speed. The first query is always slower.

### 5. Sometimes sequential scan is better

Index helps when you fetch a small percentage of rows.

If you need less than 10% of rows, index scan wins.
If you need more than 30% of rows, sequential scan wins.
PostgreSQL chooses automatically.

### Final numbers

| Query type                 | Time     |
| -------------------------- | -------- |
| Sequential scan with LIMIT | 121 ms   |
| Index scan with LIMIT      | 0.141 ms |

That is 858 times faster.

### The code

GitHub: github.com/Afshan738/postgres-scheduler-benchmark

Run it yourself:

```bash
git clone https://github.com/Afshan738/postgres-scheduler-benchmark
cd postgres-scheduler-benchmark
docker-compose up -d
docker-compose exec postgres psql -U benchmark -d scheduler_benchmark
\i lab/01_baseline.sql
```
