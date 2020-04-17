import 'package:libpg/libpg.dart';

import 'package:universal_server/model/user.dart';

abstract class UserDB {
  Future<User> fetchById(Querier db, int id);

  Future<User> fetchByUsername(Querier db, String username);

  Future<User> fetchByEmail(Querier db, String email);

  Future<User> fetchByEmailOrUsername(Querier db, String emailOrUsername);

  Future<User> insert(
      Querier db, String username, String email, String password);

  Future<void> verifyEmail(Querier db, int id);
}

class UserDBImpl implements UserDB {
  const UserDBImpl();

  @override
  Future<User> fetchById(Querier db, int id) async {
    final row = await db
        .query(substitute('select * from player where id = @{id}',
            values: {'id': id}))
        .one();
    return User.fromMap(row.asMap());
  }

  @override
  Future<User> fetchByUsername(Querier db, String username) async {
    final row = await db
        .query(substitute('select * from player where username = @{username}',
            values: {'username': username}))
        .one();
    return User.fromMap(row.asMap());
  }

  @override
  Future<User> fetchByEmail(Querier db, String email) async {
    final row = await db
        .query(substitute('select * from player where email = @{email}',
            values: {'email': email}))
        .one();
    return User.fromMap(row.asMap());
  }

  @override
  Future<User> fetchByEmailOrUsername(
      Querier db, String emailOrUsername) async {
    final row = await db
        .query(substitute(
            'select * from player where email = @{emailOrUsername} OR username = @{emailOrUsername}',
            values: {'emailOrUsername': emailOrUsername}))
        .one();
    return User.fromMap(row.asMap());
  }

  @override
  Future<User> insert(
      Querier db, String username, String email, String password) async {
    final row = await db
        .query(substitute(
            'insert into player (username, email, password) values (@{username}, @{email}, @{password}) RETURNING id',
            values: {
              'username': username,
              'email': email,
              'password': password,
            }))
        .one();
    if (row == null) {
      // TODO better error
      throw Exception();
    }
    return fetchById(db, row['id']);
  }

  @override
  Future<void> verifyEmail(Querier db, int id) async {
    final tag = await db.execute(substitute(
        'update player set emailVerified = true where id = @{id}',
        values: {'id': id}));
    if (tag.rowsAffected != 1) {
      // TODO better error
      throw Exception();
    }
  }
}

const userDB = UserDBImpl();