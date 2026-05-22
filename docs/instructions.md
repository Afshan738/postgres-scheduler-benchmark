# PostgreSQL Query Optimization Lab - Instructions

## What you need

- Docker installed
- Node.js installed (optional, for automated benchmark)
- 10-15 minutes

## Step 1: Start the database

Open terminal and run:

```bash
git clone https://github.com/Afshan738/postgres-scheduler-benchmark.git
cd postgres-scheduler-benchmark
docker-compose up -d
```

Wait 10 seconds for PostgreSQL to start. The setup script will automatically create a table and insert 500,000 rows.

## Step 2: Connect to database

bash
docker-compose exec postgres psql -U benchmark -d scheduler_benchmark
You should see: scheduler_benchmark=#

## Step 3: Run the lab step by step

Inside the psql prompt, run these commands one by one:

sql
\i lab/01_baseline.sql
This shows the query without any index. Note the execution time.

sql
\i lab/02_create_index.sql
Creates a B-tree index on the date column.

sql
\i lab/03_after_index.sql
Run the same query again. See how much faster it is.

sql
\i lab/04_partial_index.sql
Creates a partial index for active URLs only.

sql
\i lab/05_size_comparison.sql
Compare the size of regular index vs partial index.

sql
\i lab/06_drop_index.sql
Drop the index to see what happens.

sql
\i lab/07_disable_indexscan.sql
Force PostgreSQL to use a different scan method.

sql
\i lab/08_final_query.sql
Run the final production-ready query.

## Step 4: Run automated benchmark (optional)

In a new terminal, run:

```bash
npm install
npm run benchmark
This runs all queries automatically and shows a summary.
```

## Step 5: Clean up

When done:

```bash
docker-compose down -v
```

## What you will learn

Lab Concept
01 Sequential scan reads all rows

02 How to create an index

03 Index scan is much faster

04 Partial indexes for filtered queries

05 Partial indexes are smaller

06 Prove the index was helping

07 See what happens without index scan

08 Production ready query

## Troubleshooting

If you see "relation urls does not exist":

Wait a few more seconds for setup to complete

Run docker-compose logs to see if any errors

If port 5433 is already in use:

Change port in docker-compose.yml to 5434

Update port in benchmarks/run.js to match

## Connect

GitHub: https://github.com/Afshan738/postgres-scheduler-benchmark

LinkedIn: https://www.linkedin.com/in/afshan-qasim-998917300/
