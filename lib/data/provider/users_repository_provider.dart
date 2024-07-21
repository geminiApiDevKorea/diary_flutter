import 'package:diary_flutter/data/provider/dio_provider.dart';
import 'package:diary_flutter/data/repository/users_repository.dart';
import 'package:diary_flutter/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_repository_provider.g.dart';

@riverpod
UsersRepository usersRepository(UsersRepositoryRef ref) {
  final dio = ref.watch(dioProvider(baseUrl: Env.baseUrl));
  return UsersRepository(dio);
}
