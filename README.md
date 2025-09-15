 markdown
*PostgreSQL Performance Troubleshooting Guide*

*Connection Pool Issues*
When PostgreSQL connections are maxed out, check these settings:
- max_connections = 200
- shared_buffers = 4GB
- Check for long running queries

*How to troubleshoot slow queries*
1. Check pg_stat_activity for long running processes
2. Review connection pool status  
3. Kill problematic queries if needed
