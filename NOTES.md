## Useful Queries:

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


