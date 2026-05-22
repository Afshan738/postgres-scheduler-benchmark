# PostgreSQL Scheduler Benchmark

Production-grade benchmark comparing PostgreSQL scheduler patterns. From 121ms to 0.141ms using indexes and LIMIT. 500k URL simulation with real production patterns.



## Quick Start

```bash
git clone https://github.com/Afshan738/postgres-scheduler-benchmark
cd postgres-scheduler-benchmark
docker-compose up -d
docker-compose exec postgres psql -U benchmark -d scheduler_benchmark
\i lab/01_baseline.sql
```

## What You Will Learn

Why sequential scans are slow on large tables

How indexes make queries faster

Why LIMIT is important for scheduler queries

How partial indexes save disk space

How PostgreSQL caching affects performance

When not to use an index

## Lab Files

### File What it shows

lab/01_baseline.sql Run query without index

lab/02_create_index.sql Add B-tree index

lab/03_after_index.sql See the improvement

lab/04_partial_index.sql Create smaller index

lab/05_size_comparison.sql Compare index sizes

lab/06_drop_index.sql Remove index to test

lab/07_disable_indexscan.sql Force different scan method

lab/08_final_query.sql Production ready query

## Three Ways to Use This Lab

### Option 1: Step by Step (Recommended)

Follow the instructions in docs/instructions.md. Run each query manually and observe the results.

```bash
docker-compose exec postgres psql -U benchmark -d scheduler_benchmark
\i lab/01_baseline.sql
\i lab/02_create_index.sql
\i lab/03_after_index.sql
\i lab/04_partial_index.sql
\i lab/05_size_comparison.sql
\i lab/06_drop_index.sql
\i lab/07_disable_indexscan.sql
\i lab/08_final_query.sql
```

### Option 2: Automated Benchmark

```bash
npm install
npm run benchmark
```

### Option 3: Read the Insights

Check docs/insights.md for a summary of what I learned.

## Results

Query Type Time
Sequential scan with LIMIT 121 ms
Index scan with LIMIT 0.141 ms
858x faster

## Requirements

Docker installed

Node.js installed (optional, only for automated benchmark)

## Clean Up

```bash
docker-compose down -v
```

## Connect

GitHub: https://github.com/Afshan738

LinkedIn: https://www.linkedin.com/in/afshan-qasim-998917300/
