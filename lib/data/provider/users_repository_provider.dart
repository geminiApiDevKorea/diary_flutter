import 'package:diary_flutter/data/provider/dio_provider.dart';
import 'package:diary_flutter/data/repository/users_repository.dart';
import 'package:diary_flutter/env/env.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_repository_provider.g.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersRepositoryImpl(this._dio, this._idToken);

  final Dio _dio;
  final String? _idToken;

  @override
  Future<dynamic> login(Map<String, dynamic> body) async {
    final headers = <String, dynamic>{};
    if (_idToken != null) {
      headers['idToken'] = _idToken;
    }

    final response = await _dio.post(
      '/',
      data: body,
      options: Options(headers: headers),
    );

    return response.data;
  }

  @override
  Future<dynamic> me() async {
    return await UsersRepository(_dio).me();
  }
}

@riverpod
UsersRepository usersRepository(UsersRepositoryRef ref) {
  final dio = ref.watch(dioProvider(baseUrl: Env.baseUrl));
  return UsersRepository(dio);
}
