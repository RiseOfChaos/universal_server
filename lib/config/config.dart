import 'package:libpg/libpg.dart';

class SessionConfig {
  String jwtKey;

  Duration expiry;
}

class

class DBConfig {
  final String url;

  DBConfig(this.url);
}

class Config {
  final DBConfig db;

  final SessionConfig session;
  
  PGPool pool;

  Config(this.db) {
    pool = PGPool(ConnSettings());
  }
}