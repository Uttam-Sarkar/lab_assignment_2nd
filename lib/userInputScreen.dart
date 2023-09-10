import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:lab_assignment_2nd/userListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lab_assignment_2nd/userData.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:path_provider/path_provider.dart';


class UserInputScreen extends StatefulWidget {
  @override
  _UserInputScreenState createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {

  final _userNameController = TextEditingController();
  final _userDialogueController = TextEditingController();
  String defaultImagePath = 'assets/images/default.jpg';
  XFile? _pickedImage = XFile('assets/images/default.jpg');// default pic.
  Uint8List? _editedImageBytes; // To hold the edited image as bytes
  bool isEditMode = false; // Added a flag to track edit mode
  final GlobalKey<SignatureState> _signatureKey = GlobalKey(); // for drawing
  final GlobalKey _repaintBoundaryKey = GlobalKey();


  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = pickedImage;
        isEditMode = false; // Disable edit mode when selecting a new image
      });
    }
  }


  void _toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  Future<void> _captureEditedImage() async {
    final boundary = _repaintBoundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    setState(() {
      _editedImageBytes = buffer;
     // _pickedImage = _editedImageBytes as XFile?;
    });
  }

  Future<void> saveUserImage() async {
    if (_editedImageBytes != null) {
      final directory = await getApplicationDocumentsDirectory(); // Get the app's documents directory
      final imagePath = '${directory.path}/user_image.png'; // Define the file path

      final File imageFile = File(imagePath);
      await imageFile.writeAsBytes(_editedImageBytes as List<int>); // Write the image bytes to the file
      _pickedImage = XFile(imagePath);

      print('hello $imagePath');
      // Now, `imagePath` contains the path to the saved image file.
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
              Stack(
                children: [

                  if (_pickedImage != null  && isEditMode)
                    Image.file(File(_pickedImage!.path)),
                  if (_editedImageBytes != null ) // Show edited image
                    Image.memory(_editedImageBytes!),
                  if (isEditMode)
                    Signature(
                      color: Colors.red,
                      strokeWidth: 5.0,
                      key: _signatureKey,
                    ),
              ],
            ),
              if (_pickedImage != null && !isEditMode)
                CircleAvatar(
                  backgroundImage: FileImage(File(_pickedImage!.path)),
                  radius: 50,
                ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: _toggleEditMode, // Toggle edit mode
                child: Text(isEditMode ? 'Save' : 'Edit'), // Change button text based on edit mode
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(labelText: 'User Name'),
              ),
              TextFormField(
                controller: _userDialogueController,
                decoration: InputDecoration(labelText: 'User Dialogue'),
              ),
              SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  if (_userNameController.text.isNotEmpty && _pickedImage != null) {
                    print('uttttttttttttttt');
                    print(isEditMode);
                    if (isEditMode) {
                      _captureEditedImage(); // Capture the edited image
                      saveUserImage();

                    } else {
                       saveUserImage();// why it doesnt work;
                         print(_pickedImage!.path);


                      print('bal');
                      // Add code to handle the user data without saving the edited image


                      userList.add(UserData(userName: _userNameController.text,
                          userDialogue: _userDialogueController.text,
                          imagePath: _pickedImage!.path));
                      setState(() {
                        _userNameController.clear();
                        _userDialogueController.clear();
                        _pickedImage = XFile(defaultImagePath); // After taking a pic it will set the default pic again.
                      });
                    }
                  }
                },
                child: Text('Add User'),
              ),
              SizedBox(height: 20,),
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
