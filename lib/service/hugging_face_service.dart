import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

/// HuggingFaceService enables you to get meaning for words.
class HuggingFaceService {
  static final Dio _dio = Dio(
    BaseOptions(
        baseUrl: 'https://api-inference.huggingface.co',
        contentType: 'application/json',
        validateStatus: (status) {
          return status! < 510;
        }),
  );
  final _cacheOption = CacheOptions(store: MemCacheStore());

  static HuggingFaceService? _instance;

  HuggingFaceService._() {
    _dio.interceptors.add(DioCacheInterceptor(options: _cacheOption));
  }

  factory HuggingFaceService() {
    _instance ??= HuggingFaceService._();
    return _instance!;
  }

  /// Generate speech from provided text and save audio to the provided file path.
  ///
  ///
  /// If Speech generation fails, it throws an [Exception].
  ///
  static Future<void> generateSpeech(
      String accessToken, String text, String filePath) async {
    final data = {
      "inputs": text,
      "options": {"wait_for_model": true}
    };
    try {
      final response = await _dio.post("/models/facebook/mms-tts-yor",
          data: data,
          options: Options(
              headers: {"Authorization": "Bearer $accessToken"},
              responseType: ResponseType.bytes));
      if (response.statusCode == HttpStatus.ok) {
        _saveBytesToFile(response.data, filePath);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Saves bytes to a file.
  ///
  ///
  /// If [path] identifies an existing file, that file is
  /// removed first.
  ///
  /// If existing file cannot be deleted, then it throws a
  /// [FileSystemException].
  static Future<void> _saveBytesToFile(List<int> bytes, String path) async {
    File file = File(path);
    if (file.existsSync()) file.deleteSync();
    file =
        await file.writeAsBytes(bytes, mode: FileMode.writeOnly, flush: true);
  }
}
