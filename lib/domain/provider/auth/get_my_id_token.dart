import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';

part 'get_my_id_token.g.dart';

@riverpod
String? getMyIdToken(GetMyIdTokenRef ref) {
  final persistanceStorage = ref.watch(persistanceStorageProvider);
  return persistanceStorage.getValue<String>("id_token");
}
