import 'dart:io';
import 'package:lab_assignment_2nd/userListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lab_assignment_2nd/userData.dart';

class UserInputScreen extends StatefulWidget {
  @override
  _UserInputScreenState createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {


  final _userNameController = TextEditingController();
  final _userDialogueController = TextEditingController();
  XFile? _pickedImage;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(labelText: 'User Name'),
              ),
              TextFormField(
                controller: _userDialogueController,
                decoration: InputDecoration(labelText: 'User Dialogue'),
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              if (_pickedImage != null)
                Image.file(File(_pickedImage!.path)),
              ElevatedButton(
                onPressed: () {
                  if (_userNameController.text.isNotEmpty && _pickedImage != null) {
                    userList.add(UserData(userName: _userNameController.text, userDialogue: _userDialogueController.text, imagePath: _pickedImage!.path));
                    setState(() {
                      _userNameController.clear();
                      _pickedImage = null;
                    });
                  }
                },
                child: Text('Add User'),
              ),
              ElevatedButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserListScreen()),
                );

              }, child: Text('Show All Story'))
            ],
          ),
        ),
      ),
    );
  }
}
