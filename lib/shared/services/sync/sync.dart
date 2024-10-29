import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:powersync/powersync.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../backend/backend.dart';
import 'migrations/fts_setup.dart';
import 'schema.dart';
import 'settings.dart';

class Sync {
  late final PowerSyncDatabase db;

  final Backend _backend;

  Sync({required Backend backend}) : _backend = backend;

  String? get userId => _backend.userId;

  Future<String> getDatabasePath() async {
    const dbFilename = 'powersync-to-do.db';

    final dir = await getApplicationSupportDirectory();
    return join(dir.path, dbFilename);
  }

  Future<void> openDatabase() async {
    // Open the local database
    db = PowerSyncDatabase(
      schema: schema,
      path: await getDatabasePath(),
      logger: attachedLogger,
    );
    await db.initialize();

    SupabaseConnector? currentConnector;

    if (_backend.isLogged) {
      // If the user is already logged in, connect immediately.
      // Otherwise, connect once logged in.
      currentConnector = SupabaseConnector();
      db.connect(connector: currentConnector);
    }

    _backend.onAuthStateChanges.listen((data) async {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        // Connect to PowerSync when the user is signed in
        currentConnector = SupabaseConnector();
        db.connect(connector: currentConnector!);
      } else if (event == AuthChangeEvent.signedOut) {
        // Implicit sign out - disconnect, but don't delete data
        currentConnector = null;
        await db.disconnect();
      } else if (event == AuthChangeEvent.tokenRefreshed) {
        // Supabase token refreshed - trigger token refresh for PowerSync.
        currentConnector?.prefetchCredentials();
      }
    });

    // Demo using SQLite Full-Text Search with PowerSync.
    // See https://docs.powersync.com/usage-examples/full-text-search for more details
    await configureFts(db);
  }

  /// Explicit sign out - clear database and log out.
  Future<void> logout() async {
    await _backend.signOut();
    await db.disconnectAndClear();
  }
}
