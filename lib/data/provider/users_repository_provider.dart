import 'package:diary_flutter/data/provider/dio_provider.dart';
import 'package:diary_flutter/data/repository/users_repository.dart';
import 'package:diary_flutter/env/env.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_repository_provider.g.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<dynamic> login({required String bearerIdToken}) async {
    // final headers = <String, dynamic>{};
    // if (bererIdToken != null) {
    //   headers['Authorization'] = 'Bearer $_idToken';
    // }

    // final response = await _dio.post(
    //   '/',
    //   options: Options(headers: headers),
    // );

    // return response.data;
    return await UsersRepository(_dio).login(bearerIdToken: bearerIdToken);
  }

  @override
  Future<dynamic> me() async {
    return await UsersRepository(_dio).me();
  }
}

@riverpod
UsersRepositoryImpl usersRepository(UsersRepositoryRef ref) {
  final dio = ref.watch(dioProvider(baseUrl: Env.baseUrl));
  return UsersRepositoryImpl(dio);
}
