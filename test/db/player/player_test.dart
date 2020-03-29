import 'package:libpg/libpg.dart';

import 'package:test/test.dart';
import 'package:universal_server/db/user.dart';

void main() {
  final db = PGPool(ConnSettings.parse(
      'postgres://doe_universal:dawn@localhost:5432/doe_universal?sslmode=disable'));
  final userDb = UserDBImpl();

  setUp(() async {
    // TODO create database

    await db.execute('truncate player');
  });

  tearDown(() async {
    // TODO drop database
    await db.close();
  });

  group('db.player', () {
    test('insert', () async {
      var user = await userDb.insert(
          db, 'tejainece', 'tejainece@gmail.com', 'testing');
      expect(user.id, isNotNull);
      expect(user.username, 'tejainece');
      expect(user.email, 'tejainece@gmail.com');
      expect(user.password, 'testing');
      expect(user.joined, isNotNull);
      expect(user.emailVerified, false);

      await userDb.verifyEmail(db, user.id);

      user = await userDb.fetchById(db, user.id);
      expect(user.id, isNotNull);
      expect(user.username, 'tejainece');
      expect(user.email, 'tejainece@gmail.com');
      expect(user.password, 'testing');
      expect(user.joined, isNotNull);
      expect(user.emailVerified, true);
    });
  });
}
