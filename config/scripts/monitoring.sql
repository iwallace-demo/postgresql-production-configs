 sql
-- PostgreSQL Performance Monitoring Queries
-- Used by incident response team for quick diagnostics

-- 1. CONNECTION POOL STATUS
SELECT 
    state,
    count(*) as connections,
    max(now() - state_change) as max_age
FROM pg_stat_activity 
WHERE state IS NOT NULL
GROUP BY state
ORDER BY connections DESC;

-- 2. SLOW RUNNING QUERIES
SELECT 
    pid,
    now() - pg_stat_activity.query_start AS duration,
    query,
    state,
    wait_event_type,
    wait_event
FROM pg_stat_activity 
WHERE (now() - pg_stat_activity.query_start) > interval '2 minutes'
  AND state != 'idle'
ORDER BY duration DESC;

-- 3. DATABASE SIZE AND GROWTH
SELECT 
    datname,
    pg_size_pretty(pg_database_size(datname)) as size,
    numbackends as active_connections
FROM pg_stat_database 
WHERE datname NOT IN ('template0', 'template1', 'postgres')
ORDER BY pg_database_size(datname) DESC;

-- 4. CONNECTION POOL TROUBLESHOOTING
SELECT 
    application_name,
    client_addr,
    state,
    query_start,
    state_change,
    query
FROM pg_stat_activity 
WHERE state != 'idle'
ORDER BY query_start;
