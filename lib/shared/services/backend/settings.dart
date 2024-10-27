import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/app_config.dart';

Future<void> loadBackend() async {
  await Supabase.initialize(
    url: AppConfig.backendUrl,
    anonKey: AppConfig.key,
  );
}
