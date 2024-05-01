# Yoruba TTS flutter package

Check out
[Hugging Face homepage](https://huggingface.co/)

## Getting Started

With Dart
```bash
dart pub add yoruba_tts
dart pub get
```

With Flutter
```bash
flutter pub add yoruba_tts
flutter pub get
```


## How to use

See [example](https://github.com/haybankz/yoruba_tts/blob/main/example/example.dart) for more use case information.

```dart
void main() async {
  // set file path
  final path = "<file path to save speech .flac file>";
  final accessToken = "<Access token generated from Hugging Face Website>";
  final text = "Ẹ̀yà Yorùbá ni mo ti wá";
  YorubaTts.generate(accessToken: accessToken, text: text, filePath: path);
   // do play, upload or do whatever with .flac file
}
```
