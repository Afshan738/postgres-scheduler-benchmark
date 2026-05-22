const { Client } = require("pg");

async function runAllBenchmarks() {
  const client = new Client({
    host: "localhost",
    port: 5433,
    database: "scheduler_benchmark",
    user: "benchmark",
    password: "benchmark123",
  });

  await client.connect();

  console.log("\nRunning Complete Benchmark Suite\n");

  // 1. Baseline
  console.log("\n1. Baseline (Seq Scan):");
  const baseline = await client.query(`
        EXPLAIN (ANALYZE, FORMAT JSON) 
        SELECT * FROM urls 
        WHERE last_checked_at < NOW() - INTERVAL '1 hour'
          AND is_active = true
        LIMIT 100
    `);
  console.log(
    `   Time: ${baseline.rows[0]["QUERY PLAN"][0]["Actual Total Time"].toFixed(2)} ms`,
  );

  // 2. Create index
  await client.query(
    "CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_last_checked ON urls(last_checked_at)",
  );

  // 3. After index
  console.log("\n2. With B-tree Index:");
  const withIndex = await client.query(`
        EXPLAIN (ANALYZE, FORMAT JSON) 
        SELECT * FROM urls 
        WHERE last_checked_at < NOW() - INTERVAL '1 hour'
          AND is_active = true
        LIMIT 100
    `);
  console.log(
    `   Time: ${withIndex.rows[0]["QUERY PLAN"][0]["Actual Total Time"].toFixed(2)} ms`,
  );

  // 4. Index sizes
  console.log("\n3. Index Sizes:");
  const sizes = await client.query(`
        SELECT indexname, pg_size_pretty(pg_relation_size(indexname::regclass)) as size
        FROM pg_indexes WHERE tablename = 'urls'
    `);
  sizes.rows.forEach((row) => {
    console.log(`   ${row.indexname}: ${row.size}`);
  });

  // 5. Without LIMIT comparison
  console.log("\n4. Without LIMIT (to show difference):");
  const withoutLimit = await client.query(`
        EXPLAIN (ANALYZE, FORMAT JSON) 
        SELECT * FROM urls 
        WHERE last_checked_at < NOW() - INTERVAL '1 hour'
          AND is_active = true
    `);
  console.log(
    `   Time: ${withoutLimit.rows[0]["QUERY PLAN"][0]["Actual Total Time"].toFixed(2)} ms`,
  );
  console.log("\nBenchmark Complete");
  console.log("\nSummary:");
  console.log(
    `   Seq Scan + LIMIT: ${baseline.rows[0]["QUERY PLAN"][0]["Actual Total Time"].toFixed(2)} ms`,
  );
  console.log(
    `   Index Scan + LIMIT: ${withIndex.rows[0]["QUERY PLAN"][0]["Actual Total Time"].toFixed(2)} ms`,
  );
  console.log(
    `   Improvement: ${(baseline.rows[0]["QUERY PLAN"][0]["Actual Total Time"] / withIndex.rows[0]["QUERY PLAN"][0]["Actual Total Time"]).toFixed(0)}x faster`,
  );

  await client.end();
}

runAllBenchmarks().catch(console.error);
