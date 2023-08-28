// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
//
// class TextToSpeech {
//
//   final FlutterTts flutterTts = FlutterTts();
//   final String speech;
//   TextToSpeech({required this.speech});
//
//   speak(String text) async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.setPitch(1);// .5 to 1.5
//     await flutterTts.speak(text);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return speak(speech);
//   }
// }