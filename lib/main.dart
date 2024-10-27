import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'app.dart';
import 'core/dependency_injection/dependency_injection.dart';
import 'shared/services/backend/settings.dart';
import 'shared/services/sync/sync.dart';

FutureOr<void> main() async {
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print(
          '[${record.loggerName}] ${record.level.name}: ${record.time}: ${record.message}');

      if (record.error != null) {
        print(record.error);
      }
      if (record.stackTrace != null) {
        print(record.stackTrace);
      }
    }
  });
  WidgetsFlutterBinding.ensureInitialized();
  await loadBackend();
  setup();
  await getIt<Sync>().openDatabase();
  runApp(App());
}
