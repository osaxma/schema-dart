import 'dart:convert';

import 'package:postgres/postgres.dart';

import 'package:test/test.dart';

import '../data/generate_data.dart';
import '../docker.dart';
import '../data/serialization_output.g.dart';

// TODO: streamline the process of running this test.
//      The test here relies on generated class file where we test its toJson and fromJson

void main() {
  group('Serialization and Deserializations Group', () {
    setUpAll(() {
      expect(
        bool.fromEnvironment('from_script'),
        true,
        reason: "This test must be executed using `test.sh` script to ensure all generated files are up to date",
      );
    });

    withPostgresServer('Serialize/Deserialize tests', (server) {
      late final Connection connection;
      setUpAll(() async {
        connection = await server.newConnection(
          sslMode: SslMode.disable,
        );

        await generateTableAndRowsForSerializationTest(connection);
      });

      test('deserialize', () async {
        final result1 = await connection.execute('SELECT * FROM public.$serializationTestTableName');

        expect(result1.length, 3);

        for (var row in result1) {
          final asJson = jsonEncode(
            row.toColumnMap(),
            toEncodable: (nonEncodable) {
              if (nonEncodable is DateTime) {
                return nonEncodable.toIso8601String();
              }
              return nonEncodable;
            },
          );
          // deserialize from json -> serizalize to json -> deserialize again
          final clazz = SerializationOutput.fromJson(asJson);
          final clazz2 = SerializationOutput.fromJson(clazz.toJson());
          expect(clazz.toJson(), clazz2.toJson());
        }
      });
    });
  });
}
