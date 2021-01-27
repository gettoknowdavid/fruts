import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class FrutsDatabase {
  static Future init() async => await _initSembast();
  
  static Future _initSembast() async {
    final dir = await getApplicationDocumentsDirectory();

    await dir.create(recursive: true);

    final path = join(dir.path, 'the_fruts.db');

    final instance = await databaseFactoryIo.openDatabase(path);

    GetIt.I.registerSingleton<Database>(instance);
  }
}
