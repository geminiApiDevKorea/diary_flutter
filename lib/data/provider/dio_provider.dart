import 'package:diary_flutter/data/provider/persistance_storage_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: false)
Dio dio(DioRef ref, {required String baseUrl}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
    ),
  );
  // dio.interceptors.addAll([AuthInterceptor(ref)]);
  return dio;
}

class AuthInterceptor extends Interceptor {
  final Ref ref;

  AuthInterceptor(this.ref);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['idToken'] == 'true') {
      final persistanceStroage = ref.read(persistanceStorageProvider);

      final token = persistanceStroage.getValue<String>('id_token');

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = "Bearer $token";
      }
    }

    return handler.next(options);
  }
}
