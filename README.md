# schema-dart
Generate dart type definitions from PostgreSQL database schema (MVP)


## Installation:

The package can be installed as follow:

```
[~] dart pub global activate schema_dart
```


## Usage:

Within a dart/flutter project directory, you can run one of the following examples: 

- generate data classes for public schema (default)
  ```
  schema-dart -c postgresql://postgres:postgres@localhost:54322/postgres -o path/to/output/directory
  ```
- generate for data classes for a "cms" schema 
  ```
  schema-dart -c <connection-string> -o <output-dir> -s cms
  ```

- generate data classes for specific tables from public schema (format sensitive): 
  ```
  schema-dart -c <connection-string> -o <output-dir> -t "users","posts"
  ```
  or
  ```
  schema-dart -c <connection-string> -o <output-dir> --schema=api --tables="profiles","posts"
  ```


> [!NOTE]
> 
> if you receive the following error:
> ```
> Severity.error Server does not support SSL, but it was required.
> ```
> you can pass `--no-ssl` flag such as (not recommended):
> ```
> schema-dart --no-ssl -c  <connection-string> -o <output-dir> 
> ```

## Sample Output:

The following folder: [example/sample_output](https://github.com/osaxma/schema-dart/tree/main/example/sample_output) contains a sample output from Supabase's `auth` schema.
