import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'Config.dart';

class Storage {
  final Config config;

  Storage({
    required this.config,
  });

  Future<void> init() async {
    sqfliteFfiInit();
    final Database db = await databaseFactoryFfi.openDatabase(
      config.dataDir + '/database/system.db',
    );
    print('>>> sqlite db: ' + db.toString() + "\n");
  }
}
