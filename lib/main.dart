import 'package:diary_flutter/app.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:diary_flutter/data/storage/shared_preference_persistance_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferencePersistanceStorage = SharedPreferencePersistanceStorage(
    sharedPreferences: await SharedPreferences.getInstance(),
  );
  runApp(
    ProviderScope(
      overrides: [
        persistanceStorageProvider.overrideWith(
          (ref) => sharedPreferencePersistanceStorage,
        ),
      ],
      child: const App(),
    ),
  );
}
