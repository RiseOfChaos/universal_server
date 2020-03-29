import 'package:libpg/libpg.dart';

class DBConfig {
  final String url;

  DBConfig(this.url);
}

class Config {
  final DBConfig db;
  
  PGPool pool;

  Config(this.db) {
    pool = PGPool(ConnSettings());
  }
}