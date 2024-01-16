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

All usage information:
```
Generate Data Classes for PostgreSQL schema
  
Examples: 

  # generate data classes for public schema (default)
  schema-dart -c postgresql://postgres:postgres@localhost:54322/postgres -o path/to/output/directory

  # generate for data classes for a "cms" schema 
  schema-dart -c <connection-string> -o <output-dir> -s cms

  # generate data classes for specific tables from public schema (format sensitive): 
  schema-dart -c <connection-string> -o <output-dir> -t "users","posts"
  # or
  schema-dart -c <connection-string> -o <output-dir> --schema=api --tables="profiles","posts"
  

Usage: schema-dart <command> [arguments]

Global options:
-h, --help                 Print this usage information.
-c, --connection-string    PostgreSQL connection string in the following format:
                           postgresql://<username>:<password>@<host>:<port>/<database-name>
-o, --output-dir           The output directory for the generated dart files
-s, --schema               specify the schema
                           (defaults to "public")
-t, --tables=<String>      provide a specific list of tables to generate data classes for.
                           (defaults to all tables)
    --no-ssl               Disable SSL for postgres connection (not recommended)
-n, --nullable-fields      When provided, all fields in generated class will be nullable (useful for partial table queries and for local table construction update/insert)
-i, --nullable-ids         When provided, columns that are identity & have identity generations will be generated as nullable fields
-d, --nullable-defaults    When provided, identity columns that have default values will be generated as nullable fields
-u, --use-utc              When provided, `.toUtc` will be added to all generated DateTime fields
-v, --verbose              Enable verbose logging.
    --version              Print the current version.

Available commands:
  help   Display help information for schema-dart.

Run "schema-dart help <command>" for more information about a command.
```

## Sample Output:

The following folder: [example/sample_output](https://github.com/osaxma/schema-dart/tree/main/example/sample_output) contains a sample output from Supabase's `auth` schema.
