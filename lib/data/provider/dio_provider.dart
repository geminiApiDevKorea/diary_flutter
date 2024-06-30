import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: false)
Dio dio(DioRef ref, {required String baseUrl}) {
  return Dio(
    BaseOptions(
      baseUrl: baseUrl,
    ),
  );
}
