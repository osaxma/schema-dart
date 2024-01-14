import 'package:schema_dart/src/table_reader.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

const _connectionString = 'postgresql://some_user-name:pass123word456@db.fwoqzpwqgJgrqak.supabase.co:54322/postgres';
const _dbName = 'postgres';
const _host = 'db.fwoqzpwqgJgrqak.supabase.co';
const _port = 54322;
const _username = 'some_user-name';
const _password = 'pass123word456';
// the '@' symbol should be replaced with `%40`
const _invalidConnectionString = 'postgresql://postgres:pass@word@localhost:54322/postgres';

void main() {
  group('table_reader.dart', () {
    group('TableReader.fromConnectionString', () {
      test('- correct string ', () {
        final reader = TablesReader.fromConnectionString(_connectionString);

        expect(reader.databaseName, _dbName);
        expect(reader.host, _host);
        expect(reader.port, _port);
        expect(reader.username, _username);
        expect(reader.password, _password);
      });

      test('- invalid string (password contains @ symbol)', () {
        expect(() => TablesReader.fromConnectionString(_invalidConnectionString), throwsA(isA<FormatException>()));
      });
    });
  });
}
