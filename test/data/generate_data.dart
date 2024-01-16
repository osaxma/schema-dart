import 'dart:io';

import 'package:postgres/postgres.dart';
import 'package:schema_dart/src/schema_converter.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

import '../docker.dart';

final serializationTestTableName = 'serialization_output';
// final _outputFile = '$_tableName.g.dart';

void main() {

  // this is not actually a test but we use a test library that provides `withPostgresServer`
  withPostgresServer('Serialize/Deserialize tests', (server) {
    late final Connection connection;
    // late final String outputFilePath;
    setUpAll(() async {
      connection = await server.newConnection(
        sslMode: SslMode.disable,
      );
      await generateTableAndRowsForSerializationTest(connection);
      final parent = Directory.current.path;
      final targetPath = p.join(parent, 'test/data');
      // sanity check so we don't create files in unknown location
      expect(p.isWithin(parent, '$targetPath/schema-dart/test/data'), true);
      await SchemaConverter(
        connectionString: await server.connectionString,
        outputDirectory: Directory(targetPath),
        schemaName: 'public',
      ).convert();

      // outputFilePath = p.join(targetPath, _outputFile);
    });
  });
}

// shamelessly copied from `postgres-dart` decoding tests
// https://github.com/isoos/postgresql-dart/blob/27d0064a992946060b9a19346df85a118deea774/test/decode_test.dart
Future<void> generateTableAndRowsForSerializationTest(Connection connection) async {
  // TODO: re-add `p point`
  await connection.execute('''
        CREATE TABLE public.$serializationTestTableName (
          i int, s serial, bi bigint, bs bigserial, bl boolean, si smallint, 
          t text, f real, d double precision, dt date, ts timestamp, tsz timestamptz, n numeric, j jsonb, ba bytea,
          u uuid, v varchar, jj json, ia _int4, bia _int8, ta _text, da _float8, ja _jsonb, va varchar(20)[],
          boola _bool
        )
    ''');

  // TODO: re-add point
  await connection.execute(
      'INSERT INTO public.$serializationTestTableName (i, bi, bl, si, t, f, d, dt, ts, tsz, n, j, ba, u, v, ' /*  p, */
      'jj, ia, bia, ta, da, ja, va, boola) '
      'VALUES (-2147483648, -9223372036854775808, TRUE, -32768, '
      "'string', 10.0, 10.0, '1983-11-06', "
      "'1983-11-06 06:00:00.000000', '1983-11-06 06:00:00.000000', "
      "'-1234567890.0987654321', "
      "'{\"key\":\"value\"}', E'\\\\000', '00000000-0000-0000-0000-000000000000', "
      "'abcdef', " /* '(0.01, 12.34)', */
      "'{\"key\": \"value\"}', '{}', '{}', '{}', '{}', '{}', "
      "'{\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"}', "
      "'{true, false, false}'"
      ')');

  // TODO: re-add point
  await connection.execute(
      'INSERT INTO public.$serializationTestTableName (i, bi, bl, si, t, f, d, dt, ts, tsz, n, j, ba, u, v, ' /*  p, */
      'jj, ia, bia, ta, da, ja, va, boola) '
      'VALUES (2147483647, 9223372036854775807, FALSE, 32767, '
      "'a significantly longer string to the point where i doubt this actually matters', "
      "10.25, 10.125, '2183-11-06', '2183-11-06 00:00:00.111111', "
      "'2183-11-06 00:00:00.999999', "
      "'1000000000000000000000000000.0000000000000000000000000001', "
      "'[{\"key\":1}]', E'\\\\377', 'FFFFFFFF-ffff-ffff-ffff-ffffffffffff', "
      "'01234', " /* '(0.2, 100)', */
      "'{}', '{-123, 999}', '{-123, 999}', '{\"a\", \"lorem ipsum\", \"\"}', "
      "'{1, 2, 4.5, 1234.5}', '{1, \"\\\"test\\\"\", \"{\\\"a\\\": \\\"b\\\"}\"}', "
      "'{\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"}', "
      "'{false, false, true}' "
      ')');

  // TODO: re-add point
  await connection.execute(
      'INSERT INTO public.$serializationTestTableName (i, bi, bl, si, t, f, d, dt, ts, tsz, n, j, ba, u, v, ' /* p, */
      'jj, ia, bia, ta, da, ja, va, boola) '
      'VALUES (null, null, null, null, null, null, null, null, null, null, null, null, null, null, '
      'null, ' /* null, */
      'null, null, null, null, null, null, null, null)');
}
