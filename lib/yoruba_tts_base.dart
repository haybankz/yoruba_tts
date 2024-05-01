import 'package:yoruba_tts/service/hugging_face_service.dart';

/// Wrapper class for public facing functions
class YorubaTts {

  /// Generates speech from provided text and save audio to the provided file path.
  ///
  ///
  /// If Speech generation fails, it throws an [Exception].
  ///
  static Future<void> generate(
      {required String accessToken,
      required String text,
      required String filePath}) async {
    return HuggingFaceService.generateSpeech(accessToken, text, filePath);
  }
}
