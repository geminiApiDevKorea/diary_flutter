import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: false)
Dio dio(DioRef ref, {required String baseUrl}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
    ),
  );
  dio.interceptors.addAll([
    PrettyDioLogger(requestBody: true),
  ]);
  return dio;
}
