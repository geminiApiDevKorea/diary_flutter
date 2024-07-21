import 'package:diary_flutter/data/repository/google_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_auth_repository_provider.g.dart';

@Riverpod(keepAlive: false)
GoogleAuthRepository googleAuthRepository(GoogleAuthRepositoryRef ref) {
  return GoogleAuthRepository();
}
