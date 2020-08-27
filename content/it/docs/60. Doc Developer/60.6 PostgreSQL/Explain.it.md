---
title: "PotgreSQL Explain"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 500
pre: "<b> </b>"
---
```
-- create example tables
DROP TABLE IF EXISTS a CASCADE;

CREATE TABLE a(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    type_id SMALLINT
);

DROP TABLE IF EXISTS b CASCADE;

CREATE TABLE b(
    id SERIAL NOT NULL PRIMARY KEY,
    type_id SMALLINT,
    a_id INT REFERENCES a(id),
    some_data CHAR(10)
);

CREATE INDEX b_a ON b(a_id);

-- populate tables with data
-- use setseed to have repeatable results
SELECT setseed(0.314159);

-- add 1M rows to a
INSERT INTO a(type_id)
SELECT (random()*10+1)::int FROM generate_series(1, 1000000) i;

-- add 2M rows to b
INSERT INTO b(type_id, a_id, some_data)
SELECT (random()*10+1)::int, i%1000000+1,  i::CHAR(10) FROM generate_series(1, 2000000) i;

-- get fresh statistics
ANALYSE a;
ANALYSE b;

-- basic example
EXPLAIN ANALYSE
SELECT a.*
FROM a
WHERE a.id <= 10;

/*
Index Scan using a_pkey on a  (cost=0.42..8.58 rows=9 width=10) (actual time=0.010..0.016 rows=10 loops=1)
  Index Cond: (id <= 10)
Total runtime: 0.051 ms
*/

-- basic join with index
EXPLAIN ANALYSE
SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= 10;

/*
Nested Loop  (cost=0.85..112.04 rows=18 width=10) (actual time=0.028..0.133 rows=20 loops=1)
  ->  Index Scan using a_pkey on a  (cost=0.42..8.58 rows=9 width=10) (actual time=0.009..0.016 rows=10 loops=1)
        Index Cond: (id <= 10)
  ->  Index Only Scan using b_a on b  (cost=0.43..11.48 rows=2 width=4) (actual time=0.007..0.009 rows=2 loops=10)
        Index Cond: (a_id = a.id)
        Heap Fetches: 20
Total runtime: 0.183 ms
*/

-- without the b_a index 

/*
Hash Join  (cost=8.70..40247.88 rows=18 width=10) (actual time=0.055..475.437 rows=20 loops=1)
  Hash Cond: (b.a_id = a.id)
  ->  Seq Scan on b  (cost=0.00..32739.00 rows=2000000 width=4) (actual time=0.015..223.046 rows=2000000 loops=1)
  ->  Hash  (cost=8.58..8.58 rows=9 width=10) (actual time=0.023..0.023 rows=10 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 1kB
        ->  Index Scan using a_pkey on a  (cost=0.42..8.58 rows=9 width=10) (actual time=0.008..0.011 rows=10 loops=1)
              Index Cond: (id <= 10)
Total runtime: 475.498 ms
*/

-- generic estimate
EXPLAIN ANALYSE
SELECT a.*
FROM a
WHERE a.id <= (SELECT 10);

/*
Index Scan using a_pkey on a  (cost=0.43..11298.76 rows=333333 width=10) (actual time=0.030..0.037 rows=10 loops=1)
  Index Cond: (id <= $0)
  InitPlan 1 (returns $0)
    ->  Result  (cost=0.00..0.01 rows=1 width=0) (actual time=0.002..0.002 rows=1 loops=1)
Total runtime: 0.082 ms
*/

-- basic join with generic estimate
EXPLAIN ANALYSE
SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= (SELECT 10);

/*
Hash Join  (cost=15465.42..72192.03 rows=648761 width=10) (actual time=0.248..501.330 rows=20 loops=1)
  Hash Cond: (b.a_id = a.id)
  InitPlan 1 (returns $0)
    ->  Result  (cost=0.00..0.01 rows=1 width=0) (actual time=0.002..0.002 rows=1 loops=1)
  ->  Seq Scan on b  (cost=0.00..32739.00 rows=2000000 width=4) (actual time=0.015..223.640 rows=2000000 loops=1)
  ->  Hash  (cost=11298.75..11298.75 rows=333333 width=10) (actual time=0.042..0.042 rows=10 loops=1)
        Buckets: 65536  Batches: 1  Memory Usage: 1kB
        ->  Index Scan using a_pkey on a  (cost=0.42..11298.75 rows=333333 width=10) (actual time=0.025..0.031 rows=10 loops=1)
              Index Cond: (id <= $0)
Total runtime: 501.394 ms
*/

-- basic example with range hint
EXPLAIN ANALYSE
SELECT a.*
FROM a
WHERE a.id <= (SELECT 10)
AND a.id > 0;

/*
Index Scan using a_pkey on a  (cost=0.43..187.44 rows=5000 width=10) (actual time=0.024..0.030 rows=10 loops=1)
  Index Cond: ((id <= $0) AND (id > 0))
  InitPlan 1 (returns $0)
    ->  Result  (cost=0.00..0.01 rows=1 width=0) (actual time=0.001..0.002 rows=1 loops=1)
Total runtime: 0.073 ms
*/

-- basic join with with range hint
EXPLAIN ANALYSE
SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= (SELECT 10)
AND a.id > 0;

/*
Nested Loop  (cost=0.86..42115.21 rows=9731 width=10) (actual time=0.039..0.141 rows=20 loops=1)
  InitPlan 1 (returns $0)
    ->  Result  (cost=0.00..0.01 rows=1 width=0) (actual time=0.002..0.002 rows=1 loops=1)
  ->  Index Scan using a_pkey on a  (cost=0.42..187.43 rows=5000 width=10) (actual time=0.023..0.027 rows=10 loops=1)
        Index Cond: ((id <= $0) AND (id > 0))
  ->  Index Only Scan using b_a on b  (cost=0.43..8.37 rows=2 width=4) (actual time=0.007..0.009 rows=2 loops=10)
        Index Cond: (a_id = a.id)
        Heap Fetches: 20
Total runtime: 0.203 ms
*/

-- basic join with additional filter
EXPLAIN ANALYSE
SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= 10
AND a.type_id <= 1;

/*
Nested Loop  (cost=0.85..20.10 rows=2 width=10) (actual time=0.022..0.022 rows=0 loops=1)
  ->  Index Scan using a_pkey on a  (cost=0.42..8.61 rows=1 width=10) (actual time=0.021..0.021 rows=0 loops=1)
        Index Cond: (id <= 10)
        Filter: (type_id <= 1)
        Rows Removed by Filter: 10
  ->  Index Only Scan using b_a on b  (cost=0.43..11.48 rows=2 width=4) (never executed)
        Index Cond: (a_id = a.id)
        Heap Fetches: 0
Total runtime: 0.072 ms
*/

-- basic join with additional filter using generic estimate
EXPLAIN ANALYSE
SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= (SELECT 10)
AND a.type_id <= 1;

/*
Hash Join  (cost=12337.09..70395.28 rows=31919 width=10) (actual time=0.054..0.054 rows=0 loops=1)
  Hash Cond: (b.a_id = a.id)
  InitPlan 1 (returns $0)
    ->  Result  (cost=0.00..0.01 rows=1 width=0) (actual time=0.001..0.001 rows=1 loops=1)
  ->  Seq Scan on b  (cost=0.00..32739.00 rows=2000000 width=4) (actual time=0.016..0.016 rows=1 loops=1)
  ->  Hash  (cost=12132.08..12132.08 rows=16400 width=10) (actual time=0.026..0.026 rows=0 loops=1)
        Buckets: 2048  Batches: 1  Memory Usage: 0kB
        ->  Index Scan using a_pkey on a  (cost=0.42..12132.08 rows=16400 width=10) (actual time=0.026..0.026 rows=0 loops=1)
              Index Cond: (id <= $0)
              Filter: (type_id <= 1)
              Rows Removed by Filter: 10
Total runtime: 0.116 ms
*/

-- basic join with additional filter using range hint
EXPLAIN ANALYSE
SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= (SELECT 10)
AND a.type_id <= 1
AND a.id > 0;

/*
Nested Loop  (cost=0.86..2978.79 rows=479 width=10) (actual time=0.034..0.034 rows=0 loops=1)
  InitPlan 1 (returns $0)
    ->  Result  (cost=0.00..0.01 rows=1 width=0) (actual time=0.002..0.003 rows=1 loops=1)
  ->  Index Scan using a_pkey on a  (cost=0.42..199.93 rows=246 width=10) (actual time=0.034..0.034 rows=0 loops=1)
        Index Cond: ((id <= $0) AND (id > 0))
        Filter: (type_id <= 1)
        Rows Removed by Filter: 10
  ->  Index Only Scan using b_a on b  (cost=0.43..11.28 rows=2 width=4) (never executed)
        Index Cond: (a_id = a.id)
        Heap Fetches: 0
Total runtime: 0.092 ms
*/


-- basic join with additional filter on other table
EXPLAIN ANALYSE
SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= 10
AND b.type_id <= 1;

/*
Nested Loop  (cost=0.85..112.00 rows=1 width=10) (actual time=0.064..0.126 rows=2 loops=1)
  ->  Index Scan using a_pkey on a  (cost=0.42..8.58 rows=9 width=10) (actual time=0.010..0.017 rows=10 loops=1)
        Index Cond: (id <= 10)
  ->  Index Scan using b_a on b  (cost=0.43..11.48 rows=1 width=4) (actual time=0.009..0.010 rows=0 loops=10)
        Index Cond: (a_id = a.id)
        Filter: (type_id <= 1)
        Rows Removed by Filter: 2
Total runtime: 0.178 ms
*/

-- basic join with additional filter on other table using generic estimate
EXPLAIN ANALYSE
SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= (SELECT 10)
AND b.type_id <= 1;

/*
Hash Join  (cost=15465.42..54424.59 rows=33000 width=10) (actual time=0.174..324.219 rows=2 loops=1)
  Hash Cond: (b.a_id = a.id)
  InitPlan 1 (returns $0)
    ->  Result  (cost=0.00..0.01 rows=1 width=0) (actual time=0.001..0.002 rows=1 loops=1)
  ->  Seq Scan on b  (cost=0.00..37739.00 rows=101733 width=4) (actual time=0.019..305.319 rows=100332 loops=1)
        Filter: (type_id <= 1)
        Rows Removed by Filter: 1899668
  ->  Hash  (cost=11298.75..11298.75 rows=333333 width=10) (actual time=0.034..0.034 rows=10 loops=1)
        Buckets: 65536  Batches: 1  Memory Usage: 1kB
        ->  Index Scan using a_pkey on a  (cost=0.42..11298.75 rows=333333 width=10) (actual time=0.018..0.026 rows=10 loops=1)
              Index Cond: (id <= $0)
Total runtime: 324.282 ms
*/

-- basic join with additional filter on other table using range hint
EXPLAIN ANALYSE
SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= (SELECT 10)
AND b.type_id <= 1
AND a.id > 0;

/*
Hash Join  (cost=249.94..38884.05 rows=495 width=10) (actual time=0.070..299.836 rows=2 loops=1)
  Hash Cond: (b.a_id = a.id)
  InitPlan 1 (returns $0)
    ->  Result  (cost=0.00..0.01 rows=1 width=0) (actual time=0.001..0.001 rows=1 loops=1)
  ->  Seq Scan on b  (cost=0.00..37739.00 rows=101733 width=4) (actual time=0.020..286.537 rows=100332 loops=1)
        Filter: (type_id <= 1)
        Rows Removed by Filter: 1899668
  ->  Hash  (cost=187.43..187.43 rows=5000 width=10) (actual time=0.035..0.035 rows=10 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 1kB
        ->  Index Scan using a_pkey on a  (cost=0.42..187.43 rows=5000 width=10) (actual time=0.021..0.024 rows=10 loops=1)
              Index Cond: ((id <= $0) AND (id > 0))
Total runtime: 299.906 ms
*/

-- subselect with additional filter on other table using range hint
EXPLAIN ANALYSE
SELECT ir.id, ir.type_id
FROM (
	SELECT a.*, b.id AS b_id, b.type_id AS b_type_id
	FROM a
	INNER JOIN b ON a.id = b.a_id
	WHERE a.id <= (SELECT 10)
	AND a.id > 0
) AS ir
WHERE ir.b_type_id <= 1;

/*
Hash Join  (cost=249.94..38884.05 rows=495 width=10) (actual time=0.069..312.706 rows=2 loops=1)
  Hash Cond: (b.a_id = a.id)
  InitPlan 1 (returns $0)
    ->  Result  (cost=0.00..0.01 rows=1 width=0) (actual time=0.001..0.001 rows=1 loops=1)
  ->  Seq Scan on b  (cost=0.00..37739.00 rows=101733 width=4) (actual time=0.020..299.735 rows=100332 loops=1)
        Filter: (type_id <= 1)
        Rows Removed by Filter: 1899668
  ->  Hash  (cost=187.43..187.43 rows=5000 width=10) (actual time=0.035..0.035 rows=10 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 1kB
        ->  Index Scan using a_pkey on a  (cost=0.42..187.43 rows=5000 width=10) (actual time=0.021..0.031 rows=10 loops=1)
              Index Cond: ((id <= $0) AND (id > 0))
Total runtime: 312.776 ms
*/

-- using CTE to block optimisation
EXPLAIN ANALYSE
WITH interesting_rows AS(
	SELECT a.*, b.type_id AS b_type_id
	FROM a
	INNER JOIN b ON a.id = b.a_id
	WHERE a.id <= (SELECT 10)
	AND a.id >0
)
SELECT id, type_id FROM interesting_rows
WHERE b_type_id = 1;

/*
CTE Scan on interesting_rows  (cost=42115.21..42334.16 rows=49 width=10) (actual time=0.082..0.157 rows=2 loops=1)
  Filter: (b_type_id = 1)
  Rows Removed by Filter: 18
  CTE interesting_rows
    ->  Nested Loop  (cost=0.86..42115.21 rows=9731 width=16) (actual time=0.033..0.127 rows=20 loops=1)
          InitPlan 1 (returns $0)
            ->  Result  (cost=0.00..0.01 rows=1 width=0) (actual time=0.001..0.001 rows=1 loops=1)
          ->  Index Scan using a_pkey on a  (cost=0.42..187.43 rows=5000 width=10) (actual time=0.022..0.028 rows=10 loops=1)
                Index Cond: ((id <= $0) AND (id > 0))
          ->  Index Scan using b_a on b  (cost=0.43..8.37 rows=2 width=10) (actual time=0.006..0.008 rows=2 loops=10)
                Index Cond: (a_id = a.id)
Total runtime: 0.220 ms
*/

-- subselect with additional filter on other table with offset 0
EXPLAIN ANALYSE
SELECT id, type_id
FROM (
	SELECT a.*, b.type_id AS b_type_id
	FROM a
	INNER JOIN b ON a.id = b.a_id
	WHERE a.id <= (SELECT 10)
	AND a.id > 0
	OFFSET 0
) AS ir
WHERE ir.b_type_id <= 1;

/*
Subquery Scan on ir  (cost=0.86..42236.85 rows=495 width=10) (actual time=0.119..0.191 rows=2 loops=1)
  Filter: (ir.b_type_id <= 1)
  Rows Removed by Filter: 18
  ->  Nested Loop  (cost=0.86..42115.21 rows=9731 width=12) (actual time=0.074..0.179 rows=20 loops=1)
        InitPlan 1 (returns $0)
          ->  Result  (cost=0.00..0.01 rows=1 width=0) (actual time=0.001..0.001 rows=1 loops=1)
        ->  Index Scan using a_pkey on a  (cost=0.42..187.43 rows=5000 width=10) (actual time=0.058..0.067 rows=10 loops=1)
              Index Cond: ((id <= $0) AND (id > 0))
        ->  Index Scan using b_a on b  (cost=0.43..8.37 rows=2 width=6) (actual time=0.007..0.009 rows=2 loops=10)
              Index Cond: (a_id = a.id)
Total runtime: 0.257 ms
*/

-- just create an index
CREATE INDEX b_type_a ON b(a_id, type_id);

EXPLAIN ANALYSE
SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= (SELECT 10)
AND a.id > 0
AND b.type_id <= 1;

/*
Nested Loop  (cost=0.86..32947.44 rows=495 width=10) (actual time=0.064..0.111 rows=2 loops=1)
  InitPlan 1 (returns $0)
    ->  Result  (cost=0.00..0.01 rows=1 width=0) (actual time=0.001..0.001 rows=1 loops=1)
  ->  Index Scan using a_pkey on a  (cost=0.42..187.43 rows=5000 width=10) (actual time=0.024..0.035 rows=10 loops=1)
        Index Cond: ((id <= $0) AND (id > 0))
  ->  Index Only Scan using b_type_a on b  (cost=0.43..6.54 rows=1 width=4) (actual time=0.007..0.007 rows=0 loops=10)
        Index Cond: ((a_id = a.id) AND (type_id <= 1))
        Heap Fetches: 2
Total runtime: 0.173 ms
*/

-- join order
DROP TABLE IF EXISTS c CASCADE;

CREATE TABLE c(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    b_id BIGINT REFERENCES b(id)
);

DROP TABLE IF EXISTS type_data CASCADE;

CREATE TABLE type_data(
    id SMALLINT,
    some_data CHAR(100)
);

INSERT INTO c(b_id)
SELECT (i+123456)%200000+1 FROM generate_series(1, 2000000) i;

INSERT INTO type_data(id, some_data)
SELECT i, 'Data ' || i FROM generate_series(1,11) i;

ANALYZE c;
ANALYSE type_data;

EXPLAIN ANALYZE
SELECT a.id
FROM c
INNER JOIN b ON b.id = c.b_id
INNER JOIN type_data b_data ON b_data.id = b.type_id
INNER JOIN a ON a.id = b.a_id
INNER JOIN type_data a_data ON a_data.id = a.type_id
WHERE a.id < 10;
/*
Nested Loop  (cost=112.13..38431.53 rows=18 width=8) (actual time=40.456..451.546 rows=80 loops=1)
  Join Filter: (a.type_id = a_data.id)
  Rows Removed by Join Filter: 800
  ->  Nested Loop  (cost=112.13..38427.42 rows=18 width=10) (actual time=40.447..451.352 rows=80 loops=1)
        Join Filter: (b.type_id = b_data.id)
        Rows Removed by Join Filter: 800
        ->  Hash Join  (cost=112.13..38423.31 rows=18 width=12) (actual time=40.434..451.136 rows=80 loops=1)
              Hash Cond: (c.b_id = b.id)
              ->  Seq Scan on c  (cost=0.00..30811.00 rows=2000000 width=8) (actual time=0.017..214.859 rows=2000000 loops=1)
              ->  Hash  (cost=111.91..111.91 rows=18 width=16) (actual time=0.141..0.141 rows=18 loops=1)
                    Buckets: 1024  Batches: 1  Memory Usage: 1kB
                    ->  Nested Loop  (cost=0.85..111.91 rows=18 width=16) (actual time=0.025..0.126 rows=18 loops=1)
                          ->  Index Scan using a_pkey on a  (cost=0.42..8.58 rows=9 width=10) (actual time=0.009..0.017 rows=9 loops=1)
                                Index Cond: (id < 10)
                          ->  Index Scan using b_a on b  (cost=0.43..11.46 rows=2 width=10) (actual time=0.007..0.009 rows=2 loops=9)
                                Index Cond: (a_id = a.id)
        ->  Materialize  (cost=0.00..1.17 rows=11 width=2) (actual time=0.000..0.001 rows=11 loops=80)
              ->  Seq Scan on type_data b_data  (cost=0.00..1.11 rows=11 width=2) (actual time=0.004..0.005 rows=11 loops=1)
  ->  Materialize  (cost=0.00..1.17 rows=11 width=2) (actual time=0.000..0.001 rows=11 loops=80)
        ->  Seq Scan on type_data a_data  (cost=0.00..1.11 rows=11 width=2) (actual time=0.001..0.003 rows=11 loops=1)
Total runtime: 451.657 ms
*/

EXPLAIN ANALYZE
SELECT a.id
FROM a
INNER JOIN type_data a_data ON a_data.id = a.type_id
INNER JOIN b ON b.a_id = a.id
INNER JOIN type_data b_data ON b_data.id = b.type_id
INNER JOIN c ON c.b_id = b.id
WHERE a.id < 10;
/*
Nested Loop  (cost=112.13..38431.53 rows=18 width=8) (actual time=38.381..454.297 rows=80 loops=1)
  Join Filter: (b.type_id = b_data.id)
  Rows Removed by Join Filter: 800
  ->  Nested Loop  (cost=112.13..38427.42 rows=18 width=10) (actual time=38.372..454.088 rows=80 loops=1)
        Join Filter: (a.type_id = a_data.id)
        Rows Removed by Join Filter: 800
        ->  Hash Join  (cost=112.13..38423.31 rows=18 width=12) (actual time=38.359..453.863 rows=80 loops=1)
              Hash Cond: (c.b_id = b.id)
              ->  Seq Scan on c  (cost=0.00..30811.00 rows=2000000 width=8) (actual time=0.017..215.447 rows=2000000 loops=1)
              ->  Hash  (cost=111.91..111.91 rows=18 width=16) (actual time=0.139..0.139 rows=18 loops=1)
                    Buckets: 1024  Batches: 1  Memory Usage: 1kB
                    ->  Nested Loop  (cost=0.85..111.91 rows=18 width=16) (actual time=0.024..0.121 rows=18 loops=1)
                          ->  Index Scan using a_pkey on a  (cost=0.42..8.58 rows=9 width=10) (actual time=0.009..0.015 rows=9 loops=1)
                                Index Cond: (id < 10)
                          ->  Index Scan using b_a on b  (cost=0.43..11.46 rows=2 width=10) (actual time=0.007..0.009 rows=2 loops=9)
                                Index Cond: (a_id = a.id)
        ->  Materialize  (cost=0.00..1.17 rows=11 width=2) (actual time=0.000..0.001 rows=11 loops=80)
              ->  Seq Scan on type_data a_data  (cost=0.00..1.11 rows=11 width=2) (actual time=0.004..0.004 rows=11 loops=1)
  ->  Materialize  (cost=0.00..1.17 rows=11 width=2) (actual time=0.000..0.001 rows=11 loops=80)
        ->  Seq Scan on type_data b_data  (cost=0.00..1.11 rows=11 width=2) (actual time=0.001..0.003 rows=11 loops=1)
Total runtime: 454.408 ms
*/

SET join_collapse_limit = 1;

EXPLAIN ANALYZE
SELECT a.id
FROM c
INNER JOIN b ON b.id = c.b_id
INNER JOIN type_data b_data ON b_data.id = b.type_id
INNER JOIN a ON a.id = b.a_id
INNER JOIN type_data a_data ON a_data.id = a.type_id
WHERE a.id < 10;
/*
Hash Join  (cost=57750.19..168561.62 rows=18 width=8) (actual time=1102.351..5176.139 rows=80 loops=1)
  Hash Cond: (a.type_id = a_data.id)
  ->  Hash Join  (cost=57748.94..168560.12 rows=18 width=10) (actual time=1102.319..5176.071 rows=80 loops=1)
        Hash Cond: (b.a_id = a.id)
        ->  Hash Join  (cost=57740.25..161051.25 rows=2000000 width=4) (actual time=934.911..4951.964 rows=2000000 loops=1)
              Hash Cond: (b.type_id = b_data.id)
              ->  Hash Join  (cost=57739.00..133550.00 rows=2000000 width=6) (actual time=934.889..4331.782 rows=2000000 loops=1)
                    Hash Cond: (c.b_id = b.id)
                    ->  Seq Scan on c  (cost=0.00..30811.00 rows=2000000 width=8) (actual time=0.014..270.451 rows=2000000 loops=1)
                    ->  Hash  (cost=32739.00..32739.00 rows=2000000 width=10) (actual time=934.371..934.371 rows=2000000 loops=1)
                          Buckets: 262144  Batches: 1  Memory Usage: 85938kB
                          ->  Seq Scan on b  (cost=0.00..32739.00 rows=2000000 width=10) (actual time=0.018..389.222 rows=2000000 loops=1)
              ->  Hash  (cost=1.11..1.11 rows=11 width=2) (actual time=0.012..0.012 rows=11 loops=1)
                    Buckets: 1024  Batches: 1  Memory Usage: 1kB
                    ->  Seq Scan on type_data b_data  (cost=0.00..1.11 rows=11 width=2) (actual time=0.003..0.007 rows=11 loops=1)
        ->  Hash  (cost=8.58..8.58 rows=9 width=10) (actual time=0.020..0.020 rows=9 loops=1)
              Buckets: 1024  Batches: 1  Memory Usage: 1kB
              ->  Index Scan using a_pkey on a  (cost=0.42..8.58 rows=9 width=10) (actual time=0.009..0.013 rows=9 loops=1)
                    Index Cond: (id < 10)
  ->  Hash  (cost=1.11..1.11 rows=11 width=2) (actual time=0.022..0.022 rows=11 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 1kB
        ->  Seq Scan on type_data a_data  (cost=0.00..1.11 rows=11 width=2) (actual time=0.009..0.014 rows=11 loops=1)
Total runtime: 5183.119 ms
*/

EXPLAIN ANALYZE
SELECT a.id
FROM a
INNER JOIN type_data a_data ON a_data.id = a.type_id
INNER JOIN b ON b.a_id = a.id
INNER JOIN type_data b_data ON b_data.id = b.type_id
INNER JOIN c ON c.b_id = b.id
WHERE a.id < 10;
/*
Hash Join  (cost=115.00..38426.18 rows=18 width=8) (actual time=36.031..447.317 rows=80 loops=1)
  Hash Cond: (c.b_id = b.id)
  ->  Seq Scan on c  (cost=0.00..30811.00 rows=2000000 width=8) (actual time=0.017..210.918 rows=2000000 loops=1)
  ->  Hash  (cost=114.77..114.77 rows=18 width=12) (actual time=0.212..0.212 rows=18 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 1kB
        ->  Hash Join  (cost=3.35..114.77 rows=18 width=12) (actual time=0.075..0.197 rows=18 loops=1)
              Hash Cond: (b.type_id = b_data.id)
              ->  Nested Loop  (cost=2.10..113.28 rows=18 width=14) (actual time=0.048..0.152 rows=18 loops=1)
                    ->  Hash Join  (cost=1.67..9.95 rows=9 width=8) (actual time=0.032..0.046 rows=9 loops=1)
                          Hash Cond: (a.type_id = a_data.id)
                          ->  Index Scan using a_pkey on a  (cost=0.42..8.58 rows=9 width=10) (actual time=0.009..0.016 rows=9 loops=1)
                                Index Cond: (id < 10)
                          ->  Hash  (cost=1.11..1.11 rows=11 width=2) (actual time=0.012..0.012 rows=11 loops=1)
                                Buckets: 1024  Batches: 1  Memory Usage: 1kB
                                ->  Seq Scan on type_data a_data  (cost=0.00..1.11 rows=11 width=2) (actual time=0.003..0.009 rows=11 loops=1)
                    ->  Index Scan using b_a on b  (cost=0.43..11.46 rows=2 width=10) (actual time=0.007..0.009 rows=2 loops=9)
                          Index Cond: (a_id = a.id)
              ->  Hash  (cost=1.11..1.11 rows=11 width=2) (actual time=0.018..0.018 rows=11 loops=1)
                    Buckets: 1024  Batches: 1  Memory Usage: 1kB
                    ->  Seq Scan on type_data b_data  (cost=0.00..1.11 rows=11 width=2) (actual time=0.005..0.010 rows=11 loops=1)
Total runtime: 447.425 ms

*/
```



INFO: bitbucket.com/marin/pgdayit2018

EXPLAIN ANALYSE SELECT * FROM a

select * from pg_stats  where tablename='a'

Slide Pagina 19
una tabella ha solitamente di default 100 bucket dove vengono spartiti i record, ci sono un milione di record nella tabella a
per vedere il valore dei bucket dell’istogramma:

SELECT histogram_bounds from pg_Stats where tablename='a'



quindi in questo esempio ogni bucket contiene circa 10000 record

Si può modificare questo parametro che di default è 100 modificandolo con → ALTER TABLE SET STATISTICS



se facciamo questo banale esempio con la join

SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= 10;

viene fatta la JOIN dopo ogni bucket, quindi dopo 1000 record in questo esempio, più record ho in un bucket e ovviamente più iil costo aumenta

ESEMPI:

SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= 10;

ci impiega → 1.183 ms

La stessa Select con la modifica solamente del dato 10 a SELECT 20

SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= (SELECT 10);

ci impiega → 501.394 ms


e se invece ci aggiungo una condizione compreso tra (es: “A < b”)
SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= (SELECT 10)
AND a.id >0;

ci impiega → 0.203 ms


diminuisce completamente anche se modifico la condizione AND (al posto di a.id >0 faggiungo la condizione su un’altra colonna a.type_id<=1)

SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= (SELECT 10)
AND a.type_id <=1;

ci impiega → 0.116 ms

La costante non è un problema

--------------------------------------------------










Vediamo adesso: WITH, OFFSET 0  e INDEX

SELECT ir.id, ir.type_id
FROM (
	SELECT a.*, b.id AS b_id, b.type_id AS b_type_id
	FROM a
	INNER JOIN b ON a.id = b.a_id
	WHERE a.id <= (SELECT 10)
	AND a.id > 0
) AS ir
WHERE ir.b_type_id <= 1;

Nella query sopra il tempo è elevato → 312.776 ms

dobbiamo utilzzare WITH

WITH interesting_rows AS(
	SELECT a.*, b.type_id AS b_type_id
	FROM a
	INNER JOIN b ON a.id = b.a_id
	WHERE a.id <= (SELECT 10)
	AND a.id >0
)
SELECT id, type_id FROM interesting_rows
WHERE b_type_id = 1;

Nella query sopra il tempo di esecuzione è migliorato molto → 0.220 ms


Un altro metodo per migliorare l’esecuzione è utilizzare OFFSET 0 

SELECT id, type_id
FROM (
	SELECT a.*, b.type_id AS b_type_id
	FROM a
	INNER JOIN b ON a.id = b.a_id
	WHERE a.id <= (SELECT 10)
	AND a.id > 0
	OFFSET 0
) AS ir
WHERE ir.b_type_id <= 1;

Nella query sopra il tempo di esecuzione è → 0.257 ms



Un altro metodo per migliorare l’esecuzione è utilizzare INDEX

CREATE INDEX b_type_a ON b(a_id, type_id);

EXPLAIN ANALYSE
SELECT a.*
FROM a
INNER JOIN b ON a.id = b.a_id
WHERE a.id <= (SELECT 10)
AND a.id > 0
AND b.type_id <= 1;

Nella query sopra il tempo di esecuzione è → 0.173 ms

precedentemente l’INDEX --> CREATE INDEX b_type_a ON b(a_id); aggiungendo un’altra colonna ho diminuito il tempo
