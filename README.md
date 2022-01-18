# schema-dart
Generate dart type definitions from PostgreSQL database schema (WIP)


## Installation:

Until the package is published to `pub.dev`, it can be installed as follow:

```
[~] dart pub global activate --source git https://github.com/osaxma/schema-dart.git
```


## Usage:

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
