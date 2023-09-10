import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class UserDataDetailScreen extends StatelessWidget {
  final String userName;
  final String userDialogue;
  final String imagePath;

  UserDataDetailScreen({required this.userName,required this.userDialogue, required this.imagePath});


  // speaking
  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);// .5 to 1.5
    await flutterTts.speak(text);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.blue,
                height: 300,
                width: 300,
                child: Image.file(File(imagePath)),
              ),
              SizedBox(height: 10),
              Text(
                userName,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              Text(
                userDialogue,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: (){
                speak(userDialogue);

              }, child: Text('Speak'))
            ],
          ),
        ),
      ),
    );
  }
}


