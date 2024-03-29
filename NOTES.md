## Useful Queries:


### Getting columns data types
- See information about all columns for all tables in every schema:
    ```sql
    SELECT * FROM information_schema.columns 
    ```
    The definition for each column is found here: https://www.postgresql.org/docs/8.0/infoschema-columns.html
    
    > Note: the datatype is stored in two different columns:
    > 
    >       | udt_name    | data_type                |
    >       | ----------- | ------------------------ |
    >       | int4        | integer                  |
    >       | text        | text                     |
    >       | timestamptz | timestamp with time zone |
    >       | uuid        | uuid                     |
    >       | int4        | integer                  |
    >       | json        | json                     |

- Or for a specific schema
    ```sql
    SELECT table_name, column_name, udt_name, is_nullable
    FROM information_schema.columns 
    WHERE table_schema = 'public'
    ```

- Or for a specific table:
    ```sql
    SELECT table_name, column_name, udt_name, is_nullable
    FROM information_schema.columns 
    WHERE table_schema = 'public' AND table_name = 'profiles'
    ```



### Getting Functions details


- source 1: https://dataedo.com/kb/query/postgresql/list-user-defined-functions

```sql
select n.nspname as schema_name,
       p.proname as specific_name,
       case p.prokind 
            when 'f' then 'FUNCTION'
            when 'p' then 'PROCEDURE'
            when 'a' then 'AGGREGATE'
            when 'w' then 'WINDOW'
            end as kind,
       l.lanname as language,
    -- uncomment to get definition 
    --    case when l.lanname = 'internal' then p.prosrc
    --         else pg_get_functiondef(p.oid)
    --         end as definition,
       pg_get_function_arguments(p.oid) as arguments,
       t.typname as return_type
from pg_proc p
left join pg_namespace n on p.pronamespace = n.oid
left join pg_language l on p.prolang = l.oid
left join pg_type t on t.oid = p.prorettype 
-- where n.nspname not in ('pg_catalog', 'information_schema')
where n.nspname = 'realtime' -- supabase's realtime schema
order by schema_name,
         specific_name;
```


output:

| schema_name | specific_name                | kind     | language | arguments                                                                    | return_type |
| ----------- | ---------------------------- | -------- | -------- | ---------------------------------------------------------------------------- | ----------- |
| realtime    | apply_rls                    | FUNCTION | plpgsql  | wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)                    | wal_rls     |
| realtime    | build_prepared_statement_sql | FUNCTION | sql      | prepared_statement_name text, entity regclass, columns realtime.wal_column[] | text        |
| realtime    | cast                         | FUNCTION | plpgsql  | val text, type_ regtype                                                      | jsonb       |
| realtime    | check_equality_op            | FUNCTION | plpgsql  | op realtime.equality_op, type_ regtype, val_1 text, val_2 text               | bool        |
| realtime    | is_visible_through_filters   | FUNCTION | sql      | columns realtime.wal_column[], filters realtime.user_defined_filter[]        | bool        |
| realtime    | quote_wal2json               | FUNCTION | sql      | entity regclass                                                              | text        |
| realtime    | subscription_check_filters   | FUNCTION | plpgsql  |                                                                              | trigger     |




- source 2: https://stackoverflow.com/q/1347282/10976714


```sql
SELECT n.nspname as "Schema",
  p.proname as "Name",
  pg_catalog.pg_get_function_result(p.oid) as "Result data type",
  pg_catalog.pg_get_function_arguments(p.oid) as "Argument data types",
 CASE p.prokind
  WHEN 'a' THEN 'agg'
  WHEN 'w' THEN 'window'
  WHEN 'p' THEN 'proc'
  ELSE 'func'
 END as "Type"
FROM pg_catalog.pg_proc p
     LEFT JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
WHERE n.nspname OPERATOR(pg_catalog.~) '^(auth)$' COLLATE pg_catalog.default
ORDER BY 1, 2, 4;
```

The function above was generated by psql (add the `-E` flag or `--echo-hidden` which will show the executed query):

```
[~] psql postgresql://postgres:postgres@localhost:54322/postgres -E
# that will take u to the psql terminal:
postgres=# \df <schema_name>.*
# the query and result should be printed here 
```
output for `auth` table of supabase:

| Schema | Name  | Result data type | Argument data types | Type |
| ------ | ----- | ---------------- | ------------------- | ---- |
| auth   | email | text             |                     | func |
| auth   | role  | text             |                     | func |
| auth   | uid   | uuid             |                     | func |