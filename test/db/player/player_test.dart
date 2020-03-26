import 'package:libpg/libpg.dart';

import 'package:test/test.dart';
import 'package:universal_server/db/user.dart';

void main() {
  final db = PGPool(settings);
  final userDb = UserDBImpl();

  setUp(() async {
    // TODO create database
  });

  tearDown(() async {
    // TODO drop database
    await db.close();
  });

  group('db.player', () {
    test('insert', () async {
      final user = await userDb.insert(db, 'tejainece', 'tejainece@gmail.com', 'testing');
      expect(user.id, isNotNull);
      expect(user.username, 'tejainece');
      expect(user.email, 'tejainece@gmail.com');
      expect(user.password, isNotNull); // TODO test hash
      expect(user.joined, isNotNull);
      expect(user.emailVerified, false);
    });
  });
}