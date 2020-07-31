import 'dart:async';

import 'package:fruts/src/core/plant_list.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class FrutsDatabase {
  // Singleton instance
  static final FrutsDatabase _singleton = FrutsDatabase._();

  // Singleton accessor
  static FrutsDatabase get instance => _singleton;

  Completer<Database> _dbOpenCompleter;

  FrutsDatabase._();

  // Sembast database object

  // Database object accessor
  Future<Database> get database async {
    // If completer is null, FrutsDatabase class is newly instantiated, so database is not yet opened
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();

      _openDatabase();
    }

    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final frutsDir = await getApplicationDocumentsDirectory();

    await frutsDir.create(recursive: true);

    final dbPath = join(frutsDir.path, 'fruts.db');

    var store = intMapStoreFactory.store('plant__');

    final _database = await databaseFactoryIo.openDatabase(
      dbPath,
      version: 1,
      onVersionChanged: (_database, oldVersion, newVersion) async {
        if (oldVersion == 0) {
          await store.addAll(
            _database,
            Plants.values.map((e) => e.toJson()).toList(),
          );
        }
      },
    );

    _dbOpenCompleter.complete(_database);
  }
}
